---
post_url: select-concat-group_concat
title: MySQL 查询结果返回数组或 JSON XML 等自定义格式 SELECT CONCAT GROUP_CONCAT
date: 2018-12-22 17:52:16
tags: mysql
---

```sql
SELECT sub_name,
  CONCAT('[',
  GROUP_CONCAT(
  CONCAT('{"name":"', sub_name, '",'),
  CONCAT('"id":"', id, '"}')),
  ']') AS child
FROM secret
WHERE 1 = 1
GROUP BY sub_name
limit 0, 10
```
这样 MySQL 返回的 child 值是一个字符串，在代码中转成需要的格式
```java
for (JSONObject child : items) {
    child.put("child", JSON.parseArray(child.getString("child")));
}
```