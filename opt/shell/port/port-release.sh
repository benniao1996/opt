#!/bin/bash
#初始化变量的值
inputport1=''   #设置 inputport1 局部变量值为空                                 
#until 循环，当 inputport1 变量的值为 exit 时退出该循环
until [ "$inputport1" = exit ]
do
       echo -e '请输入需要放行的端口号:'
#读取键盘输入的数据
       read inputport1
#输入的不是 exit 时把用户输入的数据显示在屏幕上
       if [ "$inputport1" != exit ]
       then
               echo "正在放行端口:$inputport1: "  #输出变量 inputport1 的值
               firewall-cmd --permanent --zone=public --add-port=$inputport1/tcp
               firewall-cmd --reload
               echo "端口$inputport1 成功放行"
               echo
#当输入为 exit 时显示退出脚本的提示
       else
               echo 'Exit the script.'
       fi
done
