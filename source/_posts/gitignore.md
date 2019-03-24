---
post_url: gitignore
title: idea 忽略不需要提交 git、svn 的目录或文件
date: 2018-09-07 16:29:47
tags: git
---
## 方法一：

项目根目录下新建 .gitignore 文件（详细参考：https://www.cnblogs.com/youyoui/p/8337147.html）
```
/target/*
/.idea/*
/src/test/*
*.iml
```

```
# .gitignore 规则不生效
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

## 方法二：

 新建一个 ChangeList，并把不需要提交的目录或文件拖进去
![](/images/20180907162520781.png)
 把不需要提交的目录或文件拖到 ignore 目录 
![](/images/2018090716255676.png)
 提交的时候选择要提交的目录
 ![](/images/20180907162713361.png)