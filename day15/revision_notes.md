# Linux Placement Cheat Sheet 🐧
## The Only Commands You Need to Know

---

## 1. NAVIGATION (Always Asked)
```bash
pwd                  # where am I?
ls -la               # list everything with details
cd ~                 # go home
cd ..                # go up one level
cd -                 # go back to previous directory
find . -name "*.log" # find files by name
which python3        # where is this command?
```

---

## 2. FILES (Daily Use)
```bash
touch file.txt       # create file
mkdir -p a/b/c       # create nested folders
cp -r folder1 folder2  # copy folder
mv file1 file2       # rename or move
rm -rf foldername    # delete forever (careful!)
echo "text" > file   # overwrite file
echo "text" >> file  # append to file
cat file             # view file
```

---

## 3. VIEWING & SEARCHING (Most Used in Interviews)
```bash
cat file             # print small file
less file            # scroll big file (q=quit)
head -n 20 file      # first 20 lines
tail -n 20 file      # last 20 lines
tail -f file         # LIVE log watching ⭐

grep "error" file         # search in file
grep -i "error" file      # case insensitive
grep -n "error" file      # show line numbers
grep -r "error" .         # search all files
grep -v "error" file      # exclude lines
grep -c "error" file      # count matches
grep -E "error|warn" file # search multiple
```

---

## 4. PERMISSIONS (Interview Favourite ⭐)
```bash
ls -la               # see permissions
chmod 755 file       # rwxr-xr-x (scripts)
chmod 644 file       # rw-r--r-- (configs)
chmod 600 file       # rw------- (private keys!)
chmod +x file        # make executable
chown user:group f   # change owner and group
chmod -R 755 dir/    # recursive

# Numbers to memorise:
# 7 = rwx (read+write+execute)
# 6 = rw- (read+write)
# 5 = r-x (read+execute)
# 4 = r-- (read only)
# 0 = --- (no permission)
```

---

## 5. USERS & GROUPS (Asked in Every Interview)
```bash
whoami                       # current user
id                           # user ID + all groups
sudo useradd -m username     # create user
sudo passwd username         # set password
sudo userdel -r username     # delete user + home
sudo groupadd groupname      # create group
sudo usermod -aG group user  # add user to group ⭐
groups username              # see user's groups
su - username                # switch user
cat /etc/passwd              # all users
cat /etc/group               # all groups
```

---

## 6. TEXT PROCESSING (grep/sed/awk)
```bash
# sed - edit text
sed "s/old/new/g" file       # replace all
sed -i "s/old/new/g" file    # edit file directly
sed -n "5,10p" file          # print lines 5-10

# awk - column processing
awk "{print $1}" file        # print column 1
awk -F: "{print $1}" /etc/passwd  # custom separator
awk "/error/" file           # print matching lines
```

---

## 7. PROCESSES (Asked a Lot)
```bash
ps aux                    # all running processes
ps aux | grep nginx       # find specific process
top                       # live process monitor
kill PID                  # stop process
kill -9 PID               # force kill
pgrep nginx               # get PID by name
command &                 # run in background
jobs                      # list background jobs
```

---

## 8. SERVICES - systemctl (Critical ⭐)
```bash
systemctl status nginx    # is it running?
systemctl start nginx     # start service
systemctl stop nginx      # stop service
systemctl restart nginx   # restart service
systemctl enable nginx    # start on boot ⭐
systemctl disable nginx   # don't start on boot
journalctl -u nginx       # service logs
journalctl -f             # live logs
journalctl -p err         # errors only
```

---

## 9. NETWORKING (SRE/DevOps Must Know)
```bash
ip addr show              # show IP address
hostname -I               # quick IP
ping -c 4 google.com      # test connectivity
curl -I http://site.com   # check HTTP headers
curl -s URL | jq .        # pretty print JSON API
ss -tulnp                 # all open ports ⭐
lsof -i :80               # what's on port 80
dig google.com +short     # DNS lookup
nmap localhost            # scan open ports
```

---

## 10. DISK & MEMORY (Monitoring)
```bash
df -h                     # disk space all drives
df -h /                   # root partition space
du -sh foldername/        # folder size
du -sh * | sort -rh       # sort by size
free -h                   # RAM usage
uptime                    # load average
nproc                     # CPU core count
```

---

