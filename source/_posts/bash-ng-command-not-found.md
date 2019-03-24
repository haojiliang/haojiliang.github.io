---
title: ng不是内部或外部命令，也不是可运行的程序或批处理文件 或 bash:ng:command not found
post_url: bash-ng-command-not-found
date: 2018-11-22 14:49:13
tags: angular
---
重新以管理员权限运行 npm install -g @angular/cli

如果报错，就先删掉 C:\Users\adminstrator\AppData\Roaming\npm\node_modules\@angular\cli\node_modules 目录，然后再运行 npm install -g @angular/cli

等安装完成后 ng version 就可以了
![](/images/20181122191859785.png)