---
post_url: redis-notes
title: Redis 笔记
date: 2018-11-18 22:28:58
tags: redis
---
1. 配置密码：在 redis.conf 中加入 requirepass yDvQ3t$hwoJvWree
配置密码后登录 redis：redis-cli -a 'yDvQ3t$hwoJvWree'
                 或: redis-cli 后 >> auth yDvQ3t$hwoJvWree
登录远程 redis：redis-cli -h 192.168.1.115 -p 6379
启动 redis：redis-server redis.conf &
启动 redis：nohup redis-server redis.conf &
附 nohup 说明：http://www.williamlong.info/archives/482.html
关闭 redis：src/redis-cli shutdown
配置密码后关闭 redis：redis-cli -a 'yDvQ3t$hwoJvWree' shutdown
配置数据持久化路径：redis.conf中dir /home/redis/redis-3.2.9/data/
这样可以避免在不同的目录里启动同一个 redis 时，造成没有使用上次持久化的数据，从而导致数据丢失

 

2. redis List 类型数据
查看list大小：LLEN lxinatklogs
通过索引获取list中元素：LINDEX lxinatklogs -1
获取指定范围内的元素的列表：LRANGE KEY_NAME 0 -1
其中索引 0 表示 list 中第一个元素，1 表示第二个元素，-1 表示倒数第一个元素，-2 表示倒数第二个元素...

 

3. redis 哈希数据
查看所有值：HGETALL  keyname
删除指定值：HDEL keyname [field ...]
        例：HDEL priCloudList field1 field2 field3


4. redis 常用命令
检查键是否存在：EXISTS KEY_NAME
获取存储在键中的值的数据类型：TYPE KEY_NAME
为多个键分别设置它们的值：MSET key1 "Hello" key2 "World"