## 11. PACKAGE MANAGEMENT
```bash
sudo apt update           # refresh package list
sudo apt install -y pkg   # install package
sudo apt remove pkg       # remove package
dpkg -l | grep nginx      # check if installed
which program             # find where installed
program --version         # check version
```

---

## 12. CRON JOBS (Automation)
```bash
crontab -e                # edit cron jobs
crontab -l                # list cron jobs
crontab -r                # delete ALL (careful!)

# Format: min hour day month weekday command
*/5 * * * *   command     # every 5 minutes
0 2 * * *     command     # every day 2AM
0 9 * * 1     command     # every Monday 9AM
@reboot       command     # on system start
```

---

## 13. SSH & SCP (Remote Servers)
```bash
ssh user@server                  # connect to server
ssh -p 2222 user@server          # custom port
ssh-keygen -t rsa -b 4096        # generate keys
ssh-copy-id user@server          # passwordless login
scp file user@server:/path       # copy TO server
scp user@server:/file /local     # copy FROM server
cat ~/.ssh/id_rsa.pub            # your public key
```

---

## 14. SHELL SCRIPTING BASICS
```bash
#!/bin/bash              # always first line
NAME='John'              # variable (no spaces!)
echo $NAME               # use variable
TODAY=$(date)            # command in variable
read -p 'Enter: ' VAR   # user input

# If/else
if [ $NUM -gt 5 ]; then
    echo 'greater'
else
    echo 'smaller'
fi

# For loop
for i in {1..5}; do
    echo $i
done

# Function
greet() {
    local name=$1
    echo "Hello $name"
}
greet 'DevOps'

set -e    # exit on error
set -u    # error on undefined variable
```

---

## 15. ENVIRONMENT VARIABLES
```bash
env                              # all variables
echo $PATH                       # command search path
echo $HOME                       # home directory
export MY_VAR=value              # set for session
echo "export MY_VAR=val" >> ~/.bashrc  # permanent
source ~/.bashrc                 # reload config
```

---

## ⭐ TOP 20 COMMANDS FOR PLACEMENT

| # | Command | Why Important |
|---|---------|--------------|
| 1 | `tail -f logfile` | Watch live logs on servers |
| 2 | `grep -r "error" .` | Search across all files |
| 3 | `chmod 600 keyfile` | Secure private keys |
| 4 | `systemctl enable svc` | Auto-start on boot |
| 5 | `ss -tulnp` | Check open ports |
| 6 | `ps aux | grep svc` | Find running process |
| 7 | `kill -9 PID` | Force stop process |
| 8 | `sed -i "s/old/new/g"` | Edit config files |
| 9 | `awk -F: "{print $1}"` | Parse structured files |
| 10 | `usermod -aG group user` | Add user to group |
| 11 | `df -h` | Check disk space |
| 12 | `free -h` | Check RAM |
| 13 | `crontab -e` | Schedule automation |
| 14 | `ssh-keygen -t rsa` | Generate SSH keys |
| 15 | `scp file user@server` | Copy to remote server |
| 16 | `find / -size +100M` | Find large files |
| 17 | `journalctl -p err` | Check system errors |
| 18 | `sudo usermod -aG sudo` | Give admin access |
| 19 | `curl -s URL | jq .` | Test APIs |
| 20 | `set -e` in scripts | Safe bash scripting |

---

## ⭐ INTERVIEW QUESTIONS & ANSWERS

**Q: What is chmod 755?**
A: Owner=rwx, Group=r-x, Others=r-x. Used for scripts and folders.

**Q: Difference between kill and kill -9?**
A: `kill` sends SIGTERM (graceful shutdown). `kill -9` sends SIGKILL (force, no cleanup).

**Q: What does tail -f do?**
A: Watches a file live and shows new lines as they are added. Used for monitoring logs.

**Q: Difference between > and >>?**
A: `>` overwrites the file. `>>` appends to the file.

**Q: What is systemctl enable?**
A: Makes a service start automatically every time the system boots.

**Q: What is SSH key-based authentication?**
A: Instead of password, you use a key pair. Public key goes on server, private key stays with you.

**Q: What does set -e do in a script?**
A: Exits the script immediately if any command fails. Makes scripts safer.

**Q: What is crontab?**
A: A scheduler that runs commands automatically at specified times.

**Q: Difference between rm -r and rm -rf?**
A: `-r` deletes recursively but asks. `-rf` force deletes with no questions asked.

**Q: What is /etc/passwd?**
A: File containing all user accounts on the system. Format: username:x:UID:GID:info:home:shell


