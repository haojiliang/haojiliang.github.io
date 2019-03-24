---
post_url: pip-install-tensorflow
title: pip install tensorflow
date: 2018-10-23 11:27:45
tags: [python, tensorflow]
---
Win10 安装 Tensorflow 时：pip install tensorflow

报错：Could not find a version that satisfies the requirement tensorflow (from versions: ) No matching distribution found for tensorflow

原因：python 版本不对

解决：

1.python 版本和位数都需要和安装的 Tensorflow 版本对应，最新版的 python 也不兼容，要对应版本的。

2.https://pypi.org/project/tensorflow/ 左下角 Programming Language 可以查看安装的 Tensorflow 版本所需要的 python 版本。

3.python 官网下载页默认下载的 python 是32位的，注意需要下载对应位数的版本。

安装对应版本的 python 后就正常安装了。
![](/images/20181023113000234.png)