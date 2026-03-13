#!/bin/bash
# This script is designed to run via cron
# Add to crontab: */10 * * * * /home/user/linux-learning/day13/scheduled_health_check.sh
LOG='/tmp/health_history.log'
DATE=$(date '+%Y-%m-%d %H:%M:%S')
# Disk check
DISK=$(df -h / | awk 'NR==2 {print $5}')
# Memory check
MEM=$(free | awk '/Mem:/ {printf "%.0f%%", $3/$2*100}')
echo "[$DATE] Disk: $DISK | Memory: $MEM" >> $LOG
# Alert if disk is over 80%
DISK_NUM=$(df / | awk 'NR==2 {print substr($5,1,length($5)-1)}')
if [ $DISK_NUM -gt 80 ]; then
echo "[$DATE] ALERT: Disk usage is $DISK" >> $LOG
fi

