---
post_url: storm-topology-message-timeout-secs
title: storm topology.message.timeout.secs 和 topology.max.spout.pending
date: 2018-08-01 17:33:52
tags: storm
---
storm 

 

topology.max.spout.pending：同时活跃的批的数量。这个值必须设置，用于限定同时可以处理的 batch 数量。编程人员可以通过 topology.max.spout.pending 设置这个值，默认是1。

 

topology.message.timeout.secs：如果调大了超时时间 jstorm kill mytopo 后 topo 一直处于 killed 状态，可以使用 jstorm kill mytopo 1 来终止 topo
