---
post_url: Kubernetes-notes
title: Kubernetes 笔记
date: 2019-01-12 15:59:33
tags: kubernetes
---
1. 对于一个容器来说，它的 IP 地址等信息不是固定的，那么 Web 应用又怎么找到数据库容器的 Pod 呢？所以，Kubernetes 项目的做法是给 Pod 绑定一个 Service 服务，而 Service 服务声明的 IP 地址等信息是“终生不变”的。这个Service 服务的主要作用，就是作为 Pod 的代理入口（Portal），从而代替 Pod 对外暴露一个固定的网络地址。这样，对于 Web 应用的 Pod 来说，它需要关心的就是数据库 Pod 的 Service 信息。不难想象，Service 后端真正代理的 Pod 的 IP 地址、端口等信息的自动更新、维护，则是 Kubernetes 项目的职责。

2. 其实国内同学们用 kubeadm 安装 Kubernetes 最大的拦路虎在于有几个镜像没法下载，我建议大家先手动把镜像pull 下来，从阿里的镜像源上，然后tag成安装所需的镜像名称，这样你发现安装过程会异常顺利。
更简单的免fq安装：kubeadm拉取镜像的url是可配置的。在 kubeadm 中，Master 组件的 YAML 文件会被生成在 /etc/kubernetes/manifests 路径下，kube-apiserver.yaml。在 kube-apiserver.yaml 中定义了安装 k8s 所需要的镜像，只需要修改kube-apiserver.yaml中的镜像为阿里云的镜像即可。

3. 对于同一个 Pod 里面的所有用户容器来说，它们的进出流量，也可以认为都是通过 Infra 容器完成的

4. kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml