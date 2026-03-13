#!/bin/bash
# Backup Script
BACKUP_DIR='/tmp/backups'
SOURCE_DIR=$HOME
DATE=$(date +%Y%m%d_%H%M%S)
create_backup() {
    local src=$1
    local dest=$2
    echo "Backing up $src to $dest..."
    mkdir -p $dest
    cp -r $src $dest/backup_$DATE 2>/dev/null
    echo 'Backup complete!'
}
check_space() {
    local available=$(df /tmp | awk 'NR==2 {print $4}')
    if [ $available -lt 100000 ]; then
        echo 'WARNING: Low disk space!'
    else
        echo "Available space: ${available}KB - OK"
    fi
}
echo '=== BACKUP SCRIPT ==='
check_space
create_backup $SOURCE_DIR $BACKUP_DIR
echo ''
echo 'Backup contents:'
ls -la $BACKUP_DIR/

