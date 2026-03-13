# Day 14 - System Monitoring + Logs + Environment Variables

## Theory
- Watch your system. Read its story in logs.
- Monitoring and log reading are core daily DevOps/SRE skills

---

## Part 1: System Monitoring

| Command | What it does |
|---------|-------------|
| `free -h` | RAM usage (human readable) |
| `free -h \| grep Mem` | Just the memory line |
| `vmstat 1 5` | System stats every 1 second, 5 times |
| `uptime` | Uptime + load average |
| `cat /proc/cpuinfo \| grep "model"` | CPU model info |
| `nproc` | Number of CPU cores |
| `cat /proc/meminfo \| head -10` | Detailed memory info |
| `ps aux --sort=-%cpu \| head -6` | Top 5 CPU hungry processes |
| `ps aux --sort=-%mem \| head -6` | Top 5 memory hungry processes |
| `watch -n 2 free -h` | Live memory update every 2 seconds |
| `watch -n 1 "ps aux --sort=-%cpu \| head"` | Live top CPU processes |
| `iostat 1 3` | CPU and disk I/O stats (3 readings) |

---

## Part 2: Log Files

| Command | What it does |
|---------|-------------|
| `tail -f /var/log/syslog` | Live system log — most important |
| `tail -50 /var/log/syslog` | Last 50 lines of syslog |
| `grep "error" /var/log/syslog` | Find errors in syslog |
| `cat /var/log/auth.log \| tail -20` | Recent authentication events |
| `grep "Failed" /var/log/auth.log` | Failed login attempts |
| `journalctl -f` | Live systemd journal |
| `journalctl -u nginx` | Logs for nginx service only |
| `journalctl --since "1h ago"` | Last 1 hour of logs |
| `journalctl -p err` | Only error-level log entries |
| `dmesg \| tail -20` | Recent kernel messages |
| `dmesg \| grep -i error` | Kernel errors |

---

## Part 3: Environment Variables

| Command | What it does |
|---------|-------------|
| `env` | List ALL environment variables |
| `echo $HOME` | Your home directory |
| `echo $PATH` | Where Linux looks for commands |
| `echo $USER` | Current username |
| `echo $SHELL` | Your current shell |
| `export NAME=John` | Set variable for current session |
| `echo $NAME` | Use the variable |
| `unset NAME` | Delete a variable |
| `echo "export NAME=John" >> ~/.bashrc` | Make variable permanent |
| `source ~/.bashrc` | Reload bashrc without restarting terminal |
| `printenv HOME` | Print specific environment variable |

---

## Key Takeaways
- `tail -f /var/log/syslog` is your window into what the system is doing live
- Load average from `uptime`: 3 numbers = last 1, 5, 15 minutes. Above your CPU core count = overloaded
- `$PATH` is why commands work without full paths — Linux searches these folders
- `export` sets variable for current session only — use `~/.bashrc` for permanent
- `source ~/.bashrc` reloads config without logging out — use it after every bashrc edit
- `journalctl -p err` filters only errors — great for quick server health check
- `/var/log/auth.log` shows all login attempts — first place to check for intrusions

---

## Script Written Today

**`day14/system_report.sh`**
```bash
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
echo '============================================'
```

## Git Commit
```bash
git add .
git commit -m "Day 14: system monitoring + log analysis + env variables"
git push
```
