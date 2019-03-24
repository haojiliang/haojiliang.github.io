---
post_url: Harbor
title: Centos7 安装 docker 私有仓库 Harbor
date: 2018-11-08 14:43:07
tags: Harbor
---

```
# 安装 Harbor 之前需要先安装 python2.7+、Openssl、Docker、Docker Compose；
 
# 安装 openssl
yum install openssl
yum install openssl-devel
 
# 安装 docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum install docker-ce
systemctl start docker
 
# 安装 docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
 
# 在线安装 harbor
wget https://storage.googleapis.com/harbor-releases/release-1.6.0/harbor-online-installer-v1.6.0.tgz
tar -zxvf harbor-online-installer-v1.6.0.tgz
 
# 配置 harbor/harbor.cfg 中 hostname，不能使用 localhost 或 127.0.0.1
hostname = 192.168.153.7
 
# 开始安装
./harbor/install.sh
```

安装完成
![](/images/20181108143944390.jpg)
默认管理员用户名/密码为 admin / Harbor12345 登录
![](/images/20181108144249774.jpg)
官方安装手册：https://github.com/goharbor/harbor/blob/master/docs/installation_guide.md