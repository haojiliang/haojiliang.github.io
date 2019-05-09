---
post_url: es_cat_api
title: elasticsearch cat api 查询索引信息
date: 2019-05-09 14:55:20
tags: elasticsearch
---

```
curl -X GET "http://127.0.0.1:9201/_cat/indices?v&h=index,docs.count,store.size&s=store.size:desc"
```
v：有无标题  
h：返回的字段  
s：排序  

官方文档：https://www.elastic.co/guide/en/elasticsearch/reference/current/cat-indices.html


或者 _stats，这个要比 _cat 慢很多
```
curl -X GET "http://127.0.0.1:9201/_all/_stats"
```
