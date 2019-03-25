---
post_url: xpack-password
title: xpack忘记密码
date: 2019-03-18 16:30:30
tags: [xpack, kibana, elasticsearch]
---

1、集群停机
2、备份plugin下的xpack 并删除
3、重启集群
4、删掉 .security 索引
5、停机
6、恢复plugin下的xpack
7、重启集群（现在密码已经重置为changeme了）
8、直接修改密码（后续步骤不用看了）
```
curl -XPUT -u elastic 'http://127.0.0.1:9200/_xpack/security/user/elastic/_password' -d '{
"password" : "123456"
}'
```
9、修改kibana配置文件elastic的密码改为changeme并启动
10、使用kibana修改elastic密码
11、kibana停机重新修改配置文件为新密码
12、重启kibana 并测试es使用新密码连接
