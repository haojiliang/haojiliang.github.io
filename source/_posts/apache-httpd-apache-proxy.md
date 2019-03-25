---
post_url: apache-httpd-apache-proxy
title: apache httpd 服务实现转发后如偶尔出现 apache proxy 错误
date: 2018-08-13 15:05:51
tags: [apache, httpd]
---
启动服务 service httpd start

重启服务 service httpd restart

停止服务 service httpd stop

使用指定的配置文件启动：/usr/sbin/httpd -k start -f /etc/httpd/conf/httpd_me.conf

httpd转发实现反向代理：http://blog.51cto.com/5468755/1369911

实现转发后如偶尔出现apache proxy错误，添加如下两个配置项即可解决：

```
<VirtualHost  *:80>

。。。。。。

SetEnv force-proxy-request-1.0.1
SetEnv proxy-nokeepalive 1

。。。。。。

</virtualHost>
```

参考：https://www.aliyun.com/jiaocheng/205214.html

 

设置开机启动：chkconfig httpd on

取消开机启动：chkconfig httpd off
