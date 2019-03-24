---
post_url: nginx-notes
title: Nginx 笔记
date: 2018-11-20 21:34:01
tags: nginx
---
安装：http://blog.csdn.net/gaojinshan/article/details/37603157

其中安装时如果需要ssl：./configure --with-http_ssl_module

卸载：直接rm -rf find出来的nginx目录即可
启动：/usr/local/nginx/sbin/下./nginx
验证配置文件是否正确：./nginx -t
重启：./nginx -s reload
停止：./nginx -s stop
参考：http://www.cnblogs.com/codingcloud/p/5095066.html
根据域名访问系统指定目录下的静态文件：nginx.conf中配置root和server_name
例：root /data/wwwroot/html001; server_name www.aaa.com;
查看nginx编译安装信息：nginx -V
已装nginx添加新模块：nginx -V得到的编译参数加上需要新加的模块./configure...  make(切勿make install)  替换sbin/nginx文件
参考：http://www.cnblogs.com/lixigang/articles/5130052.html
Nginx编译选项及常用指令：http://www.runoob.com/w3cnote/nginx-install-and-config.html
