---
post_url: pyspark-spark-shell-sparkDriver-failed
title: pyspark spark-shell无法指定被请求的地址:Service 'sparkDriver' failed after 16 retries (on a random free port)
date: 2018-12-23 22:32:25
tags: sparkDriver-failed
---
原文：https://stackoverflow.com/questions/49654050/could-not-bind-on-a-random-free-port-error-while-trying-to-connect-to-spark-mast

spark bin/pyspark 和 bin/spark-shell 报 无法指定被请求的地址: Service 'sparkDriver' failed after 16 retries (on a random free port)

pyspark -c spark.driver.bindAddress=127.0.0.1

安装：下载解压

配置：

vim /conf/spark-env.sh

export  SPARK_MASTER_HOST=192.168.0.200

export  SPARK_LOCAL_IP=192.168.0.200

启动：

./sbin/start-master.sh

![](/images/20181224205905268.png)