---
title: docker volume 挂载文件后，容器内更新此文件，就报 Device or resource busy 不能保存文件
post_url: docker-volume-device-or-resource-busy
date: 2019-01-04 17:52:08
tags: docker volume Device or resource busy
---

## 问题
Error moving temp DB file temp-1.rdb on the final destination dump.rdb (in server root dir /usr/local/redis/data): Device or resource busy
## 原因
挂载路径改为目录，而不是文件
## 解决
如：/root/compose/data-volumes/redis/dump.rdb:/usr/local/redis/data/dump.rdb
改为
/root/compose/data-volumes/redis:/usr/local/redis/data
## 拓展
另外，如果挂载的是目录，如果要更新目录内容，也不能删除再创建，而是要操作挂载目录内部的文件。
不然就挂载不到容器内了，只能重启容器。