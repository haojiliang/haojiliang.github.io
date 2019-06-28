---
title: logstash 接收识别华为交换机 snmptrap 消息
post_url: logstash_snmptrap
date: 2019-06-28 14:55:35
tags: [logstash, snmptrap]
---
# 先看效果
![](/images/snmptrap.jpg)  
   
# 华为 MIB 获取
华为设备 MIB 获取方法：http://support.huawei.com/onlinetoolweb/infoM/index.do?domain=1&lang=zh&topicType=mib  
导出 excel 后取出所需的 OID 列即可  
![](/images/huaweimib.jpg)  
  
这是我基于华为 S5700-V200R013C00 整理的 logstash 用的 OID 信息：https://download.csdn.net/download/iaiot/11263207 
![](/images/huaweioid.jpg)  

# logstash 接收
将上一步整理的 yaml 文件放到 logstash yamlmibdir 目录
```
input{
  snmptrap {
    type => "snmptrap"
    id => "my_snmptrap"
    community => "***"
    port => "162"
    yamlmibdir => "/usr/share/logstash/vendor/bundle/jruby/1.9/gems/snmp-1.2.0/data/ruby/snmp/mibs"
  }
}
```

# docker 部署
使用 docker 部署 logstash 映射端口时需注意设备发的是 udp 消息  
compose.yml：
```
……
  ports:
     - "9600:9600"
     - "7777:7777"
     - "2224:2224"
     - "514:514/udp"
     - "2223:2223"
     - "162:162/udp"
……
```

# 相关概念
http://blog.sina.com.cn/s/blog_4502d59c0101fcy2.html