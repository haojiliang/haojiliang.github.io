---
post_url: docker-v-inode
title: 修改docker -v 挂载的文件遇到的问题。inode 软链接 硬链接 docker volume
date: 2018-11-24 10:29:40
tags: docker
---
原文地址：https://lrita.github.io/2017/08/18/mount-volume-to-docker-and-modify-from-host/

在启动docker容器时，为了保证一些基础配置与宿主机保持同步，通常需要将这些配置文件挂载进docker容器，例如/etc/resolv.conf//etc/hosts//etc/localtime等。

当这些配置变化时，我们通常会修改这些文件。但是此时遇到了一个问题：

当在宿主机上修改这些文件后，docker容器内查看时，这些文件并未发生对应的修改。

然后通过查阅相关资料，发现该问题是由docker -v挂载文件和某些编辑器存储文件的行为共同导致 的。

docker 挂载文件时，并不是挂载了某个文件的路径，而是实打实的挂载了对应的文件，即挂载了某 个指定的inode文件。
某些编辑器(vi)在编辑保存文件时，采用了备份、替换的策略，即编辑过程中，将变更写入新文件， 保存时，再将备份文件替换原文件，此时会导致文件的inode发生变化。
原inode对应的文件其实并没有发生修改。
因此，我们从宿主机上修改这些文件时，应该采用echo重定向等操作，避免文件的inode发生变化。

 

附 inode：http://www.ruanyifeng.com/blog/2011/12/inode.html

通过 inode 这篇文章能很好的理解 Linux 的软链接和硬链接