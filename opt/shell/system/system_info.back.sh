#!/bin/bash
 
date=`date "+%F %T"`
head="System information as of: $date"
 
kernel=`uname -r`
hostname=`echo $HOSTNAME`
 
#Cpu load
load1=`cat /proc/loadavg | awk '{print $1}'`
load5=`cat /proc/loadavg | awk '{print $2}'`
load15=`cat /proc/loadavg | awk '{print $3}'`
 
#System uptime
uptime=`cat /proc/uptime | cut -f1 -d.`
upDays=$((uptime/60/60/24))
upHours=$((uptime/60/60%24))
upMins=$((uptime/60%60))
upSecs=$((uptime%60))
up_lastime=`date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"`
 
#Memory Usage
mem_usage=`free -m | awk '/Mem:/{total=$2} /buffers\/cache/ {used=$3} END {printf("%3.2f%%",used/total*100)}'`
 
#Processes
processes=`ps aux | wc -l`
zombie_processes=`ps axo stat |grep Z |wc -l`
 
#Flavor
cpus=`cat /proc/cpuinfo |grep processor |wc -l`
mem=`cat /proc/meminfo |grep MemTotal|awk '{print $2/1024/1024+0.9}'|cut -d. -f1`
#disk=`lsblk -l |grep -w vd[a-z] |sed 's/G//g'|awk '{sum+=$4} END {print sum}'`
disk=`lsblk -l |grep -w vd[a-z] |sed 's/G//g'|awk '{print $4}'|awk 'BEGIN{FS="\n";RS="";ORS=""}{for(x=1;x<=NF;x++){print "-"$x"g"} print "\n"}'`
 
#User
users=`users | wc -w`
USER=`whoami`
 
#System fs usage
Filesystem=$(df -hP | awk '/^\/dev/{print $6}')
 
#Interfaces
INTERFACES=$(ip -4 ad | grep 'state ' | awk -F":" '!/^[0-9]*: ?lo/ {print $2}')
 
 
echo
echo -e "\t\033[34m*$head\033[0m"
printf "\n"
printf "\t""Kernel Version:\t%s\n" $kernel
printf "\t""HostName:\t%s\n" $hostname
printf "\t""System Load:\t%s %s %s\n" $load1, $load5, $load15
printf "\t""System Uptime:\t%s"d," %s"h," %s"m," %s"s"\n" $upDays $upHours $upMins $upSecs
printf "\t""Login Users:\t%s\t\tWhoami:\t%s\n" $users $USER
printf "\t""Processes:\t%s\t\tZombie Proce:\t%s\n" $processes $zombie_processes
printf "\t""Flavor Size:\t%sc_%sg%s\tMemory Usage:\t%s\n" $cpus $mem $disk $mem_usage
printf "\n"
printf "\t""Filesystem\tUsage\t\tTotal\n"
for f in $Filesystem
 do
    Usage=$(df -hP | awk '{if($NF=="'''$f'''") print $5}')
    Total=$(df -hP | awk '{if($NF=="'''$f'''") print $2}')
 
    echo -e "\t$f\t\t$Usage\t\t$Total"
 done
printf "\n"
printf "\t""Interface\tMAC Address\t\tIP Address\n"
for i in $INTERFACES
 do
    MAC=$(ip ad show dev $i | grep "link/ether" | awk '{print $2}')
    IP=$(ip ad show dev $i | awk '/inet / {print $2}' |awk 'BEGIN{FS="\n";RS="";ORS=""}{for(x=1;x<=NF;x++){print $x"\t"} print "\n"}')
    echo -e  "\e[1;31m\t"$i"\t\t"$MAC"\t$IP\e[0m"
 done
echo
