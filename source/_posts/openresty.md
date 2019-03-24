---
post_url: openresty
title: CentOS安装openresty或者verynginx时:undefined reference to `pcre_free_study'
date: 2017-10-18 15:57:26
tags: openresty
---
一、openresty问题复现：centos安装openresty-1.11.2.5，./configure后make时报错：

 
```
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_regex_free_study_data':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:2015: undefined reference to `pcre_free_study'
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_ffi_destroy_regex':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:2413: undefined reference to `pcre_free_study'
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_ffi_compile_regex':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:2268: undefined reference to `pcre_assign_jit_stack'
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_ngx_re_gmatch':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:828: undefined reference to `pcre_assign_jit_stack'
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_ffi_set_jit_stack_size':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:1950: undefined reference to `pcre_jit_stack_free'
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:1957: undefined reference to `pcre_jit_stack_alloc'
objs/addon/src/ngx_http_lua_regex.o: In function `ngx_http_lua_ngx_re_match_helper':
/home/openresty-1.11.2.5/build/nginx-1.11.2/../ngx_lua-0.10.10/src/ngx_http_lua_regex.c:362: undefined reference to `pcre_assign_jit_stack'
collect2: ld returned 1 exit status
gmake[2]: *** [objs/nginx] Error 1
gmake[2]: Leaving directory `/home/openresty-1.11.2.5/build/nginx-1.11.2'
gmake[1]: *** [build] Error 2
gmake[1]: Leaving directory `/home/openresty-1.11.2.5/build/nginx-1.11.2'
gmake: *** [all] Error 2
```
很明显是pcre的问题，Google说是pcre版本问题；

解决办法：

1.下载新版本pcre，我下载的是pcre-8.38，解压，不需要安装；我服务器原版本是pcre-7.8.7

2.然后openresty目录下执行./configure时指定PCRE库的源码路径--with-pcre=/home/pcre-8.38

例：./configure --with-pcre=/home/pcre-8.38 (已省略其他编译参数，需要自行添加)

然后make，make install即可

 

二、安装verynginx时报同样错误

复现：python install.py install安装verynginx时,报同样错误;

解决：VeryNginx目录下install.py中大约51行处找到exec_sys_cmd( './configure --prefix=/opt/verynginx/openresty --user=nginx --group=nginx --with-http_v2_module --with-http_sub_module --with-http_stub_status_module --with-luajit ' )

后面同样加上--with-pcre=/home/pcre-8.38

即：exec_sys_cmd( './configure --prefix=/opt/verynginx/openresty --user=nginx --group=nginx --with-http_v2_module --with-http_sub_module --with-http_stub_status_module --with-luajit --with-pcre=/home/pcre-8.38' )

然后再执行python install.py install即可

 

 

参考地址：https://groups.google.com/forum/#!msg/openresty/o4CKvsp3Gio/9kiGJVSECgAJ

        https://github.com/openresty/lua-nginx-module/issues/781

        http://www.runoob.com/w3cnote/nginx-install-and-config.html
