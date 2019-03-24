---
post_url: JMeter-URISyntaxException
title: JMeter java.net.URISyntaxException
date: 2017-10-13 11:15:02
tags: JMeter
---
问题复现：在url中传json等有特殊字符的数据时；


解决办法：把url中的参数进行url编码再进行请求；


url在线编码工具：http://tool.oschina.net/encode?type=4