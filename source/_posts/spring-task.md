---
post_url: spring-task
title: java spring 定时任务
date: 2019-02-18 11:07:34
tags: spring
---
## xml 配置
```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:task="http://www.springframework.org/schema/task"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
      http://www.springframework.org/schema/beans/spring-beans.xsd
      http://www.springframework.org/schema/context
      http://www.springframework.org/schema/context/spring-context.xsd
      http://www.springframework.org/schema/tx
      http://www.springframework.org/schema/tx/spring-tx.xsd
      http://www.springframework.org/schema/aop
      http://www.springframework.org/schema/aop/spring-aop.xsd
      http://www.springframework.org/schema/task
      http://www.springframework.org/schema/task/spring-task.xsd
      http://www.springframework.org/schema/mvc
      http://www.springframework.org/schema/mvc/spring-mvc.xsd">
 
    <context:component-scan base-package="com.iaiot.xxx"/>
 
<!--定时任务-->
     <task:annotation-driven scheduler="myScheduler"/>
     <task:scheduler id="myScheduler" pool-size="5"/>
```

## Java 实现
```Java
package com.iaiot.xxx.task;
 
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
 
/**
 * 生成报告的定时任务
 *
 * @author xxx
 */
@Component
public class ReportTask {
 
    /**
     * Logger
     */
    private static Logger LOG = LoggerFactory.getLogger(ReportTask.class);
 
 
    /**
     * 生成日报的定时任务(每天凌晨1点执行)
     */
    @Scheduled(cron = "0 0 1 * * ?")
    public void generateDayReport() {
        LOG.info("开始生成日报..." + System.currentTimeMillis());
    }
 
    /**
     * 生成周报的定时任务(每周一凌晨2点30执行)
     */
    @Scheduled(cron = "0 30 2 ? * MON")
    public void generateWeekReport() {
        LOG.info("开始生成周报..." + System.currentTimeMillis());
    }
 
    /**
     * 生成月报的定时任务(每月1号凌晨4点执行)
     */
    @Scheduled(cron = "0 0 4 1 * ?")
    public void generateMonthReport() {
        LOG.info("开始生成月报..." + System.currentTimeMillis());
    }
 
}
```

## corn 表达式
每天凌晨1点执行：0 0 1 * * ?
每周一凌晨2点30执行：0 30 2 ? * MON
每月1号凌晨4点执行：0 0 4 1 * ?