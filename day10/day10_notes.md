# Day 10 - Networking Commands

## Theory
- Network debugging is a core SRE skill
- "Why can't users reach our server?" — you need networking commands to answer this
- Today: checking your IP → scanning ports → making API calls

## Commands Learned

### IP & Hostname
| Command | What it does |
|---------|-------------|
| `ip addr show` | Show all network interfaces and IP addresses |
| `ip addr show eth0` | Show specific interface |
| `hostname` | Show your computer's hostname |
| `hostname -I` | Show your IP address only |

### Connectivity Testing
| Command | What it does |
|---------|-------------|
| `ping google.com` | Test if you can reach google.com |
| `ping -c 4 google.com` | Ping exactly 4 times then stop |
| `ping -c 4 8.8.8.8` | Ping Google DNS |
| `traceroute google.com` | Show path packets take to reach destination |

### DNS Lookup
| Command | What it does |
|---------|-------------|
| `nslookup google.com` | Find IP address for a domain name |
| `dig google.com` | Detailed DNS lookup |
| `dig google.com +short` | Quick IP lookup only |

### HTTP & API Calls
| Command | What it does |
|---------|-------------|
| `curl http://example.com` | Download webpage content |
| `curl -I http://example.com` | Show only HTTP response headers |
| `curl -s URL | jq .` | Download JSON API and pretty print |
| `wget http://example.com` | Download file from URL |

### Port & Process Checking
| Command | What it does |
|---------|-------------|
| `ss -tuln` | Show all open/listening ports |
| `ss -tulnp` | Show ports with process names |
| `ss -tuln | grep :80` | Check if port 80 is open |
| `lsof -i :80` | See what process is using port 80 |
| `netstat -tuln` | Show listening ports (older command) |

### Scanning
| Command | What it does |
|---------|-------------|
| `nmap localhost` | Scan open ports on your own machine |
| `nmap -p 80 google.com` | Check if port 80 is open on google.com |

### Config Files
| Command | What it does |
|---------|-------------|
| `cat /etc/hosts` | Local hostname to IP mappings |
| `cat /etc/resolv.conf` | DNS server configuration |

## Key Takeaways
- `ping -c 4` stops automatically — always use `-c` in scripts
- `curl -I` is great for checking if a server is up and what status code it returns
- `ss -tulnp` is the modern replacement for `netstat`
- `lsof -i :80` tells you exactly which process owns a port
- `dig +short` is the quickest way to resolve a domain to IP
- `curl -s URL | jq .` is how you interact with REST APIs from terminal

## Script Written Today

**`day10/network_checker.sh`**
```bash
#!/bin/bash
# Network Health Checker

echo "===== NETWORK HEALTH CHECK ====="
echo "Date: $(date)"
echo ""

echo "--- My IP Address ---"
hostname -I
echo ""

echo "--- DNS Resolution Check ---"
for domain in google.com github.com stackoverflow.com; do
    IP=$(dig $domain +short | head -1)
    echo "$domain -> $IP"
done
echo ""

echo "--- Connectivity Check ---"
for host in google.com 8.8.8.8 1.1.1.1; do
    if ping -c 1 -W 2 $host > /dev/null 2>&1; then
        echo "$host: REACHABLE"
    else
        echo "$host: UNREACHABLE"
    fi
done
echo ""
```

## Git Commit
```bash
git add .
git commit -m "Day 10: networking commands + network health checker"
git push
```
