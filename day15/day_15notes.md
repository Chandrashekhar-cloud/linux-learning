# Day 15 - Full Revision + Final Project

## 15-Day Linux Journey Complete! 🎉

---

## Morning: Self-Test Answers
```bash
# 1. Show your IP address
hostname -I

# 2. Show all listening ports with process names
ss -tulnp

# 3. Find all .log files in /var/log
find /var/log -name "*.log"

# 4. Show last 20 lines of /var/log/syslog
tail -20 /var/log/syslog

# 5. Count ERROR lines in /var/log/syslog
grep -c "ERROR" /var/log/syslog

# 6. Create user "testdev" with home directory
sudo useradd -m testdev

# 7. Add testdev to sudo group
sudo usermod -aG sudo testdev

# 8. Set a file to permission 644
chmod 644 filename

# 9. Find all files larger than 5MB in home
find ~ -size +5M -type f

# 10. Top 5 processes by memory usage
ps aux --sort=-%mem | head -6

# 11. Disk usage of /var/log sorted by size
du -sh /var/log/* 2>/dev/null | sort -rh

# 12. Run command in background then kill it
sleep 100 &
kill %1

# 13. Check if nginx is running
systemctl status nginx

# 14. Search for "Failed" in auth.log
grep "Failed" /var/log/auth.log

# 15. Add env variable permanently
echo "export MY_VAR=value" >> ~/.bashrc
source ~/.bashrc
```

---

## 15-Day Complete Cheat Sheet

### Navigation & Files (Days 1-2)
```bash
pwd | ls -la | cd ~ | cd .. | cd -
touch | mkdir -p | cp -r | mv | rm -rf
echo "text" > file | echo "text" >> file
```

### Viewing & Searching (Days 3, 6)
```bash
cat | less | head -n | tail -n | tail -f
grep -inrcv | sed "s/old/new/g" | awk "{print $1}"
find . -name "*.sh" | find . -size +1M | which
```

### Permissions & Users (Days 4-5)
```bash
chmod 755/644/600 | chown user:group | chmod -R
sudo useradd -m | sudo passwd | sudo userdel -r
sudo usermod -aG | groups | id | whoami
```

### Processes & Services (Day 8)
```bash
ps aux | kill PID | kill -9 PID | pgrep
systemctl start/stop/restart/enable/status
journalctl -f | journalctl -u nginx
```

### Networking (Day 10)
```bash
ip addr show | ping -c 4 | traceroute
curl -I | curl -s URL | jq . | wget
ss -tulnp | lsof -i :80 | nmap localhost
dig +short | nslookup
```

### Package Management (Day 9)
```bash
sudo apt update | sudo apt install -y
sudo apt remove | dpkg -l | which
```

### Shell Scripting (Days 11-12)
```bash
#!/bin/bash | variables | $1 $2 $# $?
if/elif/else/fi | for/while/until loops
functions with local | set -e | set -u
trap | 2>/dev/null | 2>>error.log
```

### Cron + SSH + Disk (Day 13)
```bash
crontab -e | crontab -l
ssh user@server | ssh-keygen -t rsa -b 4096
scp file user@server:/path
df -h | du -sh * | sort -rh | lsblk
```

### Monitoring & Logs (Day 14)
```bash
free -h | uptime | nproc | vmstat 1 5
tail -f /var/log/syslog | journalctl -p err
env | export VAR=value | source ~/.bashrc
```

---

