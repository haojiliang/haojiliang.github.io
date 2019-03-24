---
post_url: docker-compose-custom-network
title: docker-compose 配置自定义网络和静态 ip 示例
date: 2018-12-13 23:29:18
tags: [docker-compose 配置自定义网络, docker-compose 配置静态 ip]
---


```yml
version: '3.1'
 
services:
 
  web:
    image: haojiliang/nginx-php-fpm-alpine:v1.15.7
    container_name: "web_container"
    ports:
      - "80:80"
      - "443:443"
    extra_hosts:
      - "www.vhxsl.com:127.0.0.1"
      - "m.vhxsl.com:127.0.0.1"
    volumes:
      - /data/nginx/html/wordpress:/data/www/wordpress
      - /data/nginx/html/default:/usr/share/nginx/html
      - /data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf
      - /data/nginx/conf/conf.d:/etc/nginx/conf.d
      - /data/nginx/conf/cert:/etc/nginx/cert
      - /data/nginx/logs:/var/log/nginx
    depends_on:
      - mysql
    restart: always
    networks:
      hx_net:
        ipv4_address: 11.11.11.11
 
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
    networks:
      hx_net:
        ipv4_address: 11.11.11.12
 
networks:
  hx_net:
    driver: bridge
    ipam:
      config:
        - subnet: 11.11.11.0/16
```