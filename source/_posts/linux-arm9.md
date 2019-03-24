---
post_url: linux-arm9
title: 把电脑虚拟机linux下编译的程序烧写到ARM9开发板的linux系统里面的具体操作步骤
date: 2015-12-31 16:52:08
tags:
---
## 首先在Linux虚拟机下操作的：

①、cd /mnt/hgfs/share（share是在VM里面设置的Linux虚拟机和Windows共享的文件夹）
②、cd ZigbeeCom （到该文件夹下面看一下只有那四个文件）
③、make （make编译之后就会生成ZigbeeCom文件）
④、cp /mnt/hgfs/share/ZigbeeCom/ZigbeeCom /test
⑤、ifconfig(查看虚拟机ip地址和子网掩码并修改以便通过网线将文件烧写到开发板中)
⑥、ifconfig eth0 192.168.1.100 netmask 255.255.255.0 up
## 然后到DNW下（操作开发板内的文件了）：
⑦、用网线把开发板和电脑连接起来
⑧、进入arm9开发板内的Linux系统
⑨、ls
⑩、ifconfig
⑪、ifconfig eth0 192.168.1.200 netmask 255.255.255.0 up
⑫、mount -o tcp,nolock 192.168.1.100:/test /mnt（mnt文件夹叫挂载点，挂载到/mnt下面）
⑬、cp /mnt/ZigbeeCom /sample
⑭、cd /sample
⑮、用网线把开发板连接到路由器的lan口上
⑯、./ZigbeeCom
⑰、手机app连接到路由器的无线网上
⑱、app上的ip地址填设置的开发板的ip地址192.168.1.200（端口7081自己在serverthread.c中设置）

 

⑲、然后app发送相应口令获取数据

 

这是我们做的微信云智能火灾防控系统。实现了微信端，手机APP端，网页端的远程监测及控制。以后有时间会陆续把整个系统的实现分享给大家。
![](/images/20151231172153087.png)