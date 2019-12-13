#!/bin/bash
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
pwd 
