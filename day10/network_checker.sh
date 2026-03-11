#!/bin/bash
# Network Health Checker
echo '===== NETWORK HEALTH CHECK ====='
echo 'Date:' $(date)
echo ''
echo '--- My IP Address ---'
hostname -I
echo ''
echo '--- DNS Resolution Check ---'
for domain in google.com github.com stackoverflow.com; do
    IP=$(dig $domain +short | head -1)
    echo "$domain -> $IP"
done
echo ''
echo '--- Connectivity Check ---'
for host in google.com 8.8.8.8 1.1.1.1; do
    if ping -c 1 -W 2 $host > /dev/null 2>&1; then
        echo "$host: REACHABLE"
    else
        echo "$host: UNREACHABLE"
    fi
done
echo ''
echo '--- Open Ports ---'
ss -tuln | grep LISTEN
