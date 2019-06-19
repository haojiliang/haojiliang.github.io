---
post_url: linux-notes
title: Linux、CentOS、Windows、零散笔记
date: 2017-09-18 17:48:19
tags: [linux, windows]
---
一、Linux相关(以下均在CentOS中操作)
0.shell中引号的区别
![](/images/shell.jpg) 

1.安装sz/rz：yum install lrzsz

2.新建的.sh文件不能执行：chmod +x a.sh

3.创建目录：mkdir -p /data/nginx/{conf,conf.d,html,logs}

4.cat << EOF > EOF

新建或覆盖
cat << EOF > /root/xxx.txt
aaa
bbb
EOF
新建或文尾追加
cat << EOF >> /root/xxx.txt
aaa
bbb
EOF

5.linux swap（磁盘缓存）：当系统的物理内存不够用的时候，就需要将物理内存中的一部分空间释放出来，以供当前运行的程序使用。那些被释放的空间可能来自一些很长时间没有什么操作的程序，这些被释放的空间被临时保存到Swap空间中，等到那些程序要运行时，再从Swap中恢复保存的数据到内存中。这样，系统总是在物理内存不够时，才进行Swap交换。

6.查看目录大小：du -h --max-depth=1 /

du -sh /*

7.linux 定时任务：service crond status (start、stop、restart、reload、status)
cat <<EOF >  /root/cleanlog.cron
25,35 * * * * cd /root/cron/ && ./cleanlog.sh
EOF
添加任务：crontab cleanlog.cron
查看任务：crontab -l

删除修改添加任务：crontab -e
(minute) (hour) (day of month) (month) (day of week)
minute (0 - 59)
hour (0 - 23)
day of month (1 - 31)
month (1 - 12)
day of week (0 - 6) (Sunday=0 or 7)

8.查看前后几行
前后5行：cat access.log | grep -5 "Exception"
前后5行：cat access.log | grep -C 5 "Exception"
后5行：cat access.log | grep -A 5 "Exception"
前5行：cat access.log | grep -B 5 "Exception"

10.查找文件：find / -name *my.cnf*


11.Linux杀死进程(以关闭Elasticsearch为例)：
ps -ef | grep elastic

kill -9 进程号

或 kill $(ps -ef | grep elastic | awk '{print $2}')

原型：kill $(jps | awk '{print $1}')

$1：表示jps出来的第一个参数

 


12.hosts配置文件路径：/etc/hosts


13.查看和修改计算机名
查看：hostname

CentOS6修改：/etc/sysconfig/network中修改hostname=destname(目标名字)

CentOS7修改：/etc/hostname



14.resin日志
目录：/home/admin/resin/log
显示实时日志：tail -f jvm-app-0.log


15.查看文件实时更新：tail -f  aaaaa.log


16.Storm启停
启动：例：jstorm jar /home/admin/stormmy-0.1-jar-with-dependencies.jar com.iaiot.Topology.MyTopo /home/admin/conf.yaml
关闭：例：jstorm kill mytopo(拓扑名)


18.用户管理
添加用户：useradd admin
设置密码：passwd admin(回车设密码)
删除用户：userdel -rf admin
创建用户参数解释：useradd -s /sbin/nologin -M -g admin admin
        -s表示指定用户所用的shell，此处为/sbin/nologin，表示不登录
        -M表示不创建用户主目录
        -g表示指定用户的组名为admin
        最后的admin表示用户名


22.tar压缩解压
压缩：tar -zcvf /home/aa.tar.gz /aa/
解压：tar -zxvf aa.tar.gz
      tar -xvf  aa.tar


23.查看内存使用情况

free -h

free -m
其中-m是指以M为单位显示已用的和空闲的内存
详细可参考：http://www.cnblogs.com/zhaoyl/p/4325811.html
附查看所有文件系统使用情况：df -h
查看文件及文件夹的大小：du -h  
查看文件夹大小：du -h --max-depth=1 /usr/local/tomcat/logs/
查看文件夹下所有文件及文件夹大小：du -h --max-depth=1 /usr/local/tomcat/logs/*
--max-depth表示要查询目录的深度
参考：https://www.cnblogs.com/benio/archive/2010/10/13/1849946.html


24.chown
给指定用户授权指定目录：chown admin:admin -R /home/resin
查看指定用户所属用户组：groups admin
admin:admin ： 用户所属用户组：用户名



26.复制目录
cp -r dir1/ dir2/


28.resin启停（resin根目录下）
启动：java -jar lib/resin.jar start
停止：java -jar lib/resin.jar stop


29.vsftpd相关
安装：http://blog.csdn.net/the_victory/article/details/52192085
设置开机启动：chkconfig vsftpd on
注意：还要给ftp用户所访问的目录设置权限 例：chmod -R 777 /mnt/sites


30.用户与用户组相关操作
参考文章：http://www.cnblogs.com/jackyyou/p/5498083.html
          https://jingyan.baidu.com/article/a681b0de159b093b184346a7.html


31.查看系统时间命令：date


32.返回上一目录：cd -


33.找出包含某字符串的文件
grep -r vn_static_root /opt/verynginx/
参考：http://www.runoob.com/linux/linux-comm-grep.html
  
34.查看系统信息
版本：cat /etc/redhat-release
位数：getconf LONG_BIT


35.源码安装node.js
准备命令：yum -y install gcc make gcc-c++ openssl-devel wget
下载源码及解压：wget http://nodejs.org/dist/v0.10.26/node-v0.10.26.tar.gz
tar -zvxf node-v0.10.26.tar.gz
编译及安装：cd node-v0.10.26
make && make install
验证是否安装配置成功：node -v
参考地址：http://www.jianshu.com/p/783906f10d58


37.命令行下粘贴：Shift+Insert (Windows下也适用)


38.易读方式显示目录下文件大小：ll -h


39.查看登陆记录：last
参考：https://www.cnblogs.com/lizhaoxian/p/5981029.html


41.查看机器负载：
uptime
w
实时监控：top
参考：http://blog.csdn.net/szchtx/article/details/38455385



43.scp 远程复制
远程到本地：scp root@192.168.1.5:/home/admin/storm.jar /home/
本地到远程：scp /home/storm.jar root@192.168.1.5:/home/admin/

递归复制目录：scp -r /data/nginx/ root@192.168.153.150:/data/
参考：http://www.runoob.com/linux/linux-comm-scp.html


44.安装vim
yum install vim

 

 

47.查看 linux 网络状态：netstat

例：查看 FastDFS 运行状态：netstat -unltp|grep fdfs

 

 

51.XenServer

xe console-list

xe console uuid=7089a098-ed7a-4f9e-bd88-a916da2fd700

 

 

53.查看某个进程或者服务是否存在

ps -aux ｜ grep xxx

 

57.resin 配置到一个地址
```
<host id="message.api.mardi.com" root-directory=".">
            <host-alias>message.api.mardi.com</host-alias>
            <host-alias>message.api.iaiot.com</host-alias>
            <web-app id="/" root-directory="webapps/mardi_api" />
   </host>
```
 

58.查看centos内核版本

uname -r

 

59.CentOS 安装 jdk
```
# 下载java的jar包解压后在 /etc/profile 文尾添加如下配置
JAVA_HOME=/usr/java/jdk1.8.0_101
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar
export PATH JAVA_HOME CLASSPATH
# 添加上述配置后执行 source /etc/profile 使配置即时生效
```

二、Windows相关：
1.Windows下查找某目录下包含某字符串的文件方法
findstr -s -i "listener" *.*
-s:遍历当前目录及子目录
-i:忽略大小写
其他参数说明请参考：http://blog.csdn.net/zhiqiangzhan/article/details/5828533


3.Windows自动关机命令
3600秒后自动关机：shutdown -f -s -t 3600
撤销自动关机：shutdown -a
 

5.查看WinSCP记住的密码：

用winscppwd.exe，百度winscppwd

命令：winscppwd WINSCP.INI

 

 


三、Windows软件推荐：
1.本地全局文件搜索：Everything
2.Java class反编译工具：jd-gui
3.hosts管理工具：SwitchHosts

 

 


四、Note
1.代码中用空格代替tab
2.word2016不显示换行符：文件-选项-显示-段落标记-取消勾选
3.正则表达式(“[]”和“{}”可以实现大部分常规的表达式)
[]：表示其中的任何一个字符 [a-z],[0-9]
{}：表示出现的次数 a{3}
{m}：正好出现m次
{m,n}：最少m次，最多n次
{m,}：最少m次，没有上限
例：手机号码：1[34578][0-9]{9}

 

4.使用MyBatis Generator自动创建代码 命令：

java -jar mybatis-generator-core-1.3.2.jar -configfile generatorConfig.xml -overwrite

参考地址：https://blog.csdn.net/zhshulin/article/details/23912615
