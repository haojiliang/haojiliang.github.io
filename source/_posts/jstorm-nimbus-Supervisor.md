---
post_url: jstorm-nimbus-Supervisor
title: Jstorm 启动后 nimbus、Supervisor 自动停止
date: 2018-05-22 11:18:54
tags: jstorm
---
情景1：以前可以，异常关机重启后不行了。。。

原因1：jstorm 进程异常终止，导致 storm data 目录下的数据异常；

解决：删除 Jstorm data 目录里面的内容，再重新启动~


情景2：第一次安装的，从节点 Supervisor 可以正常启动，主节点的 nimbus 和 Supervisor 启动后接着停止（nimbus 甚至直接不启动）；

原因：未配置 hostname
![](/images/20180619190149680.jpeg)


解决：1.vim /etc/hosts...............在里面加入 hostname....

例：10.168.13.147 storm-m  （其中 10.168.13.147 为内网 ip，非 127.0.0.1）

 

2.vim /etc/sysconfig/network .............在里面改过来

 

例：HOSTNAME=storm-m

3.service network restart

参考：http://www.jstorm.io/QuickStart_cn/Deploy/Standalone.html
