---
post_url: npm-angular-4058
title: npm install -g @angular/cli 报 Missing write access to... -4058 ENOENT:no such file or directory
date: 2018-11-22 14:43:36
tags: [angular, node]
---
删掉 C:\Users\adminstrator\AppData\Roaming\npm\node_modules\@angular\cli\node_modules 目录重新运行 npm install -g @angular/cli 就可以了
![](/images/20181122144236560.jpg)