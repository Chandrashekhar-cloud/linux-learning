# Day 12 - Shell Scripting Part 2

## Theory
- Loops, functions, and error handling complete your scripting skills
- These turn simple scripts into real DevOps automation tools

## Loops

### For Loop - List
```bash
for name in Alice Bob Charlie; do
    echo "Hello $name"
done
```

### For Loop - Range
```bash
for i in {1..10}; do
    echo "Number: $i"
done
```

### For Loop - Files
```bash
for file in /var/log/*.log; do
    echo "Log file: $file"
done
```

### While Loop
```bash
COUNT=1
while [ $COUNT -le 5 ]; do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))
done
```

### Until Loop (opposite of while)
```bash
N=1
until [ $N -gt 5 ]; do
    echo $N
    N=$((N + 1))
done
```

## Functions

### Basic Function
```bash
greet() {
    local name=$1    # local = only exists inside function
    echo "Hello $name!"
}

# Call function
greet 'World'
greet 'DevOps'
```

### Function That Returns a Value
```bash
add_numbers() {
    local result=$(( $1 + $2 ))
    echo $result
}

SUM=$(add_numbers 10 20)
echo "Sum: $SUM"
```

### Function with If/Else
```bash
check_service() {
    local service=$1
    if systemctl is-active --quiet $service; then
        echo "$service is RUNNING"
    else
        echo "$service is STOPPED"
    fi
}

check_service nginx
check_service ssh
```

## Error Handling
```bash
#!/bin/bash
set -e   # Exit script if any command fails
set -u   # Error if undefined variable used

# Check exit status
mkdir /tmp/testdir
if [ $? -eq 0 ]; then
    echo 'Directory created successfully'
else
    echo 'Failed to create directory'
fi

# Trap errors
trap 'echo ERROR: Script failed at line $LINENO' ERR

# Redirect errors
command 2>/dev/null    # Hide error messages
command 2>>error.log   # Save errors to file
```

## Key Takeaways
- `local` inside functions keeps variables from leaking out — always use it
- `set -e` makes your script stop on first error — use in production scripts
- `set -u` catches typos in variable names — use with `set -e`
- `$((math))` for arithmetic — spaces don't matter inside
- `trap` catches errors and lets you clean up or log them
- `2>/dev/null` silences errors, `2>>file` saves them — know the difference
- Functions make scripts readable and reusable — always use them

## Scripts Written Today

### `day12/backup.sh` — Loops + Functions
```bash
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
```

### `day12/health_check.sh` — Real DevOps Script
```bash
#!/bin/bash
# Server Health Check Script
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
echo '     SERVER HEALTH REPORT'
echo '     '$(date)
echo '=============================='
check_services
echo ''
check_disk
echo ''
check_memory
echo '=============================='
```

## Git Commit
```bash
git add .
git commit -m "Day 12: shell scripting part 2 - loops functions error handling"
git push
```
