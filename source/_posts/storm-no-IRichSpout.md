---
post_url: storm-no-IRichSpout
title: Storm 本地调试 报 NoClassDefFoundError:org/apache/storm/topology/IRichSpout
date: 2018-09-07 11:58:16
tags: storm
---

Storm 本地调试 报 java.lang.NoClassDefFoundError: org/apache/storm/topology/IRichSpout

```java
java.lang.NoClassDefFoundError: org/apache/storm/topology/IRichSpout
	at java.lang.Class.getDeclaredMethods0(Native Method)
	at java.lang.Class.privateGetDeclaredMethods(Class.java:2701)
	at java.lang.Class.privateGetMethodRecursive(Class.java:3048)
	at java.lang.Class.getMethod0(Class.java:3018)
	at java.lang.Class.getMethod(Class.java:1784)
	at sun.launcher.LauncherHelper.validateMainClass(LauncherHelper.java:544)
	at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:526)
Caused by: java.lang.ClassNotFoundException: org.apache.storm.topology.IRichSpout
	at java.net.URLClassLoader.findClass(URLClassLoader.java:381)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:335)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
	... 7 more
Error: A JNI error has occurred, please check your installation and try again
Exception in thread "main" 
```

pom.xml 中去掉 <scope>provided</scope> 即可
```xml
<dependency>
    <groupId>org.apache.storm</groupId>
    <artifactId>storm-core</artifactId>
    <version>1.2.2</version>
    <!--<scope>provided</scope>-->
</dependency>
```

Maven Dependency Scope：http://uule.iteye.com/blog/2087485