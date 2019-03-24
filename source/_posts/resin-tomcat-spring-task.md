---
post_url: resin-tomcat-spring-task
title: resin、tomcat 中添加 host 配置后 spring 定时任务执行多次
date: 2019-02-15 17:16:38
tags: [tomcat spring task, resin spring task]
---

## tomcat
配置文件 server.xml 中 appBase="webapps" 改为 appBase=""
![](/images/20190215170932231.png)

## resin
配置文件 resin.xml 中 <web-app-deploy path="webapps" 改为 <web-app-deploy path="" 
![](/images/20190215171432824.png)