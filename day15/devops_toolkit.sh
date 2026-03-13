#!/bin/bash
# ============================================
# DEVOPS TOOLKIT - Linux Final Project
# Combines: Navigation, Files, Permissions,
# Users, grep/sed/awk, Processes, Networking,
# Monitoring, Logs, Shell Scripting
# ============================================
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
# ---- FUNCTIONS ---
print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}============================================${NC}"
}
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}[OK]${NC} $1"
    else
        echo -e "  ${RED}[FAIL]${NC} $1"
    fi
}
system_info() {
    print_header 'SYSTEM INFORMATION'
    echo "  Hostname : $(hostname)"
    echo "  User     : $(whoami)"
    echo "  Date     : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "  Uptime   : $(uptime -p)"
    echo "  CPU Cores: $(nproc)"
    echo "  OS       : $(cat /etc/os-release | grep PRETTY | cut -d= -f2 | tr -d '"')"
}
resource_check() {
    print_header 'RESOURCE USAGE'
    echo '  MEMORY:'
    free -h | awk '/Mem:/ {printf "    Used: %s / Total: %s\n", $3, $2}'
    echo '  DISK:'
    df -h | awk 'NR>1 {printf "    %s used on %s\n", $5, $6}'
    echo '  TOP PROCESSES:'
    ps aux --sort=-%cpu | awk 'NR>1 && NR<4 {printf "    %s%% CPU: %s\n", $3, $11}'
}
network_check() {
    print_header 'NETWORK STATUS'
    echo "  IP Address: $(hostname -I | awk '{print $1}')"
    echo '  Connectivity:'
    for host in google.com 8.8.8.8; do
        if ping -c 1 -W 2 $host > /dev/null 2>&1; then
            echo -e "    ${GREEN}[OK]${NC} $host reachable"
        else
            echo -e "    ${RED}[FAIL]${NC} $host unreachable"
        fi
    done
    echo '  Listening Ports:'
    ss -tuln | grep LISTEN | awk '{print "    Port: "$5}'
}
service_check() {
    print_header 'SERVICE STATUS'
    for service in nginx ssh cron; do
        if systemctl is-active --quiet $service 2>/dev/null; then
            echo -e "  ${GREEN}[RUNNING]${NC} $service"
        else
            echo -e "  ${YELLOW}[STOPPED]${NC} $service"
        fi
    done
}
log_analysis() {
    print_header 'LOG ANALYSIS'
    if [ -f /var/log/syslog ]; then
        echo "  Syslog errors (last hour):"
        sudo grep -i 'error' /var/log/syslog 2>/dev/null | \
             awk -v d="$(date -d '1 hour ago' '+%b %d %H')" '$0 > d' | \
             wc -l | xargs -I{} echo "    {} errors found"
    fi
    echo "  Disk warning check:"
    df -h | awk 'NR>1 {gsub(/%/,"",$5); if($5+0>70) \
        printf "    WARNING: %s is %s%% full!\n", $6, $5}'
}
# ---- MAIN MENU ---
while true; do
    echo ''
    echo -e "${YELLOW}=== DEVOPS TOOLKIT MENU ===${NC}"
    echo '  1. System Information'
    echo '  2. Resource Usage'
    echo '  3. Network Status'
    echo '  4. Service Status'
    echo '  5. Log Analysis'
    echo '  6. Run All Checks'
    echo '  7. Exit'
    echo ''
    read -p 'Choose option (1-7): ' CHOICE
    echo ''
    case $CHOICE in
        1) system_info ;;
        2) resource_check ;;
        3) network_check ;;
        4) service_check ;;
        5) log_analysis ;;
        6) system_info; echo; resource_check; echo; network_check; echo; service_check; echo; log_
analysis ;;
        7) echo 'Goodbye!'; exit 0 ;;
        *) echo 'Invalid option' ;;
    esac
done

