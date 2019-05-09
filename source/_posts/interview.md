---
post_url: interview
title: 面试笔记
date: 2018-05-09 16:27:08
tags: 面试
---

# TCP UDP webSocket http
## TCP
传输层协议；三次握手（建立连接时）四次挥手（关闭连接时）  
## UDP
传输层协议；不建立连接，所以没有握手挥手的过程  
## webSocket
应用层协议  
长连接，服务端客户端可以互发消息  
## http
应用层协议  
http/1.0：默认短连接；建立连接 -> 传输数据 -> 断开连接  
http/1.1：默认长连接（Connection:keep-alive）；只能客户端主动给服务端发消息；建立连接 -> 传输数据 -> 保持连接 -> 传输数据 -> ... -> 保持连接 -> 传输数据 -> 断开连接  

# 设计模式

# Java 堆栈
https://blog.iaiot.com/java_stack.html

# 未完待续