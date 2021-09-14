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
    echo "${GREEN}Cheking Nameservers"
    cat /etc/resolv.conf | grep "nameserver" 2>/dev/null
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

sshfiles() {
    echo "${RED}Checking SSH Files on Server"
    find / -name "*id_rsa*" -o -name "known_hosts" -o -name "authorized_keys" 2>/dev/null
    echo ""
    echo "${RED}Checking SSH Configuration on Server"
    cat /etc/ssh/sshd_config 2>/dev/null
    echo "-------------------------"
    echo ""
}


sqlenums() {
    echo "${RED}Enumurating SQL Servers"
    mysql --version 2>/dev/null
    psql -V 2>/dev/null
}

webserverenums() {
    echo "${RED}Enumurating WebServers"
    echo "${GREEN}"
    apache2 -v 2>/dev/null; httpd -v 2>/dev/null
    grep -i 'user\|group' /etc/apache2/envvars 2>/dev/null |awk '{sub(/.*\export /,"")}1' 2>/dev/null
    nginx -v 2>/dev/null
    echo "${RED}Cheking WebServer Passwords"
    find / -name ".htpasswd" 2>/dev/null
    sleep 1
    echo "-------------------------"
    echo ""
}

dockerenums() {
    echo "${RED}Docker Installation Cheking"
    id | grep -i docker 2>/dev/null
    docker --version
    echo "${GREEN}Searching Docker Files"
    find / -name "*DockerFile*" -name "*docker-compose.yml*" 2>/dev/null
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
    sshfiles
    sqlenums
    webserverenums
    dockerenums
    report
}

startShark

#End