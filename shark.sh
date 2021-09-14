#!/bin/bash
# Shark - An Awesome Linux Enum Suite
RED='\033[0;31m'
GREEN='\e[32m'
now=$(date +"%T")

info() {
    echo "${GREEN} Welcome To Shark Enum Suite"
    echo "${RED} github.com/invelsec - Burak Ayvaz"
    version="0.1"
    echo "${RED} Version -> $version"
    echo "${GREEN} Shark Scan Started -> ${now}"
    echo ""
    sleep 5
}

simpleChecks() {
    echo "${RED} Current User"
    whoami
    
    echo "${RED} User Groups"
    id
    
    passwd="cat /etc/passwd 2>/dev/null"
    if [ "$passwd" ];then
        echo "${GREEN} Passwd Data "
        cat /etc/passwd
        
    fi
    shadow="cat /etc/shadow 2>/dev/null"
    if [ "$shadow" ];then
        echo "${GREEN} Shadow Data "
        cat /etc/shadow
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

crons() {
    echo "${RED} Enumurating CronJobs"
    cron="ls -la /etc/crontab 2>/dev/null"
    if [ "$cron" ];then
        echo "${GREEN} Cronjobs Configured"
    fi
    cronread="cat /etc/crontab 2>/dev/null"
    if [ "$cronread" ];then
       echo "${GREEN} CronJobs"
       cat /etc/crontab
       
    fi
    sleep 1
    echo "-------------------------" 
    echo ""
}

sysinfo() {
    echo "${RED} SysInfo"
    uname="uname -a 2>/dev/null" 
    proc="cat /proc/version 2>/dev/null"
    host="hostname 2>/dev/null"
    if [ "$uname" ];then
        echo "${GREEN} Uname Info"
        uname -a
        
    fi
    if [ "$proc" ];then
        echo "${GREEN} Proc Info"
        cat /proc/version
        
    fi
    if [ "$host" ];then
        echo "${GREEN} Hostname"
        hostname
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

networking() {
    echo "${RED} Enumurating the network information"
    echo "Ifconfig"
    ifconfig
    
    echo "${GREEN} Arp List"
    arp -a
    
    echo "${GREEN} Current Public IP Address"
    curl ifconfig.me
    
    ufwLocation="/usr/sbin/ufw"
    ipTables="/etc/sysconfig/iptables"
    if [ -f $ufwLocation ];then
        echo "${GREEN} Ufw Found!"
    elif [ -f $ipTables ];then
        echo "${GREEN} IpTables Found!"
    fi
    echo "${GREEN} Checking TCP Listens"
    tcplist="netstat -ntlp 2>/dev/null"
    if [ "$tcplist" ];then
        echo "${GREEN} TCP Routes"
        netstat -ntlp
        
    fi
    echo "${GREEN} Cheking UDP Listens"
    udplist="netstat -nupl 2>/dev/null"
    if [ "$udplist" ];then
        echo "${GREEN} UDP Routes"
        netstat -nupl
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

procs() {
    echo "${RED} Enumurating Active Process"
    psa="ps aux 2>/dev/null"
    if [ "$psa" ];then
        echo "${GREEN} Active Procs"
        ps aux
        echo "${Green} End Active Procs"
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

suidchecks() {
    echo "${RED} Checking All Suid Files"
    find / -perm -u=s -type f 2>/dev/null
    sleep 1
    echo "-------------------------"
    echo ""
}

report() {
    now=$(date +"%T")
    echo "${GREEN} Shark Scan Complete! -> $now"
}   


startShark() {
    info
    simpleChecks
    sysinfo
    crons
    networking
    procs
    suidchecks
    report
}

startShark

#End