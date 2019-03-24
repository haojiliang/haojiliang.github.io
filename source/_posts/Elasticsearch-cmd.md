---
post_url: Elasticsearch-cmd
title: Elasticsearch常用命令整理
date: 2018-01-24 15:16:04
tags: Elasticsearch
---
在命令行查看Elasticsearch信息及数据，另有es head插件（可以自己安装，另外在谷歌浏览器扩展程序里也有），可以直接在网页中可视化操作Elasticsearch
![](/images/20180927081010321.png)

1. 查看Elasticsearch集群状态
```
curl http://10.1.1.113:9200/_cluster/health?pretty
```
2. 查看ES信息
```
curl -XGET '10.1.1.113:9200'
```
3. 获取所有索引的信息
```
curl -XGET '10.1.1.113:9200/_cat/indices?v&pretty'
```
4. 删除索引
```
curl -XDELETE '10.1.1.113:9200/indexname?pretty'
```
5. 获取所有文档数量
```
curl -XGET 'http://10.1.1.113:9200/_count?pretty' -d '
{
    "query": {
        "match_all": {}
    }
}
'
```
6. 索引一个文档并指定文档id为1
```
curl -XPUT '10.1.1.113:9200/indexname/employee/1?pretty' -H 'Content-Type: application/json' -d'
{
    "first_name" : "John",
    "last_name" :  "Smith",
    "age" :        25,
    "about" :      "I love to go rock climbing",
    "interests": [ "sports", "music" ]
}
'
```
7. 删除一个文档
```
curl -XDELETE '10.1.1.113:9200/indexname/employee/1/'
```
8. 创建一个索引
```
curl -XPUT http://10.1.1.113:9200/indexname
```
9. 未完待续...
附：Elasticsearch官方文档（中文）：https://www.elastic.co/guide/cn/elasticsearch/guide/cn/index.html
