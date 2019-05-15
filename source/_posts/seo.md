---
post_url: seo
title: 业余 网站 SEO 实践总结
date: 2018-09-07 13:14:49
tags: seo
---

## 301 302 的选择
```
301：永久重定向，搜索引擎在抓取新的内容的同时也将旧的网址替换为了重定向之后的网址。
302：临时跳转，蜘蛛会认为新的网址是暂时的，所以搜索引擎会抓取新的内容而保留旧的地址。
实例：如果是设备跳转适配，https://www.vhxsl.com/ 转 https://m.vhxsl.com/ 用 302；
如果是 http 跳转 https，用 301;
如果是网站更换域名或改版用 301。
 
Nginx配置：rewrite ^(.*)$  https://$host$1 permanent; rewrite 后跟 permanent 会返回 301
rewrite ^/(.*)$  https://m.vhxsl.com$uri redirect; 后跟 redirect 返回 302
```

##  Nginx PC/移动 站点跳转适配
```
1.PC 转 移动
if ( $http_user_agent ~* "(Android|iPhone|Windows Phone|UC|Kindle|iPod|BlackBerry)" ){
    rewrite ^/(.*)$  https://m.vhxsl.com$uri redirect;
}
2.移动 转 PC
if ( $http_user_agent !~* "(Android|iPhone|Windows Phone|UC|Kindle|iPod|BlackBerry)" ){
    rewrite ^/(.*)$  https://www.vhxsl.com$uri redirect;
}
```
## 收录索引权重
```
1.在百度站内搜索提交 sitemap 比在百度站长里提交 sitemap 收录快，纯直觉，是不是真这样就不知道了。
2.据说通过百度站长后台提交的链接的权重会比百度蜘蛛主动抓取收录的链接的权重低 2%，这个也不确定。
```

## CDN 回源
```
用 CDN 时一定要将来自搜索引擎的请求直接回源！
百度 CDN 里有明确说明：用户的域名在接入 CDN 后，因 CDN 频繁变更 IP 会影响域名搜索结果的权重。
用户可选择开启搜索引擎自动回源功能，将来自搜索引擎的请求直接回源，保证搜索引擎权重的稳定性。
```

## 域名解析
```
设置域名解析时向搜索引擎爬虫的 DNS（在添加记录的解析路线里可以看到该选项），返回源站的记录值。
如果用了 CDN，并且在 CDN 里配置了搜索引擎回源，这里就可以不配置了。
```

## 关键词不要太多