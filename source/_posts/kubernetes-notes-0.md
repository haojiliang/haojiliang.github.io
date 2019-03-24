---
post_url: kubernetes-notes
title: CentOS7 Kubernetes 集群安装搭建及 k8s 常用命令
date: 2018-07-18 09:20:14
tags: kubernetes
---
## 安装启动：
```
# 安装 etcd 和 Kubernetes 软件（会自动安装 Docker 软件）
yum install -y etcd kubernetes
 
# 启动
systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy
```
## 常用命令
```
发布：kubectl create -f mysql-rc.yaml
查看刚刚创建的 RC：kubectl get rc
查看 Pod：kubectl get pods
删除创建的 RC：kubectl delete -f mysql-rc.yaml
查看 pods 详情：kubectl describe pod mysql
创建 service：kubectl create -f mysql-svc.yaml
查看 service：kubectl get svc
```