---
title: filebeat 作为服务启动，而非命令行启动时，传输一批数据后便停止工作 CRIT Unable to publish events to console
post_url: filebeat-error1
date: 2018-12-03 17:37:43
tags: filebeat
---
filebeat 作为服务启动，而非命令行启动时，传输一批数据后便停止工作，日志中输出如下信息：

2018-12-03T17:07:29+08:00 CRIT Unable to publish events to console: write /dev/stdout: The handle is invalid.
2018-12-03T17:07:29+08:00 INFO Error bulk publishing events: write /dev/stdout: The handle is invalid.

原因：

配置了 filebeat 控制台输出信息，而当 filebeta 作为服务启动时，控制台不可用，filebeat 就停止工作了

这是 filebeat 某些版本的 bug，后续版本应该修复了。

解决：

取消 filebeat 的控制台输出（注释掉下面两行）（Windows版和Linux版 通用）
![](/images/2018120317301921.png)
官方说明：https://discuss.elastic.co/t/filebeat-output-to-console-not-work/56692