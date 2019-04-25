---
post_url: travis_ci
title: Travis CI 持续集成
date: 2019-04-25 15:27:19
tags: [travis, devOps]
---

# Travis CI 生命周期(.travis.yml)
before_install：install 之前执行
install：安装依赖
before_script：script 之前执行
script：运行脚本
aftersuccess：script 成功后执行
afterfailure：script 失败后执行
before_deploy：deploy 之前执行
deploy：部署
after_deploy：deploy 之后执行
after_script：script 之后执行

# hexo .travis.yml 示例
```yml
language: node_js
sudo: required
node_js: 
  - 7.9.0

cache:
  directories:
    - node_modules

branches:
  only:
    - dev 

before_install:
  - npm install -g hexo-cli

# S: Build Lifecycle
install:
  - npm install
  - npm install hexo-deployer-git --save

before_script:
 # - npm install -g gulp

script:
  - hexo clean
  - hexo generate

after_script:
  - git config user.name "haojiliang"
  - git config user.email "hjl669@qq.com"
  - sed -i "s/access_tokens/${access_tokens}/g" ./_config.yml
  - hexo deploy
# E: Build LifeCycle
```

# 其他
其中配置中有不便于公开的参数值，比如用户名密码、各种 token 等都可以放到 Travis 的环境变量中，然后在代码中通过 ${env_key} 引用  
  
这个博客就是使用 Travis CI 构建的，见：https://github.com/haojiliang/haojiliang.github.io/tree/dev  