---
title: CentOS 和 Windows 服务相关操作，配置开机自动启动等，Windows 脚本获取路径语法
post_url: linux-widows-service
date: 2018-11-20 20:49:59
tags:
---
## CentOS  服务（https://www.jianshu.com/p/7bd61fc1de4b）：
chkconfig  --add  xxx     //  把服务添加到  chkconfig  列表
chkconfig  --del  xxx      //  把服务从  chkconfig  列表中删除
chkconfig  xxx  on         //  开机启动
chkconfig  xxx  off         //  关闭开机启动
chkconfig  --list             //  查看所有  chklist  中服务
chkconfig  --list  xxx     //  查看指定服务

配置开机启动
chkconfig  --add  xxx
chkconfig  xxx  on

取消开机启动
chkconfig  xxx  off


CentOS7  下需要配置权限开机启动才能生效：
chmod  +x  /etc/rc.d/rc.local
chmod  +x  /etc/rc.d/init.d/xxx


启停服务
service  mysqld  start/stop
/etc/init.d/mysqld  start/stop

查看进程
ps  -ef    //  显示所有命令，连带命令行
ps  -aux  //  显示所有包含其他使用者的进程
ps  -aux  |  grep  xxx

 

## Windows  服务（https://blog.csdn.net/mubingyun/article/details/4567100）
cmd  或  bat  下可有两种方法打开，net和sc
net  用于打开没有被禁用的服务：  
启动  net  start  服务名
停止  net  stop  服务名

用  sc  可打开被禁用的服务（注意空格）：
sc  config  服务名  start=  demand     //手动
sc  condig  服务名  start=  auto          //自动
sc  config  服务名  start=  disabled    //禁用
sc  start  服务名
sc  stop  服务名(计算机管理→服务→服务item→右键→属性→服务名称)

 

## Windows 开机启动

将需要开机启动的软件快捷方式复制到启动目录；

启动目录：cmd→shell:startup


## Windows  脚本获取路径（https://blog.csdn.net/Sagittarius_Warrior/article/details/51516195）
@echo  off
echo  当前盘符：%~d0
echo  当前盘符和路径：%~dp0
echo  当前批处理全路径：%~f0
echo  当前盘符和路径的短文件名格式：%~sdp0
echo  当前CMD默认目录：%cd%
echo  目录中有空格也可以加入""避免找不到路径
echo  当前盘符："%~d0"
echo  当前盘符和路径："%~dp0"
echo  当前批处理全路径："%~f0"
echo  当前盘符和路径的短文件名格式："%~sdp0"
echo  当前CMD默认目录："%cd%"
pause

## 参考
```bash
#!/bin/sh
#
# start/restart/stop kp-server
#
# chkconfig: 2345 85 15
# description: start kp-server on boot time
 
start(){
        ssserver -c /etc/shadowsocks.json -d start
}
stop(){
        ssserver -c /etc/shadowsocks.json -d stop
}
restart(){
        ssserver -c /etc/shadowsocks.json -d restart
}
 
case "$1" in
start)
        start
        ;;
stop)
        stop
        ;;
restart)
        restart
        ;;
*)
        echo "Usage: $0 {start|restart|stop}"
        exit 1
        ;;
esac
```