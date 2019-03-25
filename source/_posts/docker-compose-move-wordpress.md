---
title: docker-compose 迁移部署 wordpress 站点、创建自定义网络、设置容器为静态 ip
post_url: docker-compose-move-wordpress
date: 2018-12-02 20:46:12
tags: [docker, wordpress]
---
附：nginx1.15.7 + php7.0.33 + php-fpm + alpine3.7 镜像已完成：https://blog.csdn.net/iaiot/article/details/8481419

因为一个 wordpress 容器里同时有移动站和 pc 站，并且是通过二级域名区分的，所以只能配置了自定义网络，在 nginx 容器里配置 host 这样了。

由于站点代码本身问题，迁移到 docker 有很多地方需要调（https 访问站点资源等）。下一步直接做一个 nginx + php 的镜像（wordpress 整体挂载到宿主机），这样就和之前原生的云服务器一样了，后续迁移站点，部署什么的就方便多了。
```yml
version: '3.1'
 
services:
 
  nginx:
    image: nginx:1.15.7
    container_name: "nginx_container"
    ports:
      - "80:80"
      - "443:443"
    extra_hosts:
      - "www.vhxsl.com:10.10.10.12"
      - "m.vhxsl.com:10.10.10.12"
    volumes:
      - /data/nginx/html:/usr/share/nginx/html
      - /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf
      - /data/nginx/conf/conf.d:/etc/nginx/conf.d
      - /data/nginx/conf/cert:/etc/nginx/cert
      - /data/nginx/logs:/var/log/nginx
    restart: always
    networks:
      hx_net:
        ipv4_address: 10.10.10.11
 
  wordpress:
    image: wordpress:4.9.8
    container_name: "wordpress_container"
    volumes:
      - /data/wordpress/html:/var/www/html
    depends_on:
      - mysql
    restart: always
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_USER: haojiliang
      WORDPRESS_DB_PASSWORD: m*Hzq32R
      WORDPRESS_DB_NAME: vhxsl
    networks:
      hx_net:
        ipv4_address: 10.10.10.12
 
  mysql:
    image: mysql:5.7.24
    container_name: "mysql_container"
    volumes:
      - /data/mysql/data:/var/lib/mysql
      - /data/mysql/conf:/etc/mysql/conf.d
      - /data/mysql/logs:/data/mysql/logs
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ZMQ$qEPoAGovOM2I
      MYSQL_DATABASE: vhxsl
      MYSQL_USER: haojiliang
      MYSQL_PASSWORD: m*Hzq32R
    networks:
      hx_net:
        ipv4_address: 10.10.10.13
 
networks:
  hx_net:
    driver: bridge
    ipam:
      config:
        - subnet: 10.10.10.0/16
```

## docker 网络常用命令：

创建：docker network create --subnet=10.10.10.0/16 mynet

查看：docker network ls

删除所有无用网络：docker network prune

删除指定网络：docker network rm mynet

## 常见问题：

如果报 ERROR: Pool overlaps with other one on this address space，自定义网络用的网段和其他 docker 网络冲突了，删除冲突的网络或改用新网段即可。

## 官方 compose 文档：

https://docs.docker.com/compose/compose-file/#networks

## 附 nginx 中 www.vhxsl.com.conf 部分的配置：
```conf
server {
    listen 443 ssl;
    server_name www.vhxsl.com vhxsl.com;
    access_log /var/log/nginx/www.vhxsl.com_nginx.log combined;
    # 原生服务器部署的配置
    #root /data/wwwroot/wordpress;
    #index index.html index.htm index.php;
    #include /usr/local/nginx/conf/rewrite/wordpress.conf;
 
    ssl_certificate   /etc/nginx/cert/www.vhxsl.com.pem;
    ssl_certificate_key  /etc/nginx/cert/www.vhxsl.com.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
 
    #error_page 404 = /404.html;
    #error_page 502 = /502.html;
	
    if ( $http_user_agent ~* "(Android|iPhone|Windows Phone|UC|Kindle|iPod|BlackBerry)" ){
        rewrite ^/(.*)$  https://m.vhxsl.com$uri redirect;
    }
 
    # 按上述方式迁移到 docker 后，这里通过 http 导致后台代码返回的资源地址也是 http，到浏览器就被拦截了。。。
    # 所以为适配代码，后续改用自制的 nginx + php 镜像部署
    location / {
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://www.vhxsl.com;
    }
 
    location ~ [^/]\.php(/|$) {
        #fastcgi_pass remote_php_ip:9000;
        fastcgi_pass unix:/dev/shm/php-cgi.sock;
        fastcgi_index index.php;
        include conf.d/fastcgi.conf;
    }
    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp4|ico)$ {
        expires 30d;
        access_log off;
    }
    location ~ .*\.(js|css)?$ {
        expires 7d;
        access_log off;
    }
    location ~ /\.ht {
        deny all;
    }
}
 
server {
    listen 80;
    server_name www.vhxsl.com vhxsl.com;
 
    rewrite ^(.*)$  https://$host$1 permanent;
}
```