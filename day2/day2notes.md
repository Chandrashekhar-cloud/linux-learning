# Day 02 - File & Directory Management

## Theory
- Every DevOps task involves files — config files, log files, scripts, keys
- These commands are used every single day on real servers
- ⚠️ `rm` deletes permanently — there is NO recycle bin. Be careful with `rm -rf`

## Commands Learned

### Creating Files & Folders
| Command | What it does |
|---------|-------------|
| `touch filename.txt` | Create an empty file |
| `mkdir foldername` | Create a new folder |
| `mkdir -p a/b/c` | Create nested folders in one command |

### Copying & Moving
| Command | What it does |
|---------|-------------|
| `cp file1 file2` | Copy file1 and name the copy file2 |
| `cp -r folder1 folder2` | Copy entire folder recursively |
| `mv file1 file2` | Rename file1 to file2 |
| `mv file /path/to/folder/` | Move file to a different folder |

### Deleting
| Command | What it does |
|---------|-------------|
| `rm filename` | Delete a file permanently |
| `rm -r foldername` | Delete a folder and everything inside |
| `rm -rf foldername` | Force delete without asking (CAREFUL!) |
| `rmdir foldername` | Delete only EMPTY folders |

### Viewing & Editing Files
| Command | What it does |
|---------|-------------|
| `cat filename` | Print file content to terminal |
| `nano filename` | Open file in nano text editor |
| `echo "text" > file` | Create file with text (overwrites existing) |
| `echo "text" >> file` | Add text to end of file (append) |
| `wc -l filename` | Count how many lines in a file |
| `wc -w filename` | Count words in a file |
| `file filename` | Show what type of file it is |
| `stat filename` | Show detailed file info (size, dates, permissions) |

## Key Takeaways
- `>` overwrites a file — `>>` appends to a file
- `mkdir -p` is your friend for creating deep folder structures in one shot
- Always double-check before running `rm -rf` — there is no undo
- `stat` and `file` are useful for quickly inspecting unknown files

## Script Written Today

**`day02/file_organizer.sh`**
```bash
#!/bin/bash
# File Organizer Script - Day 02
# Creates an organised folder structure

echo "Creating project structure..."

mkdir -p myproject/src
mkdir -p myproject/logs
mkdir -p myproject/config
mkdir -p myproject/scripts
mkdir -p myproject/backup

touch myproject/src/app.py
touch myproject/config/settings.conf
touch myproject/logs/app.log
echo "# Main application" > myproject/src/app.py
echo "APP_NAME=myapp" > myproject/config/settings.conf

echo "Done! Structure created."
ls -la myproject/

# Run it:
# chmod +x day02/file_organizer.sh
# ./day02/file_organizer.sh
```


