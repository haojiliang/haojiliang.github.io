---
post_url: linux-ping
title: 嵌入式Linux系统连不上外网，也ping不通外网解决办法
date: 2016-01-04 12:40:43
tags: linux
---
①、不仅要设置系统的ip地址和子网掩码（命令如下）：

ifconfig eth0 ***.***.***.*** netmask 255.255.255.0 up

（这里***.***.***.***是你要输入的ip地址）

②、还要设置系统的默认网关（命令如下）：

route add default gw ***.***.***.1
