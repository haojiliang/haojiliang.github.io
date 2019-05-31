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
单例模式：  
观察者模式：  
工厂模式：  
适配器模式：  
...  

# Java 堆栈
堆：存放对象数据；操作系统自动释放；快；  
栈：存放 java 基本数据类型；由程序员、jvm 释放；慢；  
原理详解：https://blog.iaiot.com/java_stack.html

# Java gc

# 红黑树

# elasticsearch 性能优化

# 微服务 集群 分布式
微服务：多模块  
集群：多节点  
分布式：多机器  

# linux 查看 Exception 前后 5 行
前后5行：cat access.log | grep -5 "Exception"  
前后5行：cat access.log | grep -C 5 "Exception"  
后5行：cat access.log | grep -A 5 "Exception"  
前5行：cat access.log | grep -B 5 "Exception"  

# 线程池 数据库连接池
为什么要用池：复用，不需要频繁创建销毁  

# kafka 实现原理 存储原理

# elasticsearch 大量数据查询速度怎么优化

# mysql 存储过程

# java 中哪些数据类型是链表，哪些是数组

# sql 优化
适量使用索引  
避免使用 select *

# 未完待续