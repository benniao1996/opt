#!/bin/bash
#创建一个存放软件压缩包的文件夹
if [ ! -d "/opt/back" ];then mkdir -p /opt/back; else echo "/opt/back已经存在"; fi &&
if [ ! -d "/opt/tomcat" ];then mkdir -p /opt/tomcat; else echo "/opt/tomcat已经存在"; fi &&
#下载tomcat
cd /opt/back && 
rm -rf apache-tomcat-9.0.14.tar.gz &&
rpm -qa | grep wget || yum -y install wget &&
rpm -qa | grep tar || yum -y install tar &&
wget http://archive.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz &&
tar zxvf apache-tomcat-9.0.14.tar.gz -C /opt/tomcat/ &&
pwd &&

#创建备份tomcat项目
cd /opt/tomcat/ && du -sh * &&
cp -r apache-tomcat-9.0.14 lottery-im-timetask &&
rm -rf apache-tomcat-9.0.14 &&
rpm -qa | grep unzip || yum -y install unzip &&
rpm -qa | grep zip || yum -y install zip &&
zip -q -r lottery-im-timetask.zip lottery-im-timetask &&
cp lottery-im-timetask.zip /opt/back &&
pwd
