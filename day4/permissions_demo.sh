#!/bin/bash
# Permissions Demo Script
echo '=== Creating test files ==='
touch public.txt private.txt executable.sh
echo '=== Setting permissions ==='
chmod 644 public.txt
chmod 600 private.txt
chmod 755 executable.sh
echo '=== Result ==='
ls -la public.txt private.txt executable.sh
echo '=== Stat of private file ==='
stat private.txt
