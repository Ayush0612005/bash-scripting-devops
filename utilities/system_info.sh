#!/bin/bash
# ============================================================
# Script: system_info.sh
# Description: Prints a complete system summary — OS, kernel,
#              CPU, RAM, disk, uptime, and network info.
# Usage: bash system_info.sh
# ============================================================

echo "========================================="
echo "         System Information"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="

echo "Hostname     : $(hostname)"
echo "OS           : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo "Kernel       : $(uname -r)"
echo "Architecture : $(uname -m)"
echo "-----------------------------------------"
echo "CPU Model    : $(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
echo "CPU Cores    : $(nproc)"
echo "-----------------------------------------"
echo "Total RAM    : $(free -h | awk '/Mem:/ {print $2}')"
echo "Used RAM     : $(free -h | awk '/Mem:/ {print $3}')"
echo "Free RAM     : $(free -h | awk '/Mem:/ {print $4}')"
echo "-----------------------------------------"
echo "Disk Usage   :"
df -h --output=source,size,used,avail,pcent | grep -vE '^tmpfs|^udev|^Filesystem'
echo "-----------------------------------------"
echo "Uptime       : $(uptime -p)"
echo "-----------------------------------------"
echo "IP Address   : $(hostname -I | awk '{print $1}')"
echo "========================================="
