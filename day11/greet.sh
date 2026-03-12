#!/bin/bash
read -p 'Enter your name:' NAME
read -p 'Enter your role:' ROLE

TODAY=$(date +%A)
echo ''
echo "Hello $NAME! welcome to Devops."
echo "Role: $ROLE"
echo "Today is $TODAY"
echo "Script: $0"
