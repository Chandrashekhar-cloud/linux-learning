#!/bin/bash
# Process Monitor Script
echo '=== SYSTEM PROCESS REPORT ==='
echo 'Date:' $(date)
echo ''
echo '--- Top 5 CPU Consuming Processes ---'
ps aux --sort=-%cpu | head -6
echo ''
echo '--- Top 5 Memory Consuming Processes ---'
ps aux --sort=-%mem | head -6
echo ''
echo '--- Service Status Check ---'
for service in nginx ssh cron; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        echo "$service: RUNNING"
    else
        echo "$service: STOPPED"
    fi
done
