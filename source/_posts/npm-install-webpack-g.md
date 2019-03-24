---
post_url: npm-install-webpack-g
title: npm install webpack -g 和 npm install --global vue-cli 失败报错 Unexpected end of JSON input while parsi
date: 2018-08-18 11:07:25
tags:
---
npm install webpack -g 和 npm install --global vue-cli 失败报错如下：

Unexpected end of JSON input while parsing near '...s":"~1.0.0","string_d'

npm ERR! A complete log of this run can be found in:

npm ERR!     /Users/haojiliang/.npm/_logs/2018-08-18T02_33_38_319Z-debug.log

 

网上都是说 npm cache clean --force，但是清除缓存之后再执行还是同样的报错

 

解决：用cnpm

npm install -g cnpm --registry=https://registry.npm.taobao.org

cnpm install webpack -g

cnpm install --global vue-cli

 

 

附：WebStorm 搭建 Vue 项目步骤 https://blog.csdn.net/weixin_40760196/article/details/79952652
