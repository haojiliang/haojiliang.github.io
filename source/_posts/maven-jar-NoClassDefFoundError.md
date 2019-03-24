---
title: Maven项目引用本地jar包，编译后出现java.lang.NoClassDefFoundError
post_url: maven-jar-NoClassDefFoundError
date: 2017-03-08 10:40:22
tags: maven
---
解决办法如下：

1. 首先在src目录下创建libs目录并把jar包复制进去，然后加到build path里面，确定加到build path里面后

2. 项目右键→Properties→Deployment Assembly→Add→Java Build Path Entries→Next→选择jar包→Finish→Apply→OK.

 

不需要再在pom.xml文件里面配置。

 

我遇到的问题：

我在使用支付宝的支付jar包，编译运行后出现java.lang.NoClassDefFoundError错误。我的项目中已经有commons-logging.jar包了，就没再重复导入。

 

如果提示缺少的是依赖工程中的类，就项目右键→Properties→Deployment Assembly→Add→Project→Next→选择工程→Finish→Apply→OK.
