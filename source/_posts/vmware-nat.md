---
post_url: vmware-nat
title: vmware 虚拟机三种网络连接类型的区别，CentOS 设置静态 ip
date: 2018-11-18 11:12:20
tags: vmware
---
1.虚拟机三种网络连接类型：

桥接模式：虚拟机加入到宿主机所在局域网，可以和宿主机所在局域网内其他机器互相访问。就像是局域网中的一台独立的主机。

nat 模式：虚拟机和宿主机组成局域网，只能宿主机和虚拟机之间互相访问。虚拟机在对外访问时，使用的则是宿主机的IP地址，通过宿主机所在的网络来访问公网，这样从外部网络来看，只能看到宿主机，完全看不到新建的虚拟局域网。

仅主机模式：仅虚拟机之间组成局域网，只能是虚拟机之间互相访问（虚拟机和宿主机组成局域网，只能宿主机和虚拟机之间互相访问，但是虚拟机不能访问外网？）。
![](/images/20181126084920478.jpg)

2.配置静态 ip：

$ vim /etc/sysconfig/network-scripts/ifcfg-ens33***

$ service network  restart
```
### 后面加注释的是需要配置或修改的 ###
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="static" # dhcp 改为 static
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="677880e2-3e4f-4b7a-9ecb-3c27bef5656c"
DEVICE="ens33"
ONBOOT="yes" # yes
 
GATEWAY=192.168.0.1 # 网关，nat 模式下是虚拟机网络的网关，桥接模式下就是宿主机的网关
IPADDR=192.168.0.171 # 当前虚拟机 ip，不要和局域网内其他机器冲突即可
NETMASK=255.255.255.0 # 子网掩码
DNS1=202.102.128.68 # DNS1 直接配置为宿主机
DNS2=202.102.134.68 # DNS2
```

此外：Ubuntu16 和 Ubuntu18 配置静态 ip 参考：https://blog.csdn.net/iaiot/article/details/86366225


一直想买个 dell R740，可是好贵。正好有一台闲置电脑装了vmware，按照上述配置桥接模式，先当服务器用着，一台旧电脑又可以发挥价值了，哈哈哈~
