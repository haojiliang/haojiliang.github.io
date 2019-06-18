---
post_url: regexp
title: 正则表达式笔记 优化 性能测试
date: 2019-06-10 17:36:54
tags: 正则表达式
---

# 分组捕获
分组捕获又分为两种，一种是自定义命名的分组，还有一种是未命名的分组（或者称为自动编号分组）  
命名分组的格式为：(?&lt;name&gt;X)  其中X表示一个正则表达式  如：(?&lt;ip&gt;[\d]{1,3}.[\d]{1,3}.[\d]{1,3}.[\d]{1,3})  

# DFA NFA
JDK 中的正则是 NFA 实现的  
java DFA 开源实现：https://github.com/zhztheplayer/DFA-Regex  
DFA 速度快但是部分正则功能不支持  
https://www.jb51.net/article/31168.htm  

# 性能优化
1.减少回溯  
2.对固定正则在循环前提前编译 Pattern.compile  
3.使用位置匹配符号 ^ 和 $  
4.使用 DFA 正则引擎   
5.参考文章：  
https://www.jianshu.com/p/bbf3c382fd30  
https://blog.csdn.net/csdncjh/article/details/51191616  
http://blog.chacuo.net/329.html  
http://blog.chacuo.net/255.html  
https://my.oschina.net/u/3147332/blog/807081  
https://segmentfault.com/a/1190000000735725  

# 性能测试工具
RegexBuddy4.9  
http://blog.chacuo.net/238.html  