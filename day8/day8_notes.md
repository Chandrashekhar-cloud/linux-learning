# Day 08 - Process Management + systemd

## Theory
- On a server, many programs run simultaneously — web server, database, monitoring agent
- As a DevOps engineer you start, stop, restart, and monitor these
- systemd is how Linux manages services — asked in every interview!

## Commands Learned

### Viewing Processes
| Command | What it does |
|---------|-------------|
| `ps` | Show your current processes |
| `ps aux` | Show ALL processes from ALL users with details |
| `ps aux | grep nginx` | Find if nginx is running |
| `top` | Live process monitor — press q to quit |
| `top -u yourusername` | Show only your processes in top |
| `pgrep nginx` | Get PID of process by name |

### Killing Processes
| Command | What it does |
|---------|-------------|
| `kill PID` | Stop process with that process ID |
| `kill -9 PID` | Force kill — use when normal kill fails |
| `killall processname` | Kill all processes with that name |

### Background Jobs
| Command | What it does |
|---------|-------------|
| `command &` | Run command in background |
| `jobs` | List background jobs |
| `fg %1` | Bring background job 1 to foreground |
| `nohup command &` | Run command that keeps going after you logout |

### systemctl — Managing Services
| Command | What it does |
|---------|-------------|
| `systemctl status nginx` | Check if nginx service is running |
| `systemctl start nginx` | Start nginx service |
| `systemctl stop nginx` | Stop nginx service |
| `systemctl restart nginx` | Restart nginx |
| `systemctl enable nginx` | Make nginx start automatically on boot |
| `systemctl disable nginx` | Stop nginx from starting on boot |
| `systemctl list-units` | List all services and their status |

### journalctl — Viewing Logs
| Command | What it does |
|---------|-------------|
| `journalctl -u nginx` | See logs for nginx service |
| `journalctl -f` | Live system log feed |
| `journalctl --since "1h ago"` | Logs from last 1 hour |

## Key Takeaways
- `ps aux` = snapshot of all running processes
- `top` = live view — press P to sort by CPU, M to sort by memory
- `kill -9` is the nuclear option — try normal `kill` first
- `systemctl enable` = survives reboot, `systemctl start` = just right now
- `journalctl -f` = live logs, just like `tail -f` but for services
- `nohup command &` = keeps running even after you log out of server

## Script Written Today

**`day08/process_monitor.sh`**
```bash
#!/bin/bash
# Process Monitor Script

echo "=== SYSTEM PROCESS REPORT ==="
echo "Date: $(date)"
echo ""

echo "--- Top 5 CPU Consuming Processes ---"
ps aux --sort=-%cpu | head -6
echo ""

echo "--- Top 5 Memory Consuming Processes ---"
ps aux --sort=-%mem | head -6
echo ""

echo "--- Service Status Check ---"
for service in nginx ssh cron; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        echo "$service: RUNNING"
    else
        echo "$service: STOPPED"
    fi
done
Git Commit
git add .
git commit -m "Day 8: process management + systemctl + journalctl"
git push
