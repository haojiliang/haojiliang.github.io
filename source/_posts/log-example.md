---
post_url: log-example
title: Nginx Apache(httpd) Tomcat Resin IIS Jboss Wildfly Weblogic 等各种应用容器默认访问日志的格式及样例
date: 2018-11-14 10:55:07
tags: log
---
## Nginx
```
格式 = $remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"
样例 = 10.10.10.12 - - [09/Nov/2018:09:48:42 +0800] "POST /project/totalStatus HTTP/1.1" 200 781 "http://console.monitor.iaiot.com/" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
```

## Apache(httpd) 配置文件中有三种访问日志格式
```
common 格式 = %h %l %u %t "%r" %>s %b
common 样例 = 192.168.1.2 - - [02/Feb/2016:17:44:13 +0800] "GET /favicon.ico HTTP/1.1" 404 209
combined 格式 = %h %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i"
combined 样例 = 192.168.1.2 - - [02/Feb/2016:17:44:13 +0800] "GET /favicon.ico HTTP/1.1" 404 209 "http://localhost/x1.html" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36"
combinedio 格式 = "%h %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i" %I %O
combinedio 样例 = 192.168.1.2 - - [02/Feb/2016:17:44:13 +0800] "GET /favicon.ico HTTP/1.1" 404 209 "http://localhost/x1.html" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.97 Safari/537.36" 127 217
```

## Tomcat
```
格式 = "%h %l %u %t "%r" %s %b"
样例 = 127.0.0.1 - - [09/Nov/2018:11:36:01 +0800] "POST /project/getProjects HTTP/1.1" 200 83
```

## Resin
```
格式 = %h %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i"
样例 = 127.0.0.1 - - [09/Nov/2018:15:31:39 +0800] "GET /resin-doc/ HTTP/1.1" 200 16417 "http://127.0.0.1:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
```

## IIS 有三种访问日志格式
```
W3C 样例 = 2018-11-09 08:12:41 172.22.255.255 GET /images/picture.jpg - 8080 - 172.30.255.255 Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64)+AppleWebKit/537.36+(KHTML,+like+Gecko)+Chrome/70.0.3538.77+Safari/537.36 http://localhost/ 404 0 2 1
IIS 样例 = 192.168.114.201, -, 03/20/2018, 7:55:20, W3SVC2, SERVER, 172.21.13.45, 4502, 163, 3223, 200, 0, GET, /DeptLogo.gif, -,
NCSA 样例 = 172.21.13.45 - Microsoft\JohnDoe [07/Apr/2004:17:39:04 -0800] "GET /scripts/iisadmin/ism.dll?http/serv HTTP/1.0" 200 3401
```

## Jboss
```
样例 = 127.0.0.1 - - [13/Nov/2018:10:58:27 +0800] "GET /site_test HTTP/1.1" 404 986
```

## Wildfly 有两种访问日志格式
```
common 样例 = 127.0.0.1 - - [13/Nov/2018:10:08:39 +0800] "GET /site_test/ HTTP/1.1" 200 52
combined 样例 = 127.0.0.1 - - [13/Nov/2018:10:13:25 +0800] "GET /favicon.ico HTTP/1.1" 200 1150 "http://localhost:8080/site_test/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36"
```

## Weblogic(注意 Weblogic access 日志最后会有一个空格)
```
样例 = 127.0.0.1 - - [13/十一月/2018:17:44:01 +0800] "GET /testweb/index.jsp HTTP/1.1" 200 52 
```