#!/bin/bash
# Complete System Report
echo '============================================'
echo '         COMPLETE SYSTEM REPORT'
echo '         '$(date)
echo '============================================'
echo ''
echo '--- SYSTEM INFO ---'
echo 'Hostname: '$(hostname)
echo 'OS:       '$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2)
echo 'Uptime:   '$(uptime -p)
echo 'CPU Cores:'$(nproc)
echo ''
echo '--- MEMORY ---'
free -h | awk '/Mem:/ {printf "Used: %s / Total: %s (Free: %s)\n", $3, $2, $4}'
echo ''
echo '--- DISK ---'
df -h | awk 'NR>1 {printf "%s used on %s\n", $5, $6}'
echo ''
echo '--- TOP 3 CPU PROCESSES ---'
ps aux --sort=-%cpu | awk 'NR>1 && NR<5 {printf "%s%% CPU: %s\n", $3, $11}'
echo ''
echo '--- TOP 3 MEMORY PROCESSES ---'
ps aux --sort=-%mem | awk 'NR>1 && NR<5 {printf "%s%% MEM: %s\n", $4, $11}'
echo ''
echo '--- RECENT ERRORS (syslog) ---'
sudo grep -i 'error' /var/log/syslog 2>/dev/null | tail -5 || echo 'No recent errors'
echo ''
echo '============================================
