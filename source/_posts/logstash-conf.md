---
post_url: logstash-conf
title: Logstash logstash.conf 配置示例
date: 2018-11-08 11:30:55
tags: logstash
---
Sample Logstash configuration for creating a simple
File -> Logstash -> Elasticsearch pipeline.

```conf
input {
  file {
    path => "/data/nginx/logs/access.log"
  }
}
 
filter {
  mutate {
    add_field => [ "[fields][path]", "%{[path]}"]
	add_field => [ "message]", "%{[message]}"]
  }
}
 
output {
  elasticsearch {
    hosts => ["http://192.168.153.7:9200"]
	index => "test-logstash"
  }
}
```

input 配置参考：https://www.elastic.co/guide/en/logstash/current/input-plugins.html
output 配置参考：https://www.elastic.co/guide/en/logstash/current/output-plugins.html
filter 配置参考：https://www.elastic.co/guide/en/logstash/6.4/filter-plugins.html
Logstash Reference：https://www.elastic.co/guide/en/logstash/6.4/index.html
