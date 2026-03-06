#!/bin/bash
# Log Analyzer Script
LOG='app.log'
echo '===== LOG ANALYSIS REPORT ====='
echo ''
echo 'Total lines:' $(wc -l < $LOG)
echo 'ERROR count:' $(grep -c 'ERROR' $LOG)
echo 'WARN count: ' $(grep -c 'WARN' $LOG)
echo 'INFO count: ' $(grep -c 'INFO' $LOG)
echo ''
echo '--- ERROR Details ---'
grep 'ERROR' $LOG
echo ''
echo '--- Warnings ---'
grep 'WARN' $LOG
