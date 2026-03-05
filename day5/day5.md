# Day 05 - Users & Groups Management

## Theory
- Linux is a multi-user system — on a real server you have multiple users and groups
- As a DevOps engineer you create users for apps, add them to groups, and control access
- This is server security
- ⚠️ In real DevOps: you create a dedicated user for each application
  (nginx user, postgres user) — apps should NEVER run as root

## Commands Learned

### Viewing Users & Sessions
| Command | What it does |
|---------|-------------|
| `whoami` | Show current user |
| `id` | Show user ID, group ID, and all groups you belong to |
| `who` | Show all users currently logged in |
| `w` | Show logged-in users + what they are doing |
| `last` | Show login history |

### Managing Users
| Command | What it does |
|---------|-------------|
| `sudo useradd testuser` | Create new user named testuser |
| `sudo useradd -m testuser` | Create user WITH home directory |
| `sudo passwd testuser` | Set password for testuser |
| `sudo userdel testuser` | Delete user |
| `sudo userdel -r testuser` | Delete user + their home directory |

### Managing Groups
| Command | What it does |
|---------|-------------|
| `sudo groupadd devteam` | Create new group named devteam |
| `sudo groupdel devteam` | Delete group |
| `groups yourusername` | Show all groups a user belongs to |
| `sudo usermod -aG sudo u` | Add user u to sudo group (gives admin access) |
| `sudo usermod -aG grp u` | Add user u to group grp |

### Important Files
| Command | What it does |
|---------|-------------|
| `cat /etc/passwd` | File containing all users on system |
| `cat /etc/group` | File containing all groups on system |

### Switching Users
| Command | What it does |
|---------|-------------|
| `su - testuser` | Switch to testuser (needs their password) |
| `sudo su` | Switch to root user |
| `sudo command` | Run command as root/admin |
| `exit` | Go back to your main user |

## Key Takeaways
- `id` is the quickest way to see who you are and what groups you're in
- `-aG` in usermod means "append to Group" — without `-a` it REPLACES all groups (dangerous!)
- `userdel -r` removes the home folder too — use carefully
- `/etc/passwd` stores all users, `/etc/group` stores all groups
- In production, never run applications as root — always create a dedicated user

## Git Commit
```bash
git add .
git commit -m "Day 5: Linux users and groups management"
git push
```
