#!/bin/bash
# DevOps Tools Setup Script
# Run this on any fresh Ubuntu/Debian server
echo 'Updating package list...'
sudo apt update -qq
TOOLS='curl wget git vim htop tree net-tools nmap python3 python3-pip jq'
echo 'Installing tools...'
sudo apt install -y $TOOLS
echo ''
echo '=== Installation Verification ==='
for tool in curl wget git vim htop tree nmap python3 jq; do
    if which $tool > /dev/null 2>&1; then
        echo "$tool: INSTALLED ($(which $tool))"
    else
echo "$tool: NOT FOUND"
fi
done

