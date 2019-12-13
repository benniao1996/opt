#!/bin/bash
#第六步安装mongodb
echo -e '[mongodb-org-3.4]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc' >> /etc/yum.repos.d/mongodb-org-3.4.repo &&
cd /opt/back && 
zip -q -r mongodb_repo.zip /etc/yum.repos.d/* &&
yum repolist &&
yum install -y mongodb-org &&
echo 'MongoDB默认将数据文件存储在/var/lib/mongo目录，默认日志文件在/var/log/mongodb中。如果要修改,可以在 /etc/mongod.conf 配置中指定备用日志和数据文件目录' &&
#修改配置文件的 bind_ip, 默认是 127.0.0.1 只限于本机连接。所以安装完成后必须把这个修改为 0.0.0.0 ,否则通过别的机器是没法连接的!
cat /etc/mongod.conf | grep '127.0.0.1' | awk '{print $2}' &&
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &&
cat /etc/mongod.conf | grep '0.0.0.0' | awk '{print $2}' &&

service mongod start &&
service mongod status &&
service mongod enable &&
#停止命令service mongod stop
#查看mongoDB是否启动成功:
cat /var/log/mongodb/mongod.log | grep 'waiting for connections on port' &&
echo 'mongodb运行端口' 
