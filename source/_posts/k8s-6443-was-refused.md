---
post-url: k8s-6443-was-refused
title: Mac Kubernetes 报 The connection to the server localhost:6443 was refused
date: 2018-12-22 22:11:22
tags: kubernetes
---
原文：https://github.com/kubernetes/kubernetes/issues/23726


Deleted the old config from ~/.kube and then restarted docker (for macos) and it rebuilt the config folder.

All good now when I do 'kubectl get nodes'.


1. rm -rf ~/.kube

2. 重启 docker 和 k8s