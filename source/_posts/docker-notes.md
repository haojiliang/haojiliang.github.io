---
post_url: docker-notes
title: docker 笔记
date: 2018-06-28 13:51:43
tags: docker
---

容器的本质是宿主机上一个特殊的进程，通过 宿主机 的 Namespace、Cgroups、rootfs 等（Namespace 做进程隔离，Cgroups 做限制(限制隔离进程组所使用的cpu,memory,IO等物理资源)，rootfs 做文件系统）与宿主机上的其他东西 "隔离开"。

1. 强制删除 docker 镜像：docker rmi -f [IMAGE-ID]  或 docker rmi -f [IMAGE-NAME]

   删除 container：docker rm [CONTAINER ID]

2. 保存镜像到文件：docker save -o /data/image1.tar [IMAGE_NAME]

3. 载入镜像文件：docker load --input /data/image1.tar 或 docker load < /data/image1.tar

4. 使用本地模板导入镜像：cat centos-6-x86_64-20170709.tar.xz | docker import - [IMAGE-NAME-NEW] 

例：cat centos-6-x86_64-20170709.tar.xz | docker import - centos6

OpenVZ 模板下载网站：https://openvz.org/Download/template/precreated

5. 查看本地镜像列表：docker images

查找本地镜像：docker images nginx

搜索仓库镜像：docker search nginx

6. 执行 docker 命令：docker run [IMAGE_NAME] ping 10.10.50.55

7. Docker 入门：http://www.docker.org.cn/book/docker/what-is-docker-16.html

8. 创建并运行 container 后进入其 bash 控制台：docker run -t -i 691ad2f6923d /bin/bash

进入后台运行的容器：docker exec -it [CONTAINER_NAME || CONTAINER_ID] /bin/sh

9. 列出 container：docker ps -a

10. 卸载安装：https://docs.docker.com/install/linux/docker-ce/centos/

11. 镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的 类 和 实例 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。

12. 容器存储：

前面讲过镜像使用的是分层存储，容器也是如此。每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为容器存储层。

容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。

按照 Docker 最佳实践的要求，容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作，都应该使用 数据卷（Volume）、或者绑定宿主目录，在这些位置的读写会跳过容器存储层，直接对宿主（或网络存储）发生读写，其性能和稳定性更高。

数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此，使用数据卷后，容器删除或者重新运行之后，数据却不会丢失。

13. Docker hub地址：https://hub.docker.com/

14. 后台运行（信息不输出到前台）：使用 -d 参数

注： 容器是否会长久运行，是和 docker run 指定的命令有关，和 -d 参数无关。

参考：https://yeasy.gitbooks.io/docker_practice/container/daemon.html

15. 查看端口映射配置：docker port web2 80

参考：https://yeasy.gitbooks.io/docker_practice/network/port_mapping.html

16. 查看 Image 或 Container 的信息：docker inspect wordpress

17. 安装 docker：https://docs.docker.com/install/linux/docker-ce/centos/#install-docker-ce-1

18. 查看系统内核版本：uname -r

19. 安装 docker-compose：

$ sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose 

$ sudo chmod +x /usr/local/bin/docker-compose

参考：https://docs.docker.com/compose/install/

其他资料：https://docs.docker.com/compose/gettingstarted/

20. 安装 Docker Machine

https://docs.docker.com/machine/install-machine/#install-machine-directly

21. 在 Swarm 集群中使用 compose 文件

$ docker stack deploy -c docker-compose.yml wordpress

$ docker stack ls

$ docker stack down wordpress

参考：https://yeasy.gitbooks.io/docker_practice/swarm_mode/stack.html

22. macOS 下如果用邮箱登录 docker，pull 镜像时会提示：...unauthorized: incorrect username or password. 用 DockerID 登录就没问题。

23. 清理所有停止运行的容器 docker container prune   

image、volume、network 同理：

docker image prune

docker volume prune

24.查看容器日志：docker logs -f --tail=10 [containerID]  
-f：查看实时日志  
--tail=10：返回最近10行  

docker 命令大全：http://www.runoob.com/docker/docker-command-manual.html

《Docker 从入门到实践》：https://yeasy.gitbooks.io/docker_practice/install/centos.html

更多：https://blog.csdn.net/iaiot/article/details/80845250
