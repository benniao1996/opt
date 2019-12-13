#!/bin/bash
#!/bin/sh
#if [ ! -d "/opt/shell/tomcat" ];then mkdir -p /opt/shell/tomcat; else echo "/opt/shell/tomcat已经存在"; fi
#交互式模块脚本
function tomcatmenu ()
{
 cat << EOF
----------------------------------------
|*************tomcat安装脚本*************|
----------------------------------------
`echo -e "\033[35m 1)lottery-im-core项目安装\033[0m"`
`echo -e "\033[35m 2)lottery-im-timetask项目安装\033[0m"`
`echo -e "\033[35m 3)apr依赖库安装\033[0m"`
`echo -e "\033[35m 4)native安装\033[0m"`
`echo -e "\033[35m 5)退出\033[0m"`
EOF
read -p "请输入对应功能的数字：" num1
case $num1 in
 1)
  echo "lottery-im-core项目安装!!"
  sh /opt/shell/tomcat/lottery-im-core-install.sh
  tomcatmenu
  ;;
 2)
  echo "lottery-im-timetask项目安装!!"
  sh /opt/shell/tomcat/lottery-im-timetask-install.sh
  tomcatmenu
  ;;
 3)
  echo "apr依赖库安装!!"
  sh /opt/shell/tomcat/apr-utils-install.sh
  tomcatmenu
  ;;
 4)
  echo "native安装!!"
  sh /opt/shell/tomcat/native-install.sh
  tomcatmenu
  ;;
 5)
  exit 0
esac
}
tomcatmenu
