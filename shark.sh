#!/bin/bash
# Shark - An Awesome Linux Enum Suite
info() {
    echo "Welcome To Shark Enum Suite"
    echo "github.com/invelsec - Burak Ayvaz"
    version="0.1"
    echo "Version -> $version"
    echo "-------------------------"
    echo ""
}

simpleChecks() {
    echo "Current User"
    whoami
    
    echo "User Groups"
    id
    
    passwd="cat /etc/passwd 2>/dev/null"
    if [ "$passwd" ];then
        echo "Passwd Data "
        echo "$passwd"
        
    fi
    shadow="cat /etc/shadow 2>/dev/null"
    if [ "$shadow" ];then
        echo "Shadow Data "
        echo "$shadow"
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

crons() {
    cron="ls -la /etc/crontab 2>/dev/null"
    if [ "$cron" ];then
        echo "Cronjobs Configured"
    fi
    cronread="cat /etc/crontab 2>/dev/null"
    if [ "$cronread" ];then
       echo "CronJobs"
       echo "$cronread"
       
    fi
    sleep 1
    echo "-------------------------" 
    echo ""
}

sysinfo() {
    echo "SysInfo"
    uname="uname -a 2>/dev/null" 
    proc="cat /proc/version 2>/dev/null"
    host="hostname 2>/dev/null"
    if [ "$uname" ];then
        echo "Uname Info"
        echo "$uname"
        
    fi
    if [ "$proc" ];then
        echo "Proc Info"
        echo "$proc"
        
    fi
    if [ "$host" ];then
        echo "Hostname"
        echo "$host"
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

networking() {
    echo "Enumurating the network information"
    echo "Ifconfig"
    ifconfig -a
    
    echo "Arp List"
    arp -a
    
    echo "Current Public IP Address"
    curl ifconfig.me
    
    ufwLocation="/usr/sbin/ufw"
    ipTables="/etc/sysconfig/iptables"
    if [ -f $ufwLocation ];then
        echo "Ufw Found!"
    elif [ -f $ipTables ];then
        echo "IpTables Found!"
    fi
    echo "Checking TCP Listens"
    tcplist="netstat -ntlp 2>/dev/null"
    if [ "$tcplist" ];then
        echo "TCP Routes"
        echo "$tcplist"
        
    fi
    echo "Cheking UDP Listens"
    udplist="netstat -nupl 2>/dev/null"
    if [ "$udplist" ];then
        echo "UDP Routes"
        echo "$udplist"
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

procs() {
    psa="ps aux 2>/dev/null"
    if [ "$psa" ];then
        echo "Active Procs"
        echo "$psa"
        
    fi
    sleep 1
    echo "-------------------------"
    echo ""
}

suidchecks() {
    echo "Checking All Suid Files"
    find / -perm -u=s -type f 2>/dev/null
    sleep 1
    echo "-------------------------"
    echo ""
}

report() {
    now=$(date +"%T")
    echo "Shark Scan Complete! -> $now"
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