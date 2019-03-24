---
post_url: lua-notes
title: Nginx+lua-nginx-module，openresty，lua基础语法 笔记
date: 2018-01-12 17:31:42
tags: lua
---
1. Lua 用[[...]]括起来的字符不会被转义，在写正则表达式的时候很实用；
例：[[^\d+.\d+$]]

2. lua 中"~="表示不等于

3. 可以用 type(aa)查看变量 aa 的类型

4. lua 中 0 是真(true)

5. 字符串连接符：..

7. lua 中的逻辑运算符比较特殊
例：local y = a and b or c 相当于 a?b:c
参考：https://moonbingbing.gitbooks.io/openresty-best-practices/content/lua/operator.html

8. local m,n = "aaa" 表示 m 被赋值为字符串，n 没有被赋值，是 nil

9. lua function 可以返回多个值
参考：https://moonbingbing.gitbooks.io/openresty-best-practices/content/lua/function_result.html

10. lua 中当 table 作为一个函数的参数时，就和 java 中的集合和数组一样是传引用的方式，而不是传值的方式
注：java 中都是值传递，只不过集合和数组传的是对象的地址值

11. 请求头参数修改方法：ngx.req.set_header(header_name, header_value)；
请求体是 table 类型的，所以要修改请求体，可以先 ngx.req.get_body_data，修改完再 ngx.req.set_body_data
table 修改方法：table.key = newvalue 或 table[key] = newvalue

12. Nginx Http 处理流程有：init/rewrite/access/content/filter/log 等
可参考：http://tengine.taobao.org/book/chapter_12.html(多阶段处理请求)

13. 在 lua 里判断空字符串只能用检查长度的方式

14. 正则匹配，ngx.re.match()返回的结果是一个表，里面存储了匹配的结果，如果匹配成功，
m[0]保存的是整个(匹配成功的)字符串，之后的 m[1],m[2]等保存的是匹配的子表达式
local m = ngx.re.match("abcd-123", "(.*)123$", "jo")
-- 参数 "j" 启用 JIT 编译，参数 "o" 是开启缓存必须的

15. 单行注释：--
多行注释：--[[...]]

16. print(#'openresty') --计算字符串长度，输出 9

17. 这些文件 I/O 操作，在 OpenResty 的上下文中对事件循环是会产生阻塞效应。OpenResty 比较擅长的是高并发网络处理，在这个环境中，任何文件的操作，都将阻塞其他并行执行的请求。实际中的应用，在 OpenResty 项目中应尽可能让网络处理部分、文件 I/0 操作部分相互独立，不要揉和在一起。
https://moonbingbing.gitbooks.io/openresty-best-practices/content/lua/file.html

18. 官方建议使用 openresty，不建议使用原生 nginx 自己集成 lua-nginx-module
原文：https://github.com/openresty/lua-nginx-module#installation

19. 任何重写规则的第一部分都是一个正则表达式
可以使用括号来捕获，后续可以根据位置来将其引用，位置变量值取决于捕获正则表达式中的顺序，$1引用第一个括号中的值，$2引用第二个括号中的值，以此类推。
例：^/images/([a-z]{2})/([a-z0-9]{5})/(.*)\.(png|jpg|gif)$
$1是两个小写字母组成的字符串，$2是由小写字母和0到9的数字组成的5个字符的字符串，$3将是个文件名，$4是png、jpg、gif中的其中一个。
参考：http://www.ttlsa.com/nginx/nginx-rewriting-rules-guide/

20. nginx lua指令及其执行顺序
![](/images/20180112173241641.png)
其中上图中提到的各个指令的作用：
init_by_lua\*:初始化 nginx 和预加载 lua(nginx 启动和 reload 时执行)
init_worker_by_lua\*:每个工作进程(worker_processes)被创建时执行，用于启动一些定时任务，
比如心跳检查，后端服务的健康检查，定时拉取服务器配置等；
ssl_certificate_by_lua\*:对 https 请求的处理，即将启动下游 SSL（https）连接的 SSL 握手时执行，用例：按照每个请求设置 SSL 证书链和相应的私钥，按照 SSL 协议有选择的拒绝请求等；
set_by_lua\*:设置 nginx 变量
rewrite_by_lua\*:重写请求（从原生 nginx 的 rewrite 阶段进入），执行内部 URL 重写或者外部重定向，典型的如伪静态化的 URL 重写；
access_by_lua\*:处理请求（和 rewrite_by_lua 可以实现相同的功能，从原生 nginx 的 access阶段进入）
content_by_lua\*:执行业务逻辑并产生响应，类似于 jsp 中的 servlet
balancer_by_lua\*:负载均衡
header_filter_by_lua\*:处理响应头
body_filter_by_lua\*:处理响应体
log_by_lua\*:记录访问日志
参考：https://github.com/openresty/lua-nginx-module
http://tengine.taobao.org/book/chapter_12.html#id8
http://jinnianshilongnian.iteye.com/blog/2186448
21. http请求报文
![](/images/20180112173844671.png)
22. HTTP响应报文
![](/images/20180112173621526.png)
23. 附openresty的Github地址：https://github.com/openresty