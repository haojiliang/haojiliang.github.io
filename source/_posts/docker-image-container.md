---
title: Docker 学习笔记合集第一季 —— image container 基本操作
post_url: docker-image-container
date: 2018-06-28 16:32:22
tags: docker
---
原文地址：https://testerhome.com/topics/2760

学习 docker 也有数周时间了，一直在 学基础->手痒想实践->实践->卡住->回去学习基础 的过程中挣扎，总算是把 docker 的对 image，container 的基本操作都过了一遍（其实最基本的早就会了，只是一些相对用得不多的没有用过）。因此把到目前为止的一些学习笔记放在这里分享一下（内容真心水，大家轻拍）。

Docker 学习笔记（1）– 在 mac 上配置环境
Docker 学习笔记（2）– docker 化(Dockerizing)应用： Hello-world
Docker 学习笔记（3）– Docker container
Docker 学习笔记（4）– Docker image

最后在这里简单总结一下这些基本命令及基本概念，也作为以后的一个速查表：

基本概念：
container
容器。可以把每个 container 看做是一个独立的主机。 container 的创建通常有一个 image 作为其模板。类比成虚拟机的话可以理解为 image 就是虚拟机的镜像，而 container 就是一个个正在运行的虚拟机。一个虚拟机镜像可以创建出多个运行的虚拟主机且相互独立。 注意：container 一旦创建如果没有用 rm 命令移除，将会一直存在。所以用完后记得删除哦。

image
镜像。image 相当于 container 的模板，container 创建后里面有什么软件完全取决于它使用什么 image 。image 可以通过 container 创建（相当于把此时 container 的状态保存成快照），也可以通过 Dockerfile （一个文本文件，里面使用 docker 规定的一些写法）来创建。其中通过 Dockerfile 创建的方法能让环境配置和代码一起被版本库一起管理。

registry
存放镜像的仓库。只要能连接到 registry 每个人都可以很方便地通过 pull 命令从仓库中获取镜像。docker 默认使用的仓库是 docker hub，国内可以使用 DaoCloud 来建立 Mirror 连接到 docker hub，进而加快获取 image 的速度。

boot2docker
一个轻量级 linux 虚拟机，主要是为了让非 linux 系统也能用上 docker 。它实质上是一个 virtualbox 虚拟主机+一个能管理这个虚拟主机的命令行工具。由于这个虚拟主机的存在，在非 linux 系统上 container 需要获取一些物理系统资源（如 usb 设备）时不仅需要配置 docker 命令，还需要配置 boot2docker 这个虚拟主机的资源配置。

常用命令表
通用：

操作	命令	示例
查看 docker 版本	docker version	docker version
查看 docker 信息	docker info	docker info
查看某命令 help 信息	docker help [command]	docker help attach
查看 docker help 信息	docker --help	docker --help
container 相关：
操作	命令	示例
创建 container	docker create	docker create chenhengjie123/xwalkdriver
创建并运行 container	docker run	docker run chenhengjie123/xwalkdriver /bin/bash
创建并运行 container 后进入其 bash 控制台	docker run -t -i image /bin/bash	docker run -t -i ubuntu /bin/bash
创建并运行 container 并让其在后台运行，并端口映射	docker run -p [port in container]:[port in physical system] -d [image] [command]	docker run -p 5000:5000 -d training/webapp python app.py
查看正在运行的所有 container 信息	docker ps	docker ps
查看最后创建的 container	docker ps -l	docker ps -l
查看所有 container ，包括正在运行和已经关闭的	docker ps -a	docker ps -a
输出指定 container 的 stdout 信息（用来看 log ，效果和 tail -f 类似，会实时输出。）	docker logs -f [container]	docker logs -f nostalgic_morse
获取 container 指定端口映射关系	docker port [container] [port]	docker port nostalgic_morse 5000
查看 container 进程列表	docker top [container]	docker top nostalgic_morse
查看 container 详细信息	docker inspect [container]	docker inspect nostalgic_morse
停止 continer	docker stop [container]	docker stop nostalgic_morse
强制停止 container	docker kill [container]	docker kill nostalgic_morse
启动一个已经停止的 container	docker start [container]	docker start nostalgic_morse
重启 container (若 container 处于关闭状态，则直接启动)	docker restart [container]	docker restart nostalgic_morse
删除 container	docker rm [container]	docker rm nostalgic_morse
命令中需要指定 container 时，既可使用其名称，也可使用其 id 。

image 相关：
操作	命令	示例
从 container 创建 image	docker commit [container] [imageName]	docker commit nostalgic_morse ouruser/sinatra:v2
从 Dockerfile 创建 image	docker build -t [imageName] [pathToFolder]	docker build ouruser/sinatra:v3 .
查看本地所有 image	docker images	docker images
在 registry 中搜索镜像	docker search [query]	docker search ubuntu
从 registry 中获取镜像 （若无指定 tag 名称，则默认使用 latest 这个 tag）	docker pull [imageName]	docker pull ubuntu:14.04, docker pull training/webapp
给 image 打 tag	docker tag [imageId] [imageName]	docker tag 5db5f8471261 ouruser/sinatra:devel
把本地 image 上传到 registry 中 (此时会把所有 tag 都上传上去)	docker push [imageName]	docker push ouruser/sinatra
删除本地 image	docker rmi [image]	docker rmi training/sinatra
注意：image 中没有指定 tag 名称的话默认使用 latest 这个 tag 。然而 latest 的含义和 VCS 中的 head 不一样，不是代表最新一个镜像，仅仅是代表 tag 名称为 latest 的镜像。若不存在 tag 名称为 latest 的镜像则会报错。

总结
docker 虽然是一个虚拟化技术，但使用上却更像是在管理系统软件或者代码。里面的一些 ps，top，rm 命令让使用 Linux 命令的人感到十分亲切（虽然它们的语义有点不一样。。。），start，stop，restart 让你感觉像是在控制 service ，而 push，pull，commit，tag 又让你觉得像是在使用 git 。因此程序员会感到很亲切且容易上手。

同时由于可以使用 Dockerfile 进行 image 的构建，且 docker hub 支持从 github 等地方自动根据 Dockerfile 进行构建，所以 docker 把运行环境也集成到 CI 中了。

美中不足的是由于 docker 目前仅支持 linux 上的容器技术，因此它要在非 Linux 系统下运行必须加多一个虚拟机层。这会造成一些在 Linux 上运行不会出现的问题（ip 地址、硬件资源、文件映射等），同时由于基于 linux ，一些 windows 的程序会水土不服，泛用性比虚拟机差一些。

但带来的好处是占用的系统资源低很多。一个只能开数个虚拟机的电脑一般能开数十个 container ，且 container 的启动时间一般在数秒内，比虚拟机快得多。另外，由于 docker 的 image 除了一些特殊的基础镜像外基本都是增量镜像，因此重复部分不会耗费额外的资源，所以几个看起来有数 g 的 image 如果里面使用的基础镜像有重复部分（大部分情况下都会有部分重复），那么它们实际占用空间将会小得多。