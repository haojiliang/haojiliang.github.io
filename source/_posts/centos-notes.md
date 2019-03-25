---
post_url: centos-notes
title: CentOS 防火墙、端口、端口转发、selinux、Windows 端口
date: 2018-11-20 21:28:30
tags: linux
---
## 防火墙基础操作
1) 重启后生效 
开启： chkconfig iptables on 
关闭： chkconfig iptables off 
2) 即时生效，重启后失效 
开启： service iptables start 
关闭： service iptables stop 
参考：https://zhidao.baidu.com/question/303901938543294164.html
3）开放特定端口
方法1：查看状态：iptables -L -n
下面添加对特定端口开放的方法：
使用iptables开放如下端口：/sbin/iptables -I INPUT -p tcp --dport 6379 -j ACCEPT
保存：/etc/rc.d/init.d/iptables save
重启服务：service iptables restart
查看需要打开的端口是否生效：/etc/init.d/iptables status
方法2：直接编辑/etc/sysconfig/iptables
添加：-A INPUT -p tcp -m tcp --dport 6379 -j ACCEPT

重启：service iptables restart

 

4）如果CentOS7，service iptables stop 时显示not loaded

可能是用的firewalld

停止firewalld，并禁用这个服务

sudo systemctl stop firewalld.service

sudo systemctl disable firewalld.service

启动firewalld：sudo systemctl start firewalld.service

参考：https://blog.csdn.net/yelllowcong/article/details/75945339

其他firewalld开放指定端口及相关操作：

firewall-cmd --zone=public --add-port=2377/tcp --permanent

 

firewall-cmd --reload

参考：https://blog.csdn.net/u012498149/article/details/78772058

 

## 端口管理
(部署集群时可以将其写在sh脚本里执行)
禁用指定端口：iptables -I INPUT -p tcp --dport 6379 -j DROP
对指定ip开启指定端口：iptables -I INPUT -s 192.168.1.10 -p tcp --dport 6379 -j ACCEPT
命令开启80端口：iptables -I INPUT -p tcp --dport 80 -j ACCEPT
配置文件开启80端口：修改/etc/sysconfig/iptables文件，添加-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
参考：http://blog.csdn.net/zhouyufengqingyang/article/details/51737254


## 关闭 selinux
修改/etc/selinux/config 文件
将SELINUX=enforcing改为SELINUX=disabled
重启
参考：http://bguncle.blog.51cto.com/3184079/957315/
 

 

## 通过防火墙配置实现 端口映射、端口转发

打开 ipv4 端口转发

sysctl net.ipv4.ip_forward=1

配置端口映射（例：该机器公网ip:8080转到192.168.0.122:80，其中192.168.0.62为该机器的内网ip）
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.122:80

iptables -t nat -A POSTROUTING -d 192.168.0.122 -p tcp --dport 80 -j SNAT --to 192.168.0.62

参考：http://man.linuxde.net/iptables

 

## linux查看端口占用

1) lsof -i:端口号

2) netstat -tunlp | grep 端口号

参考：https://jingyan.baidu.com/article/546ae1853947b71149f28cb7.html

 

## Windows关闭端口方法
netstat -ano | findstr :4200
TaskKill.exe /F /PID 12784
参考地址：https://stackoverflow.com/questions/38586364/ember-s-port-4200-is-already-in-use
