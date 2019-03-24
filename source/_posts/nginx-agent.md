---
post_url: nginx-agent
title: 用nginx等做代理转发到本机时最好通过host配置目的地址为127.0.0.1
date: 2018-08-01 17:11:10
tags: nginx
---
用nginx等做代理转发到本机时最好通过host配置目的地址为127.0.0.1，而不是在域名解析里解析域名。

原因：1.请求会白转一大圈再回去，浪费时间和资源。

2.如果有恶意攻击，攻击请求先到了nginx，然后nginx再把这个攻击请求往外转，如果是用的百度云服务器，他会认为这台机器是攻击源，严重的会被他关停服务器ip。。。

亲身经历的攻击内容如下：
```
u'180.76.*.*'
u'124.128.*.*'
u'Mon, 23 Jul 2017 20:39:34 GMT'
u'Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.1) Gecko/20090715 Firefox/3.5.1 LVS inf-ssl-duty-scan'
u'http://message.api.iaiot.com/login?next=-9422%22%20UNION%20ALL%20SELECT%208239%2C%208239%2C%208239%2C%208239%23'
u''
u'GET'
u'sqli_sandbox'
```