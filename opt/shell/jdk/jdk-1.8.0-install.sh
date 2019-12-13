#!/bin/bash
#第一步jdk1.8安装
#升级yum仓库防止安装到旧软件和依赖（最好是打包替换repo文件然后更新）
#yum update -y && (时间长)
#yum repolist && yum clean all && yum makecache &&
#安装之前先检查一下系统有没有自带open-jdk
#rpm -qa |grep java &&
#rpm -qa |grep jdk &&
#rpm -qa |grep gcj &&
#如果没有输出信息表示没有安装。

#如果安装可以使用rpm -qa | grep java | xargs rpm -e --nodeps 批量卸载所有带有Java的文件

rpm -qa | grep java | xargs rpm -e --nodeps &&

#首先检索包含java的列表
#yum list java* &&
#检索1.8的列表
#yum list java-1.8* &&
#安装1.8.0的所有文件
yum install java-1.8.0-openjdk* -y && java -version 
#这样安装有一个好处就是不需要对path进行设置，自动就设置好了
