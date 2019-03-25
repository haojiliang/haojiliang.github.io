---
title: fastjson中getLong("")返回的是Long类型，不能直接用“==”比较
post_url: fastjson
date: 2018-05-16 18:16:28
tags: java
---
fastjson中getLong("")返回的是Long类型，不能直接用“==”比较；

如需比较要使用getLongValue("")，getLongValue返回的是long类型的；


user.getLong("mid") != fileDetail.getLong("mid")
user.getLongValue("mid") == fileDetail.getLongValue("mid")
