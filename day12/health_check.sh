#!/bin/bash
# Server Health Check Script
# This is what real DevOps engineers run on servers
SERVICES='nginx ssh'
ALERT_CPU=80
ALERT_DISK=85
check_services() {
    echo '--- Service Status ---'
    for svc in $SERVICES; do
        if systemctl is-active --quiet $svc 2>/dev/null; then
            echo "  $svc: OK"
        else
            echo "  $svc: DOWN!"
        fi
    done
}
check_disk() {
    echo '--- Disk Usage ---'
    df -h | awk 'NR>1 {print "  "$5" used on "$6}'
}
check_memory() {
    echo '--- Memory ---'
    free -h | awk '/Mem:/ {print "  Used: "$3" / Total: "$2}'
}
echo '=============================='
echo '   SERVER HEALTH REPORT'
echo '   '$(date)
echo '=============================='
check_services
echo ''
check_disk
echo ''
check_memory
echo '=============================='
