---
post_url: FastDFS-cmd
title: FastDFS 常用命令
date: 2018-11-20 22:27:17
tags: fastDFS
---
启动 Tracker：service fdfs_trackerd start  或者 /etc/init.d/fdfs_trackerd start

停止 Tracker：service fdfs_trackerd stop

启动 Storage：service fdfs_storaged start 或者 /etc/init.d/fdfs_storaged start

停止 Storage：service fdfs_storaged stop

查看运行状态：netstat -unltp | grep fdfs

参考地址：https://www.cnblogs.com/chiangchou/p/fastdfs.html#_label0_4
