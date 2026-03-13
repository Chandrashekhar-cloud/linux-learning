# Day 13 - Cron Jobs + SSH + Disk Management

## Theory
- Automate tasks + connect to remote servers
- Backup at 2AM, health check every 5 minutes, clean logs on Sundays — all automated
- SSH is how you connect to every cloud server you'll ever manage

---

## Part 1: Cron Jobs — Scheduled Automation

### Cron Format
```
# minute hour day month weekday command
#   *      *    *    *      *     command
#   |      |    |    |      |
#   |      |    |    |      +-- Day of week (0=Sunday, 6=Saturday)
#   |      |    |    +----- Month (1-12)
#   |      |    +-------- Day of month (1-31)
#   |      +----------- Hour (0-23)
#   +-------------- Minute (0-59)
```

### Cron Examples
```bash
*/5 * * * *    # Every 5 minutes
0 2 * * *      # Every day at 2:00 AM
0 9 * * 1      # Every Monday at 9:00 AM
0 0 1 * *      # First day of every month at midnight
@reboot        # Run once when system starts
```

### Cron Commands
| Command | What it does |
|---------|-------------|
| `crontab -e` | Open and edit your cron jobs |
| `crontab -l` | List all your cron jobs |
| `crontab -r` | Delete ALL your cron jobs (careful!) |
| `cat /etc/crontab` | System-wide cron file |
| `ls /etc/cron.d/` | System cron job files |
| `ls /etc/cron.daily/` | Scripts that run daily automatically |

---

## Part 2: SSH Basics

| Command | What it does |
|---------|-------------|
| `ssh user@server` | Connect to remote server |
| `ssh -p 2222 user@server` | Connect on custom SSH port |
| `ssh-keygen -t rsa -b 4096` | Generate SSH key pair (private + public) |
| `ssh-copy-id user@server` | Copy public key to server (passwordless login) |
| `cat ~/.ssh/id_rsa.pub` | See your public key |
| `scp file user@server:/path` | Copy file TO server |
| `scp user@server:/file /local` | Copy file FROM server |
| `scp -r dir user@server:/path` | Copy entire folder to server |
| `exit` | Disconnect from SSH session |

### SSH Key Notes
- `id_rsa` = private key — NEVER share this
- `id_rsa.pub` = public key — paste this on servers
- `~/.ssh/` folder stores both keys
- Passwordless login = paste your public key into server's `~/.ssh/authorized_keys`

---

## Part 3: Disk Management

| Command | What it does |
|---------|-------------|
| `df -h` | Show disk space (human readable) |
| `df -h /home` | Check space for specific path |
| `du -sh foldername/` | Size of a specific folder |
| `du -sh *` | Size of everything in current folder |
| `du -sh * \| sort -rh` | Sort by size, largest first |
| `du -sh * \| sort -rh \| head` | Top 10 largest items |
| `lsblk` | List all disks and partitions |
| `find / -size +100M -type f 2>/dev/null` | Find files bigger than 100MB |

---

## Key Takeaways
- Cron log file won't exist until after the first run — wait 1-2 minutes!
- Always use full paths in cron scripts — cron has no PATH like your terminal
- `*/5` means "every 5 minutes", `5` alone means "at minute 5 only"
- Private key (`id_rsa`) = your password — never share, never commit to GitHub!
- `df -h` for disk space, `du -sh` for folder sizes — use both daily
- `sort -rh` sorts human-readable sizes correctly (GB > MB > KB)

## Script Written Today

**`day13/scheduled_health_check.sh`**
```bash
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
```

### Add to crontab:
```bash
crontab -e
# Add this line (replace YOURUSERNAME):
*/10 * * * * /home/YOURUSERNAME/linux-learning/day13/scheduled_health_check.sh
```

## Git Commit
```bash
git add .
git commit -m "Day 13: cron jobs + SSH + disk management"
git push
```
