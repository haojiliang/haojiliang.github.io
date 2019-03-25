---
post_url: es-nostop-up-mapping
title: Elasticsearch Changing Mapping with Zero Downtime（ES 不停机更新 mapping）
date: 2018-10-08 22:18:04
tags: elasticsearch
---
官方地址：https://www.elastic.co/cn/blog/changing-mapping-with-zero-downtime
## 官方原文
Editor's Note (May 1, 2017): This blog was originally published several major versions of Elasticsearch ago.  Since then, new mappings have been made available, but more importantly, new features like the Reindex API have made tasks like this substantially easier.  The below post remains for archival purposes, but it's recommended you read over the linked reindex blog for a more modern approach to the reindex challenge.

Update November 2, 2015: Make sure to check out the updates with Elasticsearch mappings introduced in the 2.0 release.

A developer I know sent me a tweet saying:

My biggest problem with using Elastic Search as my model is that I have to reindex whenever I make a schema change. With the size of the data sets that takes a long ass time, and that results in a lot of down time for me. Too much for most applications.

It is quite possible to make schema/mapping changes with zero downtime, but there are too many options available to explain in a tweet, hence this blogpost.

**The problem — Why you can't change mappings**
You can only find that which is stored in your index. In order to make your data searchable, your database needs to know what type of data each field contains and how it should be indexed. If you switch a field type from e.g. a string to a date, all of the data for that field that you already have indexed becomes useless. One way or another, you need to reindex that field.

This applies not just to Elasticsearch, but to any database that uses indices for searching. And if it isn't using indices then it is sacrificing speed for flexibility.

Elasticsearch (and Lucene) stores its indices in immutable segments — each segment is a “mini" inverted index. These segments are never updated in place. Updating a document actually creates a new document and marks the old document as deleted. As you add more documents (or update existing documents), new segments are created. A merge process runs in the background merging several smaller segments into a new big segment, after which the old segments are removed entirely.

Typically, an index in Elasticsearch will contain documents of different types. Each _type has its own schema or mapping. A single segment may contain documents of any type. So, if you want to change the field definition for a single field in a single type, you have little option but to reindex all of the documents in your index.

**Adding fields is free**
A segment only contains indices for fields that actually exist in the documents for that segment. This means that you can add new fields for free, using the put_mapping API. There is no need to reindex.

**Reindexing your data**
The process for reindexing your data is quite simple. First, create a new index with the new mapping and settings:
```
curl -XPUT localhost:9200/new_index -H 'Content-Type: application/json' -d '
{
    "mappings": {
        "my_type": { ... new mapping definition ...}
    }
}
'
```
Then, pull the documents in from your old index, using a scrolled search and index them into the new index using the bulk API. Many of the client APIs provide a reindex() method which will do all of this for you. Once you are done, you can delete the old index.

Note: make sure that you include search_type=scan in your search request. This disables sorting and makes “deep paging" efficient.

The problem with this approach is that the index name changes, which means that you need to change your application to use the new index name

**Reindexing your data with zero downtime**
Index aliases give us the flexibility to reindex data in the background, making the change completely transparent to our application. An alias is like a symbolic link which can point to one or more real indices.

The typical workflow is as follows. First, create an index, appending a version or timestamp to the name:
```
curl -XPUT localhost:9200/my_index_v1 -H 'Content-Type: application/json' -d '
{ ... mappings ... }
'
```
Create an alias which points to the index:
```
curl -XPOST localhost:9200/_aliases -H 'Content-Type: application/json' -d '
{
    "actions": [
        { "add": {
            "alias": "my_index",
            "index": "my_index_v1"
        }}
    ]
}
'
```
Now your application can speak to my_index as if it were a real index.

When you need to reindex your data, you can create a new index, appending a new version number:
```
curl -XPUT localhost:9200/my_index_v2 -H 'Content-Type: application/json' -d '
{ ... mappings ... }
'
```
Reindex data from my_index_v1 to the new my_index_v2, then change the myindex alias to point to the new index, in a single atomic step:
```
curl -XPOST localhost:9200/_aliases -H 'Content-Type: application/json' -d '
{
    "actions": [
        { "remove": {
            "alias": "my_index",
            "index": "my_index_v1"
        }},
        { "add": {
            "alias": "my_index",
            "index": "my_index_v2"
        }}
    ]
}
'
```
And finally, delete the old index:
```
curl -XDELETE localhost:9200/my_index_v1
```
You have successfully reindexed all of your data in the background without any downtime. Your application is blissfully unaware that the index has changed.

While this is the standard approach to managing schema changes, there are a number of other options available to you, which I will discuss below.

**I don't care about old data**
What if you want to change the datatype for a single field, and you don't care about the fact that the old data is not searchable? In this case, you have a few options:

**Delete the mapping**
Update November 2, 2015: Please note that delete mappings are not supported in Elasticsearch 2.0+.

If you delete the mapping for a specific type, then you can use the put_mapping API. to create a new mapping for that type in the existing index.

