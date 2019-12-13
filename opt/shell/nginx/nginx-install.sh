#!/bin/bash
#第五步yum 安装nginx
#添加Nginx到YUM源
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm &&
if [ ! -d "/opt/back" ];then mkdir -p /opt/back; else echo "/opt/back已经存在"; fi &&
cd /opt/back && 
zip -q -r nginx_repo.zip /etc/yum.repos.d/* &&
yum repolist && 
yum install -y nginx && 
systemctl start nginx.service && 
systemctl status nginx.service &&
systemctl enable nginx.service &&

#开放80端口
#firewall-cmd --permanent --zone=public --add-port=80/tcp &&
#firewall-cmd --reload &&

#Nginx配置信息
echo -e '网站文件存放默认目录\n/usr/share/nginx/html' &&
echo -e '网站默认站点配置\n/etc/nginx/conf.d/default.conf' &&
echo -e '自定义Nginx站点配置文件存放目录\n/etc/nginx/conf.d/' &&
echo -e 'Nginx全局配置\n/etc/nginx/nginx.conf' &&
echo -e 'Nginx启动\nnginx -c nginx.conf' &&
echo -e 'Nginx预读更改的配置\nnginx -s reload' 

