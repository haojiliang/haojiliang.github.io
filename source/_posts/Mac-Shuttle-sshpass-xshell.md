---
post_url: Mac-Shuttle-sshpass-xshell
title: Mac 上使用 Shuttle + sshpass 替代 xshell
date: 2018-11-18 11:07:02
tags: mac
---
终于在 Mac 上找到相对好用又简洁的 xhsell 替代工具：Shuttle + sshpass

1.安装 sshpass：
```
下载并解压 http://sourceforge.net/projects/sshpass/
$ ./configure
$ sudo make install
 
使用：
$ sshpass -p '123456' ssh root@192.168.0.171
```

注意：在使用 sshpass 登录前需要先使用 ssh root@192.168.0.171 登录 yes 一下，然后就可以正常使用 sshpass 了。

 

2.安装 Shuttle：

下载并解压后拖到应用程序：http://fitztrev.github.io/shuttle/

 

3.配置 Shuttle：

设置-编辑 打开配置文件，里面就是配置那个 json，一看就明白了

配置项文档：https://github.com/fitztrev/shuttle/wiki

我的配置：
![](/images/20181118141726250.png)