#!/bin/bash
# Server Setup Simulator
# Simulates what you do when you get a new Linux server
echo '===================================='
echo '    SERVER SETUP SCRIPT v1.0'
echo '===================================='
echo ''
# Step 1: System info
echo '--- System Information ---'
echo 'Hostname: ' $(hostname)
echo 'User:     ' $(whoami)
echo 'Date:     ' $(date)
echo 'Uptime:   ' $(uptime -p)
echo ''
# Step 2: Create folder structure
echo '--- Creating Directory Structure ---'
mkdir -p /tmp/myserver/apps
mkdir -p /tmp/myserver/logs
mkdir -p /tmp/myserver/config
mkdir -p /tmp/myserver/scripts
mkdir -p /tmp/myserver/backup
echo 'Directories created!'
ls -la /tmp/myserver/
echo ''
# Step 3: Create config file
echo '--- Creating Config File ---'
cat > /tmp/myserver/config/app.conf << 'CONF'
APP_NAME=myapp
APP_PORT=8080
DB_HOST=localhost
DB_PORT=5432
LOG_LEVEL=INFO
CONF
echo 'Config created!'
cat /tmp/myserver/config/app.conf
echo ''
# Step 4: Create a log file with sample data
echo '--- Creating Sample Logs ---'
for i in {1..20}; do
    echo "$(date) INFO Log entry $i" >> /tmp/myserver/logs/app.log
done
echo '20 log entries created!'
echo ''
# Step 5: Set permissions
echo '--- Setting Permissions ---'
chmod 755 /tmp/myserver/scripts
chmod 644 /tmp/myserver/config/app.conf
chmod 666 /tmp/myserver/logs/app.log
echo 'Permissions set!'
echo ''
# Step 6: Log analysis
echo '--- Log Analysis ---'
echo 'Total log lines:' $(wc -l < /tmp/myserver/logs/app.log)
echo 'INFO entries:   ' $(grep -c 'INFO' /tmp/myserver/logs/app.log)
echo ''
echo '===================================='
echo '    SETUP COMPLETE!'
echo '===================================='

