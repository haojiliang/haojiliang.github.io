---
post_url: docker-nginx
title: docker run 和 docker-compose 配置挂载 Volume 并运行 nginx
date: 2018-08-13 17:26:22
tags: [docker, nginx]
---
1. 先在宿主机创建挂载目录：mkdir -p /data/nginx/{conf,conf.d,html,logs}

2. 然后把文件 nginx.conf 文件放到 /data/nginx/conf/

```conf
user  nginx;
worker_processes  1;
 
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
 
 
events {
    worker_connections  1024;
}
 
 
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
 
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
 
    access_log  /var/log/nginx/access.log  main;
 
    sendfile        on;
    #tcp_nopush     on;
 
    keepalive_timeout  65;
 
    #gzip  on;
 
    include /etc/nginx/conf.d/*.conf;
}
```

容器内 /etc/nginx/ 目录如下：
![](/images/20181130105842729.jpg)

3. 把子配置文件 default.conf 放到 /data/nginx/conf.d/
```conf
server {
    listen       80;
    server_name  localhost;
 
    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;
 
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
 
    #error_page  404              /404.html;
 
    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
 
    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}
 
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}
 
    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}
```

4. 弄一个 index.html 放到 /data/nginx/html/

5. nginx 日志会在运行后存到 /data/nginx/logs/ 目录

6. 然后 docker run 直接运行 nginx：
```
docker run \
  --name myNginx \
  -d -p 8088:80 \
  -v /data/nginx/html/:/usr/share/nginx/html \
  -v /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /data/nginx/conf.d/:/etc/nginx/conf.d \
  -v /data/nginx/logs/:/var/log/nginx/ \
  nginx
```
7. 另外如果用 docker-compose 或 swarm 起服务，docker-compose.yml 文件如下：
```yml
version: "3"
services:
   web:
     image: nginx
     ports:
       - "8082:80"
     volumes:
       - /data/nginx/html:/usr/share/nginx/html
       - /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf
       - /data/nginx/conf.d:/etc/nginx/conf.d
       - /data/nginx/logs:/var/log/nginx
     restart: always
     container_name: myNginx2
```

docker-compose up -d 启动服务

重新创建容器：docker-compose up -d --force-recreate