---
post_url: shangqiao
title: 点击自定义按钮弹出百度商桥对话框
date: 2018-08-20 22:29:15
tags: seo
---
原文地址：https://blog.csdn.net/SeekerTime/article/details/66973659

在原文基础上做了一些优化。

在页面中已经成功安装了百度商桥的情况下，想通过点击自定义的按钮来弹出百度商桥的对话框，来达到及时沟通和不使页面跳转的目的。有以下解决方法：

1. 首先需要把你的按钮添加一个 class，例如 加一个 “shangqiao”

```html
<a class="shangqiao" href="javascript:void(0);" rel="nofollow">我要咨询</a>
// 其中 rel="nofollow" 是告诉蜘蛛无需追踪此 a 标签中的目标页
```
2. 然后在js中引入 jquery，添加一个
```js
$(function(){
    // 点击按钮时判断 百度商桥代码中的“我要咨询”按钮的元素是否存在，存在的话就执行一次点击事件
    $(".shangqiao").click(function(event) {
        if ($('#nb_invite_ok').length > 0) {
            $('#nb_invite_ok').click();
        }
    });
});
```
这样点击我要咨询按钮就可以调用百度商桥的咨询弹框(商桥在线时)或留言框(商桥离线时)了