---
title: 解决 fastJson 出现重复引用的问题 "$ref":"$[0].layout[0]....."
post_url: fastJson-$ref
date: 2019-01-09 09:53:25
tags: fastJson $ref
---

```java
JSONObject.put("k", jsonv);
→
JSONObject.put("k", jsonv.clone());
```
或
```java
String returnJson = JSON.toJSONString(map, SerializerFeature.DisableCircularReferenceDetect);
```