---
post_url: jstorm-kill-mytopo-1
title: jstorm kill mytopo 后 Topology 一直处于 killed 状态
date: 2018-08-01 16:54:32
tags: jstorm
---
jstorm 设置了一个比较大的超时时间（topology.message.timeout.secs），导致 jstorm kill mytopo 后 Topology 一直处于 killed 状态，直到达到超时时间后 Topology 才结束。

解决：调低超时时间（topology.message.timeout.secs）值，如果将超时时间调低后导致数据处理不完，可以将 topology.max.spout.pending 调小，具体的按照实际业务场景配置。

 

或者直接 jstorm kill mytopo 1

意思是：1秒后立即停止 topo
