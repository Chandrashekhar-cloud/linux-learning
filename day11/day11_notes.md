# Day 11 - Shell Scripting Part 1

## Theory
- Shell scripting is the skill that makes you a DevOps engineer instead of just a Linux user
- Everything you do manually — checking services, cleaning logs, backing up files — can be automated
- This is what companies hire you to do

## Fundamentals Learned Today

### 1. Script Structure
```bash
#!/bin/bash          # Must be the FIRST line always
# This is a comment  # Comments start with #

echo 'Hello World'   # Your code goes here

# How to run:
chmod +x myscript.sh  # Make executable (only once)
./myscript.sh         # Run it
```

### 2. Variables
```bash
NAME='John'           # Assign (no spaces around =)
AGE=25
echo $NAME            # Use with $ prefix
echo "My name is $NAME"  # Use inside double quotes

# Command output in variable
TODAY=$(date)
FILES=$(ls | wc -l)
echo "Today: $TODAY"
echo "Files: $FILES"

# Special variables
echo $0   # Script name
echo $1   # First argument passed to script
echo $2   # Second argument
echo $#   # Total number of arguments
echo $?   # Exit code of last command (0=success, non-0=error)
```

### 3. User Input
```bash
echo 'Enter your name:'
read NAME
echo "Hello $NAME!"

# Read with prompt on same line
read -p 'Enter age: ' AGE
echo "You are $AGE years old"
```

### 4. If-Else Conditions
```bash
NUM=10

if [ $NUM -gt 5 ]; then
    echo 'Greater than 5'
elif [ $NUM -eq 5 ]; then
    echo 'Equal to 5'
else
    echo 'Less than 5'
fi

# Comparison operators:
# -eq  equal to         -ne  not equal
# -gt  greater than     -lt  less than
# -ge  greater or equal -le  less or equal

# String comparison
NAME='admin'
if [ "$NAME" == 'admin' ]; then echo 'Admin!'; fi

# File checks
if [ -f '/etc/nginx/nginx.conf' ]; then echo 'nginx installed'; fi
if [ -d '/home/john' ]; then echo 'john has home dir'; fi
if [ -z "$VAR" ]; then echo 'variable is empty'; fi
```

## Scripts Written Today

### Script 1: `day11/greet.sh` — Variables + Input
```bash
#!/bin/bash
read -p 'Enter your name: ' NAME
read -p 'Enter your role: ' ROLE
TODAY=$(date +%A)
echo ''
echo "Hello $NAME! Welcome to DevOps."
echo "Role: $ROLE"
echo "Today is: $TODAY"
echo "Script: $0"
```

### Script 2: `day11/check_number.sh` — If/Else
```bash
#!/bin/bash
read -p 'Enter a number: ' NUM

if [ $NUM -gt 100 ]; then
    echo 'Large number (>100)'
elif [ $NUM -gt 50 ]; then
    echo 'Medium number (51-100)'
elif [ $NUM -gt 0 ]; then
    echo 'Small number (1-50)'
elif [ $NUM -eq 0 ]; then
    echo 'Zero'
else
    echo 'Negative number'
fi
```

### Script 3: `day11/file_checker.sh` — File Checks
```bash
#!/bin/bash
read -p 'Enter file or folder path: ' PATH_INPUT

if [ -f "$PATH_INPUT" ]; then
    echo 'It is a FILE'
    echo "Size: $(stat -c%s "$PATH_INPUT") bytes"
    echo "Lines: $(wc -l < "$PATH_INPUT")"
elif [ -d "$PATH_INPUT" ]; then
    echo 'It is a DIRECTORY'
    echo 'Contents:'
    ls -la "$PATH_INPUT"
else
    echo 'Path does not exist!'
fi
```

## Key Takeaways
- `#!/bin/bash` must always be the first line
- No spaces around `=` when assigning variables: `NAME='John'` ✅ `NAME = 'John'` ❌
- Always quote variables in conditions: `"$VAR"` not `$VAR`
- `$?` after a command tells you if it succeeded (0) or failed (non-0)
- `-f` checks for file, `-d` checks for directory, `-z` checks if empty

## Git Commit
```bash
git add .
git commit -m "Day 11: shell scripting part 1 - variables, input, if-else"
git push
```
