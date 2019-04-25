---
post_url: travis_ci
title: Travis CI 持续集成
date: 2019-04-25 15:27:19
tags: [travis, devOps]
---

# .travis.yml
before_install：install 阶段之前执行
before_script：script 阶段之前执行
after_failure：script 阶段失败时执行
after_success：script 阶段成功时执行
before_deploy：deploy 步骤之前执行
after_deploy：deploy 步骤之后执行
after_script：script 阶段之后执行

# travis 完整生命周期
before_install
install
before_script
script
aftersuccess or afterfailure
before_deploy
deploy
after_deploy
after_script

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
其中配置中有不便于公开的参数值，比如用户名密码、各种 token 等都可以放到 Travis 的环境变量中，然后在代码中通过 ${env_key} 引用  
  
这个博客就是使用 Travis CI 构建的，见：https://github.com/haojiliang/haojiliang.github.io/tree/dev  