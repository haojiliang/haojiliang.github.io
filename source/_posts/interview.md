---
post_url: interview
title: 面试笔记
date: 2018-05-09 16:27:08
tags: 
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

# mysql 引擎
常用：MyISAM、InnoDB  

|         | MyISAM     | InnoDB    |
| --------| ---------  | --------- |
| 事务     | 不支持      |  支持     |
| 性能     | 较高        | 较低        |
| 使用场景  | ①一般小小项目 ②大项目，需要分库分表、读写分离，为了提高性能，只读的可以用 MyISAM |  一般项目  |


  
# Java
## String StringBuffer StringBuffer
String 不可变  
StringBuffer 可变  线程安全 synchronized  
StringBuilder 可变  

## List(有序，元素可重复)
  ArrayList   底层是数组    数组               适用于查询较多的场景  
  LinkedList  底层是链表    效率高 占内存大     适用于增删较多的场景  
  Vector      底层是数组    线程安全           查询增删都很慢  
  
list自定义顺序：List自身有个sort方法可以实现，或者使用Collections.sort(list)  

## Map
  HashMap：  非线程安全. 底层是是数组+链表+红黑树（JDK1.8增加了红黑树部分）实现的，采用哈希表来存储的。  
  ConcurrentHashMap： 线程安全.  CAS算法（乐观锁）+synchronized 实现线程安全  
  TreeMap： 非线程安全. 有序  根据key排序，可以使用Comparator自定义顺序  
  LinkedHashMap： 继承HashMap，Iterator遍历时有序，按照插入顺序排序  

## 抽象类和接口
  抽象类可以实现方法，接口中只能声明方法；  
  抽象类中可以定义变量，接口中不能；接口中只能定义常量  
  抽象类中可以有静态方法，接口中不能；  

## 抽象类和普通类
  有未实现的声明方法的类就是抽象类；  
  抽象类不能被实例化；  

## 反射
  Proxy类实现，Class.forName 或 ClassLoader 加载类；  
  Cglib动态代理，性能高  

## final
  类：不能继承  
  方法：不能重写  
  变量：不能修改  

## 设计模式
  单例模式：一个类只能有一个实例，一般是通过synchronized实现，提供一个全局的访问方法  
  观察者模式：对象间的一对多的依赖关系，一个变了，其他的也执行相应的操作，如发布订阅  
  工厂模式：根据传入的参数决定要实例化的类  
  适配器模式：比如前段列表中的item，把item提取出来创建adapter，供多个list使用  
  
## 访问修饰符
  Private：同一个类  
  Default：同一个包  
  Protected：不同包的子类  
  Public：不同包的非子类  

## 泛型 重载 重写
泛型：把类型参数化了，所有的强制转换都是自动和隐式的。  
重载：在一个类里面，方法名字相同，而参数不同。返回类型可以相同也可以不同。  
重写：返回值和形参不变，内部实现重写；  

## 多线程实现方式
  实现runable接口；  
  继承thread类；  

## 线程状态
  新建，可运行，运行中，睡眠，阻塞，等待，死亡。  

## java8 stream

## java8 Lambda 表达式

## equals == hashCode
  equals 比较内容  
  == 比较地址  
  hashCode 可以看做是对象的地址  

