---
post_url: mybaits-int
title: mybaits int 类型的字段不能 <if test="sub_name != null and '' != field_name"> Java 移除 JSONObject 空值字段
date: 2018-12-13 19:15:54
tags: mybaits
---

mybaits int 类型的字段不能 <if test="sub_name != null and '' != field_name">

只能 <if test="sub_name != null">

如果 <if '' != field_name"> ，值为 0 时 if 条件为 false

可以直接在代码中移除空值字段
```java
    /**
     * 移除空值字段
     *
     * @param json json
     */
    public static void rmEmptyField(JSONObject json) {
        if (json != null) {
            // 遍历 json 副本，修改原 json，防止 ConcurrentModificationException
            JSONObject jsonCopy = (JSONObject) json.clone();
            Set<String> jsonKeys = jsonCopy.keySet();
            for (String jsonKey : jsonKeys) {
                // 移除空值字段
                if (json.getString(jsonKey) == null || "".equals(json.getString(jsonKey).trim())) {
                    json.remove(jsonKey);
                    continue;
                }
            }
        }
    }
```