## Final Project: `day15/devops_toolkit.sh`
```bash
#!/bin/bash
# ============================================
# DEVOPS TOOLKIT - Linux Final Project
# Combines: Navigation, Files, Permissions,
# Users, grep/sed/awk, Processes, Networking,
# Monitoring, Logs, Shell Scripting
# ============================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}============================================${NC}"
}

check_status() {
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}[OK]${NC} $1"
    else
        echo -e "  ${RED}[FAIL]${NC} $1"
    fi
}

system_info() {
    print_header 'SYSTEM INFORMATION'
    echo "  Hostname : $(hostname)"
    echo "  User     : $(whoami)"
    echo "  Date     : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "  Uptime   : $(uptime -p)"
    echo "  CPU Cores: $(nproc)"
    echo "  OS       : $(cat /etc/os-release | grep PRETTY | cut -d= -f2 | tr -d '"')"
}

resource_check() {
    print_header 'RESOURCE USAGE'
    echo '  MEMORY:'
    free -h | awk '/Mem:/ {printf "    Used: %s / Total: %s\n", $3, $2}'
    echo '  DISK:'
    df -h | awk 'NR>1 {printf "    %s used on %s\n", $5, $6}'
    echo '  TOP PROCESSES:'
    ps aux --sort=-%cpu | awk 'NR>1 && NR<4 {printf "    %s%% CPU: %s\n", $3, $11}'
}

network_check() {
    print_header 'NETWORK STATUS'
    echo "  IP Address: $(hostname -I | awk '{print $1}')"
    echo '  Connectivity:'
    for host in google.com 8.8.8.8; do
        if ping -c 1 -W 2 $host > /dev/null 2>&1; then
            echo -e "    ${GREEN}[OK]${NC} $host reachable"
        else
            echo -e "    ${RED}[FAIL]${NC} $host unreachable"
        fi
    done
    echo '  Listening Ports:'
    ss -tuln | grep LISTEN | awk '{print "    Port: "$5}'
}

service_check() {
    print_header 'SERVICE STATUS'
    for service in nginx ssh cron; do
        if systemctl is-active --quiet $service 2>/dev/null; then
            echo -e "  ${GREEN}[RUNNING]${NC} $service"
        else
            echo -e "  ${YELLOW}[STOPPED]${NC} $service"
        fi
    done
}

log_analysis() {
    print_header 'LOG ANALYSIS'
    if [ -f /var/log/syslog ]; then
        echo "  Syslog errors (last hour):"
        sudo grep -i 'error' /var/log/syslog 2>/dev/null | \
             awk -v d="$(date -d '1 hour ago' '+%b %d %H')" '$0 > d' | \
             wc -l | xargs -I{} echo "    {} errors found"
    fi
    echo "  Disk warning check:"
    df -h | awk 'NR>1 {gsub(/%/,"",$5); if($5+0>70) \
        printf "    WARNING: %s is %s%% full!\n", $6, $5}'
}

# ---- MAIN MENU ----
while true; do
    echo ''
    echo -e "${YELLOW}=== DEVOPS TOOLKIT MENU ===${NC}"
    echo '  1. System Information'
    echo '  2. Resource Usage'
    echo '  3. Network Status'
    echo '  4. Service Status'
    echo '  5. Log Analysis'
    echo '  6. Run All Checks'
    echo '  7. Exit'
    echo ''
    read -p 'Choose option (1-7): ' CHOICE
    echo ''
    case $CHOICE in
        1) system_info ;;
        2) resource_check ;;
        3) network_check ;;
        4) service_check ;;
        5) log_analysis ;;
        6) system_info; echo; resource_check; echo; network_check; echo; service_check; echo; log_analysis ;;
        7) echo 'Goodbye!'; exit 0 ;;
        *) echo 'Invalid option' ;;
    esac
done
```

---

## README.md Update (root of repo)
```markdown
# Linux Learning Journey 🐧

## 15 Days of Linux for DevOps - COMPLETED ✅

| Day | Topic | Status |
|-----|-------|--------|
| Day 01 | Terminal Basics + Navigation | ✅ |
| Day 02 | File & Directory Management | ✅ |
| Day 03 | Viewing Files + Finding Files | ✅ |
| Day 04 | File Permissions + Ownership | ✅ |
| Day 05 | Users & Groups Management | ✅ |
| Day 06 | Text Processing: grep, sed, awk | ✅ |
| Day 07 | Revision Days 1-6 | ✅ |
| Day 08 | Process Management + systemd | ✅ |
| Day 09 | Package Management (apt) | ✅ |
| Day 10 | Networking Commands | ✅ |
| Day 11 | Shell Scripting Part 1 | ✅ |
| Day 12 | Shell Scripting Part 2 | ✅ |
| Day 13 | Cron Jobs + SSH + Disk Management | ✅ |
| Day 14 | System Monitoring + Logs + Env Variables | ✅ |
| Day 15 | Full Revision + Final Project | ✅ |

## Final Project
`day15/devops_toolkit.sh` — Interactive DevOps toolkit combining all 15 days
```

## Git Commit
```bash
git add .
git commit -m "Day 15: COMPLETE - Linux mastery final project DevOps toolkit"
git push
```
