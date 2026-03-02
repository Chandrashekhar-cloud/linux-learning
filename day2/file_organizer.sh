#!/bin/bash
# File Organizer Script - Day 02
# Creates an organised folder structure
echo 'Creating project structure...'
mkdir -p myproject/src
mkdir -p myproject/logs
mkdir -p myproject/config
mkdir -p myproject/scripts
mkdir -p myproject/backup
touch myproject/src/app.py
touch myproject/config/settings.conf
touch myproject/logs/app.log
echo '# Main application' > myproject/src/app.py
echo 'APP_NAME=myapp' > myproject/config/settings.conf
echo 'Done! Structure created:'
