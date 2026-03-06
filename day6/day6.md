# Day 06 - Text Processing: grep, sed, awk

## Theory
- These three tools are the power trio of Linux text processing
- Every SRE/DevOps engineer uses them daily for log analysis, config changes, and data extraction
- Master these and you stand out

---

## grep — Search Tool

| Command | What it does |
|---------|-------------|
| `grep "error" app.log` | Find lines with "error" |
| `grep -i "error" app.log` | Case insensitive search |
| `grep -n "error" app.log` | Show line numbers |
| `grep -r "TODO" ./src/` | Search all files in folder |
| `grep -v "debug" app.log` | Show lines WITHOUT debug |
| `grep -c "error" app.log` | Count error lines |
| `grep -l "error" *.log` | List files that contain error |
| `grep -A 3 "error" app.log` | Show 3 lines AFTER each match |
| `grep -B 3 "error" app.log` | Show 3 lines BEFORE each match |
| `grep -E "err\|warn" app.log` | Search for error OR warning |

---

## sed — Edit Streams of Text

| Command | What it does |
|---------|-------------|
| `sed "s/old/new/" file` | Replace FIRST occurrence of old with new per line |
| `sed "s/old/new/g" file` | Replace ALL occurrences |
| `sed -i "s/old/new/g" file` | Edit file directly (in-place) |
| `sed "5d" file` | Delete line 5 |
| `sed "/pattern/d" file` | Delete all lines matching pattern |
| `sed -n "5,10p" file` | Print only lines 5 to 10 |
| `sed "s/^/>> /" file` | Add >> at start of every line |

---

## awk — Column-Based Data Processing

| Command | What it does |
|---------|-------------|
| `awk "{print $1}" file` | Print first column (word) of each line |
| `awk "{print $1, $3}" file` | Print columns 1 and 3 |
| `awk -F: "{print $1}" /etc/passwd` | Use : as separator, print first column |
| `awk "NR==5" file` | Print only line 5 |
| `awk "/error/" file` | Print lines containing error |
| `awk "{sum+=$1} END{print sum}"` | Sum up all numbers in column 1 |
| `awk "NF>3" file` | Print lines with more than 3 fields |

---

## Practice Log File
```bash
cat > day06/app.log << 'EOF'
2024-01-01 10:00:01 INFO  Server started successfully
2024-01-01 10:00:05 DEBUG Database connection established
2024-01-01 10:01:00 ERROR Failed to process request: timeout
2024-01-01 10:01:01 WARN  High memory usage detected: 85%
2024-01-01 10:02:00 INFO  Request processed: user_id=101
2024-01-01 10:02:05 ERROR Disk space critically low: 95% used
2024-01-01 10:03:00 DEBUG Cache cleared successfully
2024-01-01 10:04:00 ERROR Authentication failed for user admin
2024-01-01 10:05:00 INFO  Backup completed successfully
2024-01-01 10:06:00 WARN  CPU usage spike: 90% for 30 seconds
EOF
Script Written Today
day06/log_analyzer.sh
#!/bin/bash
# Log Analyzer Script - Day 06
LOG="day06/app.log"

echo "===== LOG ANALYSIS REPORT ====="
echo ""
echo "Total lines:  $(wc -l < $LOG)"
echo "ERROR count:  $(grep -c 'ERROR' $LOG)"
echo "WARN count:   $(grep -c 'WARN' $LOG)"
echo "INFO count:   $(grep -c 'INFO' $LOG)"
echo ""
echo "--- ERROR Details ---"
grep "ERROR" $LOG
echo ""
echo "--- Warnings ---"
grep "WARN" $LOG
Key Takeaways
grep = find lines, sed = edit lines, awk = process columns
grep -E lets you search for multiple patterns with |
sed -i edits the file directly — always backup first!
awk -F: sets a custom field separator — great for /etc/passwd
Combining these with pipes makes you extremely powerful on the command line
Git Commit
git add .
git commit -m "Day 6: grep sed awk text processing + log analyzer"
git push
