---
post_url: nginx-php-fpm-alpine
title: nginx-php 的 docker 镜像 nginx1.15.7 php7.0.33 php-fpm alpine3.7，测试 wordpress 完美运行
date: 2018-12-05 08:10:19
tags: [nginx, php, docker, wordpress]
---
获取镜像：docker pull haojiliang/nginx-php-fpm-alpine:v1.15.7

nginx 1.15.7
php 7.0.33
php-fpm
alpine 3.7

镜像大小：83.9MB

文件路径及端口等配置都和 nginx 官方镜像一样，在 php 官方镜像基础上加了 php 扩展和 nginx

Dockerfile：https://github.com/haojiliang/nginx-php-fpm-alpine

Docker Hub：https://hub.docker.com/r/haojiliang/nginx-php-fpm-alpine/
