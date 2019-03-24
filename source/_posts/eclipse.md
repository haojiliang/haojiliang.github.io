---
post_url: eclipse
title: 旧版本eclipse安装旧版本maven、server等插件
date: 2017-09-01 17:29:48
tags: eclipse
---

1. 需要装旧版本eclipse，要用里面的插件；
2. 比如我要用到maven和server；

3. 下载相同版本下的eclipse-jee和eclipse-java（因为eclipse-jee中有server，eclipse-java中有maven），

4. 分别解压后打开eclipse目录，直接复制eclipse-java目录下的所有文件到eclipse-jee根目录，提示有重复文件直接跳过；

5. 复制完后打开目标eclipse-jee目录下的eclipse，两个eclipse中的插件在这一个eclipse中就都有了，而且版本完全兼容；

6. eclipse各个版本官网下载地址：http://www.eclipse.org/downloads/packages/release/Juno/SR2
