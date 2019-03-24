---
title: mysql笔记
post_url: mysql-notes
date: 2018-06-19 18:57:48
tags: mysql
---
1. centos下删除 卸载Mysql

yum remove  mysql mysql-server mysql-libs mysql-server;
find / -name mysql 将找到的相关东西delete掉；

rpm -qa|grep mysql(查询出来的东东yum remove掉)

2. 安装MySQL用户相关操作(%:通配符，此处表示允许该用户通过任意IP连接到数据库)：

设置 root 密码：SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpass');
创建用户：CREATE USER 'username'@'localhost' IDENTIFIED BY 'password'; 例：CREATE USER 'admin'@'%' IDENTIFIED BY '123456';
用户授权：GRANT privileges ON databasename.tablename TO 'username'@'host'; 例：GRANT ALL ON db1.* TO 'admin'@'%';
删除用户：drop user 'username'@'localhost'; 例：drop user 'admin'@'%';
查询用户：SELECT User, Host, Password FROM mysql.user;
刷新权限：flush privileges;
停止MySQL：/etc/init.d/mysqld stop
重启MySQL：/etc/init.d/mysqld restart
       或：service mysqld restart
启动MySQL：service mysqld start
查看是否有与MySQL相关的软件：rpm -qa | grep -i mysql
卸载相关软件：yum remove mysql mysql-server mysql-libs mysql-server
参考：https://jingyan.baidu.com/article/fec7a1e5f8d3201190b4e782.html
      https://zhidao.baidu.com/question/1603863845338636507.html
      http://www.cnblogs.com/snake-hand/p/3157247.html
      http://www.cnblogs.com/xiaoluo501395377/archive/2013/04/07/3003278.html
      http://www.jianshu.com/p/d7b9c468f20d
      http://blog.csdn.net/dbanote/article/details/12911851


3. 登录MySQL(注意无空格)：
本地登录：mysql -uroot -p123456 -P3306
远程登录：mysql -h192.168.1.2 -P3306 -uroot -p123456


4. MySQL数据迁移(备份恢复)
导出全部数据：mysqldump -uroot -p123456 db1 > db1.dump
只导出表结构：mysqldump -uroot -p123456 --no-data --databases db1 > db1.dump
导出远程MySQL数据：mysqldump -h192.168.1.2 -P3306 -uroot -p123456 db1 > db1.dump
导入：先创建目标数据库(create database db1;)，然后mysql -uroot -p123456 db1 < db1.dump
附：删除数据库：drop database db1;


5. MySQL部分迁移
选择某个数据库：use db1;
导出指定数据到文件：select * into OUTFILE 't1' from table1 where id in(2,3,5);
导入数据文件到数据库：LOAD DATA INFILE 't1' INTO TABLE t1;


6. MySQL-Linux通用版安装
该方法可以解决很多使用普通安装方式安装遇到的问题

https://blog.csdn.net/iaiot/article/details/80737630

 

7. 修改MySQL自增ID起始值:

alter table users AUTO_INCREMENT=1;

 

 

8. MySQL时间戳 时间查询转换

时间转时间戳：select UNIX_TIMESTAMP(update_time) from table1;

时间戳转时间：select FROM_UNIXTIME(create_time) from table1;

 

9. MySQL一次查询统计多条数据
```sql
select
count(case when u.audit_status = 1 AND u.isdeleted = 0 then u.audit_status end) AS verified,
count(case when u.audit_status = 2 AND u.isdeleted = 0 then u.audit_status end) AS disVerified,
count(case when u.audit_status = 0 AND u.isdeleted = 0 then u.audit_status end) AS unVerified,
count(1) total
from sc_user u
```

10. Windows下安装MySQL5.6 zip版

参考：https://jingyan.baidu.com/article/f3ad7d0ffc061a09c3345bf0.html

 

 

11. yum默认安装的那个MySQL版本时间字段不支持update_time和create_time同时自动设置时间，建议手动安装MySQL5.6以上版本；

 

12. MyBatis中取值时，#和$的区别

\#{} 这种取值是编译好SQL语句再取值 

${} 这种是取值以后再去编译SQL语句

动态拼接sql要用${}，${}会有SQL注入的风险

参考：https://www.jianshu.com/p/b3b4a4fb8a54
