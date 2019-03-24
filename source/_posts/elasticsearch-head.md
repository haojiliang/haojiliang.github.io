---
post_url: elasticsearch-head
title: elasticsearch 笔记 elasticsearch-head
date: 2018-11-20 22:21:17
tags: elasticsearch
---
1. elasticsearch5.0 以上版本安装 elasticsearch-head

es5.1 中，elasticsearch-head
不能放在 elasticsearch 的 plugins、modules 目录下
不能使用 elasticsearch-plugin install
直接启动 elasticsearch 即可
安装 elasticsearch-head
elasticsearch/config/elasticsearch.yml 中添加
http.cors.enabled: true
http.cors.allow-origin: "*"
下载 elasticsearch-head 或者 git clone 到随便一个文件夹

安装 nodejs
cd /path/to/elasticsearch-head
npm install -g grunt-cli
npm install
grunt server
http://localhost:9100/
Enjoy it.
参考地址：https://segmentfault.com/q/1010000007827533
elasticsearch-head 地址：https://github.com/mobz/elasticsearch-head

 

2. elasticsearch-head 插件 更方便
![](/images/20181120222005471.png)


3. elsaticsearch
后台启动：./bin/elasticsearch –d
查看es进程号：ps –ef | grep elsatic
关闭：kill -9 es进程号