```
Note: when you delete a mapping for a type, you also delete all documents of that type in the index.
```
This is particularly useful when you are wanting to change the mapping for a type which contains a small number of documents.

**Rename the field**
Adding new fields is free, so you could just add a new field with a different name and definition to use for all future documents. Of course, this means changing the fieldname used by your application.

**Upgrade to a multi-field**
Multi-fields allow a single field to be used for different purposes. A typical use case is to index e.g. a title field in two ways: as an analyzed string for querying, and as anot_analyzed string for sorting.

Any scalar field (ie excluding fields of type object or nested) can be upgraded to a multi-field without reindexing, using the put_mapping API. For instance, if we have a field called created which is currently mapped as a string:
```
{
    "created": { "type": "string"}
}
```
We can upgrade it to a multi-field, and add a date sub-field to it:
```
curl -XPUT localhost:9200/my_index/my_type/_mapping -H 'Content-Type: application/json' -d '
{
    "my_type": {
        "properties": {
            "created": {
                "type":   "multi_field",
                "fields": {
                    "created": { "type": "string" },
                    "date":    { "type": "date"   }
                }
            }
        }
    }
}
'
```
The original created field still exists as the “main" sub-field, and can be queried as created or created.created. The new date variant can be queried as created.date, and will only be populated for new documents.

**Using aliases for greater flexibility**
Sometimes the above approaches are not enough. Perhaps your application has 100,000 user documents and 10,000,000 blog documents. You want to change the mapping for theuser documents without having to reindex all of the blogs.

There is no reason that you can't store different types in different indices. Elasticsearch can search across multiple indices as easily as it can search across a single index. This way, you only need to reindex the index containing the type that you want to change. And with judicious use of aliases, the reindexing process can still be entirely transparent to your application.

With this approach, your application should use a separate alias for each type. For instance, instead of indexing to my_index, you would index user docs to my_index_user andblog docs to my_index_blog:
```
curl -XPOST localhost:9200/_aliases -H 'Content-Type: application/json' -d '
{
    "actions": [
        { "add": {
            "alias": "my_index_user",
            "index": "my_index_v2"
        }},
        { "add": {
            "alias": "my_index_blog",
            "index": "my_index_v2"
        }}
    ]
}
'
```
To search across user and blog documents, you can just specify both aliases:
```
curl localhost:9200/my_index_blog,my_index_user/_search
```
When you want to change the user mapping, first create a new index just for users, and choose the right number of primary shards for just user docs:
```
curl -XPUT localhost:9200/my_index_users_v1 -H 'Content-Type: application/json' -d '
{
    "settings": {
        "index": {
            "number_of_shards": 1
        }
    },
    "mappings": {
        "user": { ... new user mapping ... }
    }
}
'
```
Reindex just the user docs from the old index into the new:
```
curl 'localhost:9200/my_index_user/user?scroll=1m&search_type=scan' -H 'Content-Type: application/json' -d '
{
    "size": 1000
}
'
```
And update the alias:
```
curl -XPOST localhost:9200/_aliases -H 'Content-Type: application/json' -d '
{
    "actions": [
        { "remove": {
            "alias": "my_index_user",
            "index": "my_index_v2"
        }},
        { "add": {
            "alias": "my_index_user",
            "index": "my_index_user_v1"
        }}
    ]
}
'
```
You can use a delete-by-query request to remove the user docs from the old index:
```
curl -XDELETE localhost:9200/my_index_v1/user
```
From now on, any time you want to change the mapping for user docs, you can use the standard reindexing approach that I described above.

**Using aliases without reindexing**
If you want your changes to apply only to new documents, you can still use the aliases approach, without having to reindex. You would still create a new my_index_user_v1 index, but now you would create two aliases: my_index_user for indexing and my_index_users (plural) for searching:
```
curl -XPOST localhost:9200/_aliases -H 'Content-Type: application/json' -d '
{
    "actions": [
        { "add": {
            "alias": "my_index_user",
            "index": "my_index_user_v1"
        }},
        { "add": {
            "alias": "my_index_users",
            "index": "my_index_user_v1"
        }},
        { "add": {
            "alias": "my_index_users",
            "index": "my_index_v1"
        }},
    ]
}
'
```
The my_index_user alias points just to the new index, and all new user documents would be indexed using this alias. The my_index_users alias points to both the new index AND the old index. So you can search across both indices at the same time. The old index will use the old mapping, and the new index will use the new mapping.

As you can see, Elasticsearch provides a wealth of options for managing your indices and, with a little forethought, changes can be managed with zero downtime.

 

Editor’s Note (May 1, 2017): Starting with 6.0, any curl command to Elasticsearch containing content will require a valid content type header. As a result, this post has been updated to reflect this change and to set readers of this post up for success with future versions.

 

## 总结
es 修改 mapping，需要重建 index，之前的数据可以通过各种 api 进行 reindex。如果需要实现不停机更新 mapping，必须使用了索引别名 alias。此外，更新 mapping 必须重建索引的原因和具体实现参见上文。