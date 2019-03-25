---
post_url: javah-hellondk
title: 用javah导出类的头文件，Not a valid class name或者错误:找不到 HelloNDK 的类文件
date: 2016-08-28 14:50:33
tags: [android, ndk]
---
1. Exception in thread "main" java.lang.IllegalArgumentException: Not a valid class name: HelloNDK.class

错误写法：L:\ndk\HelloNDK2\bin\classes>javah -jni com.iaiot.hellondk2.GetString.class

原因：不能指明扩展名.class

正确写法：L:\ndk\HelloNDK2\bin\classes>javah -jni com.iaiot.hellondk2.GetString

2. 错误: 找不到 'HelloNDK' 的类文件

原因：环境变量classpath配置错误

解决方法：将android.jar写到classpath里面；
![](/images/20160828144815858.png)

参考地址：http://stackoverflow.com/questions/17631116/java-lang-illegalargumentexception-not-a-valid-class-name-android-ndk-javah