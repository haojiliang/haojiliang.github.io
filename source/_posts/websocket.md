---
title: webSocket 笔记 问题汇总 400 302 spring-websocket resin-websocket nginx-websocket
post_url: websocket-400-302-spring-resin-nginx
date: 2019-03-22 17:15:58
tags: [spring-websocket, resin-websocket, nginx-websocket]
---

## webSocket 400
![](/images/20190322173348403.png)
```
location /ws/createwebsocket {
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://my.api.iaiot.com:8080/ws/createwebsocket;

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
```

## webSocket 302
![](/images/20190322171006565.png)

## spring-websocket（4.2.5.RELEASE）
spring-websocket 不支持 resin，如果用 resin 部署服务，需基于 com.caucho.websocket.WebSocketListener 自己实现，或者依赖一个其他的 spring 支持的 websocket 包，如：
```
<dependency>
    <groupId>io.undertow</groupId>
    <artifactId>undertow-websockets-jsr</artifactId>
    <version>2.0.17.Final</version>
</dependency>
```
spring-websocket 支持的 RequestUpgradeStrategy：
![](/images/20190322171454875.png)
![](/images/20190322171428208.png)