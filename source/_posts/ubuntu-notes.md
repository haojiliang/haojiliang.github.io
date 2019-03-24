---
title: ubuntu 笔记
post_url: ubuntu-notes
date: 2019-01-12 17:07:28
tags: ubuntu 笔记
---
1. 设置 root 密码：sudo passwd root

2. 开启 root 远程登录：/etc/ssh/sshd_config 中 PermitRootLogin 改为 yes，StrictModes 改为 yes
然后：sudo service ssh restart

3. Ubuntu16 配置静态 ip：https://www.jianshu.com/p/d69a95aa1ed7
ubuntu18 配置静态 ip：https://blog.csdn.net/u010039418/article/details/80934346

4. 查询软件：apt-cache madison kubeadm
![](/images/20190117141627122.png)
安装指定版本：apt-get install -y kubeadm=1.11.6-00
彻底卸载软件：
   删除软件及其配置文件  apt-get --purge remove kubeadm
   删除没用的依赖包  apt-get autoremove kubeadm
   此时dpkg的列表中有“rc”状态的软件包，可以执行如下命令做最后清理  dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P

5. 关闭防火墙
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F