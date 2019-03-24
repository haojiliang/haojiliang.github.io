---
title: openresty（Nginx+lua-nginx-module）中各个阶段执行的指令解释及其执行顺序
post_url: openresty-lua-nginx-module
date: 2019-01-12 15:36:34
tags: [openresty, lua-nginx-module]
---

## 执行顺序
![](/images/20190112153020353.png)
图片来源：https://github.com/openresty/lua-nginx-module#directives

## 指令解释
**init_by_lua\***：初始化 nginx 和预加载 lua(nginx 启动和 reload 时执行)；
**init_worker_by_lua\***：每个工作进程(worker_processes)被创建时执行，用于启动一些定时任务，
比如心跳检查，后端服务的健康检查，定时拉取服务器配置等；
**ssl_certificate_by_lua\***：对 https 请求的处理，即将启动下游 SSL（https）连接的 SSL 握手时执行，用例：按照每个请求设置 SSL 证书链和相应的私钥，按照 SSL 协议有选择的拒绝请求等；
**set_by_lua\***：设置 nginx 变量；
**rewrite_by_lua\***：重写请求（从原生 nginx 的 rewrite 阶段进入），执行内部 URL 重写或者外部重定向，典型的如伪静态化的 URL 重写；
**access_by_lua\***：处理请求（和 rewrite_by_lua 可以实现相同的功能，从原生 nginx 的 access阶段进入）；
**content_by_lua\***：执行业务逻辑并产生响应，类似于 jsp 中的 servlet；
**balancer_by_lua\***：负载均衡；
**header_filter_by_lua\***：处理响应头；
**body_filter_by_lua\***：处理响应体；
**log_by_lua\***：记录访问日志；


## 参考
https://github.com/openresty/lua-nginx-module
http://tengine.taobao.org/book/chapter_12.html#id8
http://jinnianshilongnian.iteye.com/blog/2186448
