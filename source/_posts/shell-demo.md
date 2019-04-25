---
post_url: shell_demo
title: elasticsearch 数据维护脚本 shell
date: 2019-04-25 13:06:33
tags: [shell, elasticsearch]
---
# 需求：
定期清理 elasticsearch 中 n 天以前的数据

# 实现：
通过shell脚本实现：
选择功能模块（
1.清理日志
2.添加清理任务
3.删除清理任务
）
清理日志：手动清理指定天数之前的日志数据
添加清理任务：包含内置的清理周期(小时、天、周、月)
删除清理任务：删除添加的日志清理任务

# 脚本代码
```shell
#!/bin/bash
clear
echo
echo "######################################################"
echo "#               es 数据维护工具                        #"
echo "#     脚本工具谨慎使用，误操作会导致es数据被误删           #"
echo "######################################################"
echo

# Current directory
cur_dir=`pwd`

# es url(Please configure this parameter)
eshost="http://127.0.0.1:9200"

# Function module
module=(
清理日志
添加清理任务
删除清理任务
)

# Log cleaning cycle
cycle=(
每小时
每天
每周
每月
)

# Log cleaning cycle value
cycle_dir=(
hourly
daily
weekly
monthly
)

# Highlight Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# Manual log cleaning
clean(){
    while true
    do
	read -p "请输入清理多少天以前的数据，须大于180（默认：365*2）:" days
    [ -z "$days" ] && days=730
	expr ${days} + 1 &>/dev/null
	if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] 请输入整数数字"
        continue
    fi
	if [ $days -lt 180 ]
    then
       echo -e "[${yellow}Warning${plain}] 只能清理180天以前的数据"
	   continue
    else
       echo -e "[${red}提示${plain}] 该操作将清理${days}天以前的所有日志数据" 
       read -s -n1 -p "按任意键继续或Ctrl+C取消..."
	   echo
       echo "开始清理..."
	   input_date=`date -d "${days} days ago" +%Y-%m-%d`
	   curl -X POST -u elastic:changeme "${eshost}/_all/_delete_by_query" -H 'Content-Type: application/json' -d"
          {
            \"query\": {
              \"range\": {
                \"@timestamp\": {
				   \"format\": \"yyyy-MM-dd HH:mm:ss\",
				   \"lt\":\"${input_date} 00:00:00\"
				}
              }
            }
          }
          "
       echo
	   echo "清理完成！"
    fi
	break
    done
}

# Add timed tasks to clean up logs
install_clean_tasks(){
    while true
    do
    echo -e "请选择日志清理周期:"
    for ((i=1;i<=${#cycle[@]};i++ )); do
        hint="${cycle[$i-1]}"
        echo -e "${green}${i}${plain}) ${hint}"
    done
    read -p "请选择日志清理周期:(默认: 1):" pick
    [ -z "$pick" ] && pick=1
    expr ${pick} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] 请输入一个介于1和${#cycle[@]}之间的数字"
        continue
    fi
    if [[ "$pick" -lt 1 || "$pick" -gt ${#cycle[@]} ]]; then
        echo -e "[${red}Error${plain}] 请输入一个介于1和${#cycle[@]}之间的数字"
        continue
    fi
    selected=${cycle[$pick-1]}
    echo
    echo "---------------------------"
    echo "已选：${selected}"
    echo "---------------------------"
    echo
    break
    done
	
	while true
    do
	read -p "请输入清理多少天以前的数据，须大于180（默认：365*2）:" days
    [ -z "$days" ] && days=730
	expr ${days} + 1 &>/dev/null
	if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] 请输入整数数字"
        continue
    fi
	if [ $days -lt 180 ]
    then
       echo -e "[${yellow}Warning${plain}] 只能清理180天以前的数据"
	   continue
    else
       input_date=`date -d "${days} days ago" +%Y-%m-%d`
	   cat << EOF > /etc/cron.${cycle_dir[$pick-1]}/esdata_clean_${days}.sh
#!/bin/sh
#
# The task of regularly cleaning esdatas
#
# chkconfig: 2345 85 15
# description: www.iaiot.com
echo "开始清理${days}天以前的数据..."
curl -X POST -u elastic:changeme "${eshost}/_all/_delete_by_query" -H 'Content-Type: application/json' -d"
          {
            \"query\": {
              \"range\": {
                \"@timestamp\": {
				   \"format\": \"yyyy-MM-dd HH:mm:ss\",
				   \"lt\":\"${input_date} 00:00:00\"
				}
              }
            }
          }
          "
echo "清理完成！"
EOF
       chmod +x /etc/cron.${cycle_dir[$pick-1]}/esdata_clean_${days}.sh
    fi
	break
    done
	
	echo -e "${green}清理任务已添加！${plain}"
}

# Todo：Add cron timed tasks to clean up logs
install_clean_task_cron(){
	read -p "请输入cron表达式(默认: 0 0 1 * * ?):" cron
    [ -z "$cron" ] && cron="0 0 1 * * ?"
    # ...
    #chmod +x /etc/cron.d/esdata_clean.sh
}

# Delete timed tasks for log cleanup
uninstall_clean_tasks(){
    echo -e "[${red}提示${plain}] 该操作将删除所有已添加的鲲鹏日志清理任务" 
    read -s -n1 -p "按任意键继续或Ctrl+C取消..."
    rm -rf /etc/cron.hourly/esdata_clean*.sh
	rm -rf /etc/cron.daily/esdata_clean*.sh
	rm -rf /etc/cron.weekly/esdata_clean*.sh
	rm -rf /etc/cron.monthly/esdata_clean*.sh
	echo
	echo "已删除"
	echo
}

# Main
main(){
    # Select function module
    while true
    do
    echo -e "请选择功能模块"
    for ((i=1;i<=${#module[@]};i++ )); do
        hint="${module[$i-1]}"
        echo -e "${green}${i}${plain}) ${hint}"
    done
    read -p "请选择功能模块(默认: 1):" pick
    [ -z "$pick" ] && pick=1
    expr ${pick} + 1 &>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "[${red}Error${plain}] 请输入一个介于1和${#module[@]}之间的数字"
        continue
    fi
    if [[ "$pick" -lt 1 || "$pick" -gt ${#module[@]} ]]; then
        echo -e "[${red}Error${plain}] 请输入一个介于1和${#module[@]}之间的数字"
        continue
    fi
    selected=${module[$pick-1]}
    echo
    echo "---------------------------"
    echo "已选：${selected}"
    echo "---------------------------"
    echo
    break
    done
	
    case ${pick} in
        1)  clean
        ;;
        2)  install_clean_tasks
        ;;
        3)  uninstall_clean_tasks
        ;;
    esac
}

main
```