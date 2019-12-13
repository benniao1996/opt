#!/bin/bash
#第二步Tomcat 安装 9.0.14
#创建一个存放软件压缩包的文件夹
if [ ! -d "/opt/back" ];then mkdir -p /opt/back; else echo "/opt/back已经存在"; fi &&
if [ ! -d "/opt/tomcat" ];then mkdir -p /opt/tomcat; else echo "/opt/tomcat已经存在"; fi &&
#检查权限
ls -al /opt | grep back &&
ls -al /opt | grep tomcat &&
#更改权限
#chown -R $www:$www /opt/back &&
#chown -R $www:$www /opt/tomcat &&

#下载tomcat
cd /opt/back && 
rpm -qa | grep wget || yum -y install wget &&
rpm -qa | grep tar || yum -y install tar &&
wget http://archive.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz &&
tar zxvf apache-tomcat-9.0.14.tar.gz -C /opt/tomcat/ &&
pwd &&

#创建备份tomcat项目
cd /opt/tomcat/ && du -sh * &&
cp -r apache-tomcat-9.0.14 lottery-im-core &&
cp -r apache-tomcat-9.0.14 lottery-im-timetask && 
rpm -qa | grep unzip || yum -y install unzip &&
rpm -qa | grep zip || yum -y install zip &&
zip -q -r apache-tomcat-9.0.14.zip apache-tomcat-9.0.14 &&
mv apache-tomcat-9.0.14 back &&
zip -q -r all_tomcat_back.zip back lottery-im-core lottery-im-timetask &&
cp all_tomcat_back.zip /opt/back &&
pwd &&

#Tomcat使用apr模式需要安装apr, apr-utils两个包
#下载apr, apr-utils到/usr/local/src目录
if [ ! -d "/usr/local/src" ];then mkdir -p /usr/local/src; else echo "/usr/local/src已经存在"; fi &&
cd /usr/local/src &&
wget http://www.apache.org/dist/apr/apr-1.6.5.tar.gz && cp apr-1.6.5.tar.gz /opt/back &&
wget http://www.apache.org/dist/apr/apr-util-1.6.1.tar.gz && cp apr-util-1.6.1.tar.gz /opt/back &&
pwd &&

#编译安装apr依赖库
#yum安装一些必要的编译环境包
rpm -qa | grep make || yum -y install make &&
rpm -qa | grep gcc || yum -y install gcc &&
yum install -y libxml2-devel pcre-devel openssl-devel expat-devel && yum -y groupinstall "Development Tools" &&
cd /usr/local/src/ &&
if [ ! -d "/usr/local/apr" ];then mkdir -p /usr/local/apr; else echo "/usr/local/apr已经存在"; fi &&
tar -xzvf apr-1.6.5.tar.gz && cd apr-1.6.5 && ./configure --prefix=/usr/local/apr && make && make install &&
pwd &&

#编译安装apr-util
yum install -y expat-devel &&
cd /usr/local/src/ &&
if [ ! -d "/usr/local/apr-util" ];then mkdir -p /usr/local/apr-util; else echo "/usr/local/apr-util已经存在"; fi &&
tar -xzvf apr-util-1.6.1.tar.gz && cd apr-util-1.6.1 && ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && make && make install &&
pwd &&

#设置APR环境变量
echo -e 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib\nexport LD_RUN_PATH=$LD_RUN_PATH:/usr/local/apr/lib' > /etc/profile.d/apr.sh && source /etc/profile.d/apr.sh &&
cp /etc/profile.d/apr.sh /opt/back &&
pwd &&

#安装 tomcat-native 
mv /opt/tomcat/lottery-im-core/bin/tomcat-native.tar.gz /usr/local/src &&
cd /usr/local/src && 
tar -xzvf tomcat-native.tar.gz &&
cd tomcat-native-1.2.19-src/native/ && ./configure --with-apr=/usr/local/apr --with-java-home=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64 && make -j 4 && make install 
