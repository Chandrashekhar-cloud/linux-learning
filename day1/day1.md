# Day 01 - Terminal Basics + Navigation

## Theory
- The Linux filesystem starts at `/` (root) — everything lives inside it
- Home directory is `/home/yourusername`, shortcut is `~`

## Commands Learned

### Navigation & Listing
| Command | What it does |
|---------|-------------|
| `pwd` | Print Working Directory — shows current location |
| `ls` | List files and folders |
| `ls -l` | Long listing: permissions, size, date |
| `ls -a` | Show hidden files (starting with `.`) |
| `ls -la` | Long listing + hidden files combined |
| `ls -lh` | Long listing with human-readable sizes (KB, MB) |
| `cd foldername` | Go into a folder |
| `cd ..` | Go one level up (parent folder) |
| `cd ~` | Go to home directory |
| `cd /` | Go to root directory |
| `cd -` | Go back to previous directory |

### System Info
| Command | What it does |
|---------|-------------|
| `whoami` | Shows current username |
| `uname -a` | Linux version and hostname |
| `date` | Current date and time |
| `uptime` | How long the system has been running |
| `echo "hello"` | Print text to terminal |

### Utilities
| Command | What it does |
|---------|-------------|
| `clear` | Clear the terminal screen (also Ctrl+L) |
| `history` | See all commands typed before |
| `man ls` | Read the manual for any command |

## Keyboard Shortcuts
| Shortcut | What it does |
|----------|-------------|
| `Tab` | Auto-complete — type first few letters then press Tab |
| `Ctrl + L` | Clear screen |
| `Ctrl + C` | Stop/kill any running process |
| `Up Arrow` | Cycle through previous commands |
| `Ctrl + R` | Search command history |
| `Ctrl + A` | Jump to beginning of line |
| `Ctrl + E` | Jump to end of line |
| `!!` | Repeat the last command |

## Key Takeaways
- `pwd` = print working directory — always know where you are
- `ls` = list files — always know what's around you
- `cd` = change directory — how you move around
- `..` means parent folder, `~` means home, `/` means root
- Tab completion saves ~80% of typing time — use it always

## Git Commit
```bash
git add .
git commit -m "Day 1: Linux navigation commands"
git push
```
