# Day 07 - Revision: Days 1-6

## What I Revised Today

---

## Day 1 — Terminal Basics + Navigation
```bash
pwd          # where am I?
ls -la       # list all files with details
cd ~         # go home
cd ..        # go up one level
cd -         # go back to previous directory
history      # see all past commands
Tab          # autocomplete — use it always!
Day 2 — File & Directory Management
touch file.txt        # create empty file
mkdir -p a/b/c        # create nested folders
cp file1 file2        # copy file
mv file1 file2        # rename or move
rm -rf foldername     # delete folder (NO undo!)
echo "text" > file    # overwrite file
echo "text" >> file   # append to file
cat file              # view file
Day 3 — Viewing Files + Finding Files
cat file          # print file
less file         # scroll through file (q to quit)
head -n 20 file   # first 20 lines
tail -n 20 file   # last 20 lines
tail -f file      # LIVE log watching
grep "word" file  # search in file
grep -r "word" .  # search all files recursively
find . -name "*.sh"        # find by name
find . -type f -size +1M   # find files over 1MB
which command     # where is this command installed?
Day 4 — File Permissions + Ownership
ls -la              # see permissions
chmod 755 file      # rwxr-xr-x
chmod 644 file      # rw-r--r--
chmod 600 file      # rw------- (private!)
chmod +x file       # add execute permission
chown user file     # change owner
chown user:group f  # change owner and group
chmod -R 755 dir/   # recursive permission change
stat file           # full permission details
Permission Numbers Cheatsheet
Value
Who can do what
755
Owner: all — Group/Others: read+execute
644
Owner: read+write — Group/Others: read only
600
Owner: read+write — Group/Others: nothing
777
Everyone everything — NEVER in production!
Day 5 — Users & Groups Management
whoami                        # current user
id                            # user ID + groups
sudo useradd -m username      # create user with home
sudo passwd username          # set password
sudo userdel -r username      # delete user + home
sudo groupadd groupname       # create group
sudo usermod -aG group user   # add user to group
groups username               # see user's groups
su - username                 # switch user
cat /etc/passwd               # all users on system
cat /etc/group                # all groups on system
Day 6 — Text Processing: grep, sed, awk
# grep
grep -i "error" app.log       # case insensitive
grep -n "error" app.log       # show line numbers
grep -c "error" app.log       # count matches
grep -v "debug" app.log       # exclude lines
grep -E "error|warn" app.log  # search multiple patterns
grep -A 3 "error" app.log     # 3 lines after match

# sed
sed "s/old/new/g" file        # replace all
sed -i "s/old/new/g" file     # edit file in place
sed "5d" file                 # delete line 5
sed -n "5,10p" file           # print lines 5-10

# awk
awk "{print $1}" file              # print column 1
awk -F: "{print $1}" /etc/passwd   # custom separator
awk "/error/" file                 # print matching lines
awk "{sum+=$1} END{print sum}"     # sum a column
Most Important Commands to Remember
Command
Why it matters
tail -f
Watch live logs on servers
grep -r
Search across all config files
chmod 600
Secure private keys and secrets
sed -i
Edit config files in scripts
awk -F:
Parse structured files like /etc/passwd
find . -name
Locate files anywhere on system
usermod -aG
Add users to groups safely
Key DevOps Reminders
⚠️ rm -rf has no undo — always double check
⚠️ sed -i edits in place — backup first
⚠️ Never run apps as root — always use dedicated users
⚠️ 777 permissions = security risk — never in production
