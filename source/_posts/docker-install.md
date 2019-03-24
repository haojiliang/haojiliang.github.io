---
post_url: docker-install
title: CentOS7 安装最新版 Docker、compose、swarm、machine
date: 2018-07-16 17:22:00
tags: docker
---
## Docker 安装
```
1.卸载 Docker
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine
 
2.安装所需的包
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
 
3.设置阿里云软件存储库
阿里云：sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
 
4.安装 Docker CE
sudo yum install docker-ce
 
5.启动 Docker
sudo systemctl start docker
 
6.通过运行 hello-world 映像验证是否已正确安装
sudo docker run hello-world
```
## docker-compose 安装
```
1.下载最新版本的 Docker Compose (第一次执行提示失败，就多执行几次这个命令试试)
sudo curl -L \
https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose
 
2.对二进制文件应用可执行权限
sudo chmod +x /usr/local/bin/docker-compose
 
3.测试安装
docker-compose --version
 
4.docker-compose 命令
https://yeasy.gitbooks.io/docker_practice/compose/commands.html
 
5.docker-compose.yml
https://yeasy.gitbooks.io/docker_practice/compose/compose_file.html
```
## docker-machine 安装
```
1.下载 Docker Machine 二进制文件并将其解压缩到 PATH (第一次执行提示失败，就多执行几次这个命令试试)
base=https://github.com/docker/machine/releases/download/v0.14.0 && \
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine && \
sudo install /tmp/docker-machine /usr/local/bin/docker-machine
 
2.通过显示机器版本来检查安装
docker-machine version
```
## 搭建 swarm 集群
```
1.新版 docker 已集成 swarm，无需单独安装
 
2.使用 docker swarm init 在管理节点初始化一个 Swarm 集群
docker swarm init --advertise-addr 192.168.153.150
# 如果你的 Docker 主机有多个网卡，拥有多个 IP，必须使用 --advertise-addr 指定 IP
# 执行 docker swarm init 命令的节点自动成为管理节点
 
3.将其他主机作为 管理节点 或 工作节点 加入 swarm 集群（以下命令在待加入节点执行）
docker swarm join --token [MANAGER-TOKEN||WORKER-TOKEN] [MANAGER-IP]:2377
# 示例：docker swarm join --token SWMTKN-1-3pu6hszjas19xyp7ghgosyx9k8atbfcr8p2is99znpy26u2lkl-1awxwuwd3z9j1z3puu7rcgdbx 192.168.153.150:2377
--------------
注意：各机器之间要开启以下通信端口 或 关闭防火墙
# TCP端口2377集群管理端口
# TCP与 UDP端口7946节点之间通讯端口
# TCP与 UDP端口4789 overlay 网络通讯端口
firewall-cmd --zone=public --add-port=2377/tcp --permanent
firewall-cmd --zone=public --add-port=7946/tcp --permanent
firewall-cmd --zone=public --add-port=7946/udp --permanent
firewall-cmd --zone=public --add-port=4789/tcp --permanent
firewall-cmd --zone=public --add-port=4789/udp --permanent
firewall-cmd --reload
关闭防火墙：
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service
--------------
 
4.在管理节点使用 docker node ls 查看集群
docker node ls
 
5.向集群中添加工作节点，通过以下命令获取加入集群的 WORKER-TOKEN
docker swarm join-token worker
向集群中添加管理节点，通过以下命令获取加入集群的 MANAGER-TOKEN
docker swarm join-token manager
 
6.退出集群
(1)如果是 manager 先降级为 worker 
docker node demote [HOSTNAME || ID] # ID前几位即可
(2)退出集群
docker swarm leave
(3)移除节点
docker node rm [HOSTNAME || ID] # ID前几位即可
# leave后该节点仍将出现在节点列表中，并将 STATUS标记为 down，已不影响 swarm操作；
# 要从列表中删除非活动节点，使用 node rm 命令即可。
```
## 使用 swarm+compose 部署集群服务
```
1.使用 swarm+compose 部署服务
docker stack deploy -c docker-compose.yml [JIQUN-NAME]
 
2.查看服务
docker stack ls
 
3.移除服务
docker stack down [JIQUN-NAME]
# 该命令不会移除服务所使用的 数据卷，如果你想移除数据卷请使用 docker volume rm
```
## 其他 Docker 常用命令
```
查看 swarm 集群中的服务：docker service ls
查看 swarm 集群中某个服务的运行状态信息：docker service ps mwp_db
查看 swarm 集群中某个服务的基础详细信息：docker service inspect mwp_db
查看 swarm 集群中某个服务的日志：docker service logs mwp_db
从 swarm 集群中移除某个服务：docker service rm mwp_db
 
搜索仓库镜像：docker search nginx
查找本地镜像：docker images nginx
查看本地镜像列表：docker images 或 docker image ls
删除本地镜像：docker rmi [IMAGE ID]
强制删除本地镜像：docker rmi -f [IMAGE ID] # 一般先停止相关容器，再 docker rmi [IMAGE ID] 正常删除镜像
 
列出本机容器 container：docker ps -a 或 docker container ls
删除 container：docker rm [CONTAINER ID] 或 docker container rm [CONTAINER ID]
清理所有处于终止状态的容器：docker container prune
进入后台运行的容器 container：docker exec -it [CONTAINER_NAME || CONTAINER_ID] /bin/sh
# docker exec 进入容器后 exit 不会导致容器停止
创建一个新的容器并运行：docker run --name web2 -d -p 81:80 nginx:v2
停止一个运行中的容器：docker stop [CONTAINER ID || NAMES]
 
查看所有数据卷：docker volume ls
删除指定数据卷：docker volume rm [VOLUME NAME]
清理所有无主数据卷：docker volume prune
 
查看 Image 或 Container 的信息：docker inspect [IMAGE || IMAGE ID || CONTAINER ID]
 
查看 CentOS 系统内核版本：uname -r
 
使用 Dockerfile 定制镜像：docker build -t nginx:v3 [DOCKERFILE PATH || URL]
# 其中 [DOCKERFILE PATH || URL] 为 Dockerfile 文件所在目录，例：docker build -t nginx:v3 .
 
更多命令可参考：http://www.runoob.com/docker/docker-command-manual.html
```
## 配置 Docker 加速器
```
参考：https://yeasy.gitbooks.io/docker_practice/install/mirror.html
对于使用 systemd 的系统，在 /etc/docker/daemon.json 中写入如下内容（如果文件不存在则新建该文件）
{
  "registry-mirrors": [
    "https://registry.docker-cn.com"
  ]
}
之后重新启动服务。
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
检查加速器是否生效：docker info
Registry Mirrors:
 https://registry.docker-cn.com/
```
更多 daemon.json 配置项参考：https://blog.csdn.net/iaiot/article/details/84679859

Docker hub 地址：https://hub.docker.com/
Docker 官方文档地址：https://docs.docker.com/
