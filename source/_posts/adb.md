---
post_url: adb
title: adb 无线连接安卓设备调试程序方法
date: 2018-08-18 22:52:03
tags: [adb, android]
---
1. 在安卓手机端下载 终端模拟器 app 并安装

附下载地址：https://download.csdn.net/download/iaiot/10612935

运行程序在终端模拟器的命令行输入如下命令：

setprop service.adb.tcp.port 5555

stop adbd

start adbd

 

2. 在电脑cmd下输入如下指令

adb connect 192.168.1.116:5555
![](/images/20180818224047613.png)


3. Android Studio中直接运行程序即可。
