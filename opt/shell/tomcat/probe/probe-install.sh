#!/bin/bash
#初稿
#tomcat安装probe监控
#检查目录和probe.war是否存在
#core=$(/opt/tomcat/lottery-im-core/webapps/)
#timetask=$(/opt/tomcat/lottery-im-timetask/webapps/)
#passwd=
if [ ! -d "/opt/tomcat/lottery-im-core/webapps/" ];then mkdir -p /opt/tomcat/lottery-im-core/webapps/; else echo "/opt/tomcat/lottery-im-core/webapps/已经存在"; fi &&
if [ ! -d "/opt/tomcat/lottery-im-timetask/webapps/" ];then mkdir -p /opt/tomcat/lottery-im-timetask/webapps/; else echo "/opt/tomcat/lottery-im-timetask/webapps/已经存在"; fi &&

cd /opt/tomcat/lottery-im-core/webapps/ &&
[ -f probe.war ] && echo "/opt/tomcat/lottery-im-core/webapps/probe.war缺失" || wget https://github.com/psi-probe/psi-probe/releases/download/3.2.0/probe.war &&
cd /opt/tomcat/lottery-im-timetask/webapps/ &&
[ -f probe.war ] && echo "/opt/tomcat/lottery-im-timetask/webapps/probe.war缺失" || wget https://github.com/psi-probe/psi-probe/releases/download/3.2.0/probe.war &&

#修改项目配置
sed -i "s/\<\/\tomcat-users\>/ \<role rolename\=\"manager-gui\"\/\>/g" /opt/tomcat/lottery-im-core/webapps/conf/tomcat-users.xml &&
echo -e "\<user username\=\"tomcat\" password\=\"1\" roles\=\"manager-gui\"\/\>\n\<\/\tomcat-users\>" >> /opt/tomcat/lottery-im-core/webapps/conf/tomcat-users.xml &&

#分离配置后这里会采取替换配置文件的方式

sed -i "s/\<\/\tomcat-users\>/ \<role rolename\=\"manager-gui\"\/\>/g" /opt/tomcat/lottery-im-timetask/webapps/conf/tomcat-users.xml &&
echo -e "\<user username\=\"tomcat\" password\=\"1\" roles\=\"manager-gui\"\/\>\n\<\/\tomcat-users\>" >> /opt/tomcat/lottery-im-timetask/webapps/conf/tomcat-users.xml &&

#重启tomcat

ps -ef|grep java|grep -v 'grep'|awk '{print $2}'|xargs kill -9 &&

#有几个项目就ps -ef|grep java|grep -v 'grep'|awk '{print $2}'出几个进程

cd /opt/tomcat/lottery-im-core/bin && ./startup.sh &&
cd /opt/tomcat/lottery-im-timetask/bin && ./startup.sh &&

ps -ef|grep java|grep -v 'grep'|awk '{print $2}'