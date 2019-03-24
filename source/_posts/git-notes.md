---
post_url: git-notes
title: git 笔记
date: 2018-04-04 16:23:45
tags: git
---
VCS→Import into→Version Control→Create Git Repository→选择本地项目目录→OK

git add→commit→push，其中 push 之前会提示先输入 Git 项目地址

 

1. 用 IDEA 上传本地项目到码云/Github：https://blog.csdn.net/zsyoung/article/details/76891211

 

2. git config --global user.name "hjl666"
    git config --global user.email "hjl666@iaiot.com"

 

3. git clone -b dev url （克隆指定分支或tags）

git status

git add ./src/*

git commit -m "fix bugs"

git push origin master:dev

删除远程 dev 分支：git push origin :dev

*******************

To https://github.com/haojiliang/haojiliang.github.io.git

 ! [remote rejected] public (refusing to delete the current branch: refs/heads/public)

error: failed to push some refs to 'https://github.com/haojiliang/haojiliang.github.io.git'

删除远程分支时出现这个错误是因为，dev是当前项目的默认分支，github→Settings→Branches→改一下 Default branch 即可。

********************

 

 

4. git init

git add ./src/*

git commit -m "fix bugs"

git remote add origin https://github.com/haojiliang/haojiliang.github.io.git

git push origin master
