#!/bin/bash
USER=$(whoami)
ip_addr_list=`last | grep $USER | awk '{print $3}' | sort | uniq `

for ip_addr in ${ip_addr_list}
do
        result=`curl -s http://ip.taobao.com/service/getIpInfo.php?ip=${ip_addr}`
        result_code=`echo ${result} | awk -F',' '{print $1}' | awk -F':' '{print $2}'`
        result_info=`echo ${result} | awk -F':{' '{print $2}' | awk -F',' '{print $1,$2,$4,$5,$7}'`
        if [ "${result_code}" != "0" ];then
                echo -e "\e[1;32mIP：\e[0m${ip_addr} \e[1;32mERROR\e[0m please try again! "
        else
                echo ${result_info}
        fi
done

