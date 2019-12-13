#!/bin/bash
#第四部安装mySQL 5.7.27 
#配置备份repo并安装mysql
#echo -e '[mysql-server]\nname=mysql-5.7 server\nbaseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/\nenabled=1\ngpgcheck=0' > /etc/yum.repos.d/mysql-community.repo &&
#yum repolist && 
#yum install -y mysql-community-server.x86_64 &&
#cp /etc/my.cnf /etc/my.cnf.back && 
if [ ! -d "/opt/back" ];then mkdir -p /opt/back; else echo "/opt/back已经存在"; fi &&
if [ ! -d "/opt/tomcat" ];then mkdir -p /opt/tomcat; else echo "/opt/tomcat已经存在"; fi &&
cd /opt/back && zip -q -r repo.zip /etc/yum.repos.d/* &&

yum install mariadb-server -y &&

cp /etc/my.cnf /etc/my.cnf.back &&

#修改mysql配置文件
echo -e '#######################配置开始##########################' >> /etc/my.cnf &&

#innodb#Binary log#cache#connect#

echo -e '#######################innodb配置##########################' >> /etc/my.cnf &&
echo -e '#innodb\nuser=mysql\ninnodb_buffer_pool_size=6G\ninnodb_log_file_size=256M\ninnodb_log_buffer_size = 8M\ninnodb_flush_log_at_trx_commit=2\ninnodb_file_per_table=1\ninnodb_write_io_threads=4\ninnodb_flush_method=O_DIRECT\ninnodb_io_capacity=2000\ninnodb_io_capacity_max=6000\ninnodb_lru_scan_depth=2000\ninnodb_thread_concurrency = 0\ninnodb_autoinc_lock_mode = 2' >> /etc/my.cnf &&

echo -e '#######################Binary log配置##########################' >> /etc/my.cnf &&
echo -e '# Binary log/replication\n#log-bin\n#sync_binlog=1\n#sync_relay_log=1\nrelay-log-info-repository=TABLE\nmaster-info-repository=TABLE\nexpire_logs_days=7\nbinlog_format=ROW\ntransaction-isolation=READ-COMMITTED' >> /etc/my.cnf &&

echo -e '#######################cache配置##########################' >> /etc/my.cnf &&
echo -e '#cache\ntmp_table_size=512M\ncharacter-set-server=utf8\ncollation-server=utf8_general_ci\nskip-external-locking\nkey_buffer_size=1024M\nthread_stack=256k\nread_buffer_size=8M\nthread_cache_size=64\nquery_cache_size=128M\nmax_heap_table_size=256M\nquery_cache_type=1\nbinlog_cache_size = 2M\ntable_open_cache=128\nwait_timeout=30\njoin_buffer_size = 1024M\nsort_buffer_size = 8M\nread_rnd_buffer_size = 8M' >> /etc/my.cnf &&

echo -e '#######################connect配置##########################' >> /etc/my.cnf &&
echo -e '#connect\nmax-connect-errors=100000\nmax-connections=1000\n#################################################\nexplicit_defaults_for_timestamp=true\nsql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES\n##################################################\nskip_name_resolve = on\nopen_files_limit=65535\nback_log=30000\nnet_write_timeout=120\nlower_case_table_names=1' >> /etc/my.cnf &&

echo -e '#######################配置结束##########################' >> /etc/my.cnf &&

#备份mysql配置
cp /etc/my.cnf.back /opt/back &&
cp /etc/my.cnf /opt/back &&
md5sum /etc/my.cnf &&
md5sum /opt/back/my.cnf &&

systemctl start mariadb.service &&
systemctl status mariadb.service &&
systemctl enable mariadb.service &&
ps -ef | grep 3306  

#如果systemctl失败就手动添加systemctl管理服务
#echo -e '[Unit]\nDescription=MySQL Server\nAfter=network.target\n\n[Service]\nExecStart=/usr/bin/mysqld --defaults-file=/etc/my.cnf --datadir=/var/lib/mysql --socket=/var/lib/mysql/mysql.sock User=mysql\nGroup=mysql\nWorkingDirectory=/usr\n\n[Install]\nWantedBy=multi-user.target' > /etc/systemd/system/mysqld.service && systemctl daemon-reload && systemctl start mysql.service
