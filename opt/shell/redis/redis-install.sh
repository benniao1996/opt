#!/bin/bash
#第三步安装redis  4.0.9
cd /usr/local/src && wget http://download.redis.io/releases/redis-4.0.9.tar.gz && 
cp redis-4.0.9.tar.gz /opt/back &&
tar -zxvf redis-4.0.9.tar.gz -C /usr/local/ && 
cd /usr/local/redis-4.0.9/ && cd src && make MALLOC=libc && make install &&
#配置redis作为守护进程运行
sed -i "s/daemonize no/daemonize yes/g" /usr/local/redis-4.0.9/redis.conf &&
#配置redis密码
sed -i "s/# requirepass foobared/requirepass yourpassword/g" /usr/local/redis-4.0.9/redis.conf &&
cp /usr/local/redis-4.0.9/redis.conf /opt/back &&
#指定redis.conf文件启动
/usr/local/bin/redis-server /usr/local/redis-4.0.9/redis.conf &&
#查看redis进程
ps -ef | grep  redis &&

#设置redis开机启动
if [ ! -d "/etc/redis" ];then mkdir -p /etc/redis; else echo "/etc/redis已经存在"; fi &&
cp /usr/local/redis-4.0.9/redis.conf /etc/redis/6379.conf &&
#将redis的启动脚本复制一份放到/etc/init.d目录下
cp /usr/local/redis-4.0.9/utils/redis_init_script /etc/init.d/redis &&
#添加如下两行注释内容
echo -e '# chkconfig:   2345 90 10  #添加内容\n# description:  Redis is a persistent key-value database  #添加内容' >> /etc/init.d/redis &&
cp /etc/init.d/redis /opt/back &&
#添加开机启动
chkconfig redis on &&
#重新加载配置文件
/usr/local/bin/redis-server /etc/redis/6379.conf &&

#检查服务启动情况
ps -ef | grep  redis && 
netstat -antpul | grep 6379 && 
echo -e "客户端测试\n/usr/local/bin/redis-cli -a yourpassword\nservice redis stop   #关闭\nservice redis start  #启动"
