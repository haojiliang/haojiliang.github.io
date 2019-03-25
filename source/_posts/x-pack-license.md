---
title: 『转载』x-pack license 过期
post_url: x-pack-license
date: 2019-03-18 11:47:35
tags: [xpack, kibana, elasticsearch]
---


## 原文
http://www.lanrenkaifa.com/post/61
http://blog.51yip.com/server/1906.html


## 总结
kibana x-pack安装完了后，license有效期只有1个月，并且每年需要，要重新续一次。
1. 注册   https://register.elastic.co/
2. 登录到注册的邮件，里面会有一个下载license的邮件。
3. 通过curl，重新续一下license，注意：文件名前面有一个@符号
```shell
curl -XPUT -u elastic:xxxxxxx 'http://localhost:9200/_xpack/license?acknowledge=true&pretty' -H "Content-Type: application/json" -d @hao-jiliang-a07994e8-9e65-404c-a8d1-4d84cbe62fc8-v5.json
```
4. 查看license状态：
```shell
curl -XGET -u admin:123456 'localhost:9200/_xpack/license'
```