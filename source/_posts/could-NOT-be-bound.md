---
post_url: could-NOT-be-bound
title: Angular4配置host后执行ng serve报Provided host a.api.***.com could NOT be bound...
date: 2017-12-06 15:31:10
tags: Angular
---
问题：Angular4在schema.json中配置host后执行ng serve报

Provided host aaa.com could NOT be bound. Please provide a different host address or hostname

解决：修改系统host，加入127.0.0.1 aaa.com
