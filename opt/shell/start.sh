#!/bin/sh
if [ ! -d "/opt/shell" ];then mkdir -p /opt/shell; else echo "/opt/shell已经存在"; fi
#交互式模块脚本
function menu ()
{
 cat << EOF
----------------------------------------
|*************服务安装脚本*************|
----------------------------------------
`echo -e "\033[35m 1)web服务安装\033[0m"`
`echo -e "\033[35m 2)数据库服务安装\033[0m"`
`echo -e "\033[35m 3)防火墙端口放行\033[0m"`
`echo -e "\033[35m 4)退出\033[0m"`
EOF
read -p "请输入对应功能的数字：" num1
case $num1 in
 1)
  echo "Welcome to web服务安装!!"
  eleproduct_menu
  ;;
 2)
  echo "Welcome to 数据库服务安装!!"
  car_menu
  ;;
 3)
  echo "防火墙端口放行"
  sh /opt/shell/port/port-release.sh
  menu
  ;;
 4)
  exit 0
esac
}
 
function eleproduct_menu ()
{
 cat << EOF
----------------------------------------
|*************web服务安装**************|
----------------------------------------
`echo -e "\033[35m 1)jdk1.8环境安装\033[0m"`
`echo -e "\033[35m 2)nginx安装\033[0m"`
`echo -e "\033[35m 3)tomcat安装\033[0m"`
`echo -e "\033[35m 4)返回主菜单\033[0m"`
EOF
read -p "请输入对应功能的数字：" num2
case $num2 in
 1)
  echo "jdk1.8环境安装"
  sh /opt/shell/jdk/jdk-1.8.0-install.sh
  java -version
  eleproduct_menu
  ;;
 2)
  echo "nginx安装"
  sh /opt/shell/nginx/nginx-install.sh
  eleproduct_menu
  ;;
 3)
  echo -e "tomcat安装!!"
  sh /opt/shell/tomcat/tomcat-start.sh
  eleproduct_menu
  ;;
 4)
  clear
  menu
  ;;
 *)
  echo "请输入对应功能的数字!!"
  eleproduct_menu
esac
}
 
function car_menu ()
{
 cat << EOF
----------------------------------------
|************数据库服务安装*************|
----------------------------------------
`echo -e "\033[35m 1)mysql安装\033[0m"`
`echo -e "\033[35m 2)redis安装\033[0m"`
`echo -e "\033[35m 3)mongodb安装\033[0m"`
`echo -e "\033[35m 4)返回主菜单\033[0m"`
EOF
read -p "请输入对应功能的数字：" num3
case $num3 in
 1)
  echo "mysql安装!!"
  sh /opt/shell/mysql/mysql-install.sh
  car_menu
  ;;
 2)
  echo "redis安装!!"
  sh /opt/shell/redis/redis-install.sh
  car_menu
  ;;
 3)
  echo "mongodb安装!!"
  sh /opt/shell/mongodb/mongodb-install.sh
  car_menu
  ;;
 4)
  clear
  menu
  ;;
 *)
  echo "请输入对应功能的数字!!"
  car_menu
esac
}
menu

#####################################################
#模块放在/opt/shell下
