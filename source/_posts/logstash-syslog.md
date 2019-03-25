---
post_url: logstash-syslog
title: logstash 接收 syslog 消息调试
date: 2019-02-22 16:03:50
tags: [logstash, syslog]
---

linux logger、rsyslog：
logger 生成 message 日志：logger -t aaaaaaaaa mmmmmmmmmmm
查看生成的日志：tail -f /var/log/messages
rsyslog 配置：/etc/rsyslog.conf
配置 rsyslog 输出到指定地址（如 logstash）：
![](/images/20190222155850774.png)
重启 rsyslog 服务：service rsyslog restart
  
logstash 接收 rsyslog 消息：
```yml
input {
  syslog {
    port => "514"
    add_field => [ "type", "syslog"]
  }
}
 
filter {
  if "syslog" in [type]
    {
       grok {}
       mutate {
        add_field => [ "a", "%{[host]}"]
        add_field => [ "b", "0"]
       }
    }
  geoip {}
}
 
output {
  kafka {
    bootstrap_servers => "192.168.0.100:9092"
    topic_id => "tttttest"
    #compression_type => "snappy"
    codec => "json"
  } 
 
 # stdout { codec => rubydebug }  # 调试输出
}
```