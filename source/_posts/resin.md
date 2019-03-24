---
post_url: resin
title: resin安全配置,ip黑白名单,只允许指定ip访问resin-admin,拒绝某些ip访问webapp
date: 2017-09-18 10:18:04
tags: resin
---
为resin-admin设置白名单，webapps设置黑名单：

1. resin.xml中加入admin的host配置resin:Allow，如下：
```
<cluster id="app">
    ......
    <!-- 只允许指定ip访问resin-admin -->
    <host id="${web_admin_host}" root-directory="${web_admin_host}">
        <web-app id="/resin-admin" root-directory="${resin.root}/doc/admin">
            <resin:Allow url-pattern="/admin/*">
                <resin:IfNetwork value="${web_admin_allow_host}"/>
            </resin:Allow>
        </web-app>
    </host>
</cluster>
```

2. resin.properties中加一个参数用来放允许访问的ip：比如
```
web_admin_allow_host: 10.10.10.10 10.10.10.11 10.10.10.12
```
3. 拓展：

对于自己的webapps，也可以使用同样的方法配置允许访问的ip；

如果要拒绝某些ip的访问，可以用resin:Forbidden

网上resin相关文章相对比较少，需要多参考官方文档

官方文档地址：http://javadoc4.caucho.com/com/caucho/rewrite/IfNetwork.html

 

4. 笔记
```
<host id="tools.api.iaiot.com" root-directory=".">
        <host-alias>tools.api.iaiot.com</host-alias>
        <web-app id="/v" root-directory="webapps/visual-platform" />
        <web-app id="/s" root-directory="webapps/search-api" />
        <web-app id="/a" root-directory="webapps/alarm-api" />
</host>
```