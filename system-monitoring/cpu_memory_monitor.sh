#!/bin/bash
# ============================================================
# Script: cpu_memory_monitor.sh
# Description: Monitors CPU and memory usage. Alerts if usage
#              exceeds defined thresholds.
# Usage: bash cpu_memory_monitor.sh
# ============================================================

CPU_THRESHOLD=80
MEM_THRESHOLD=80

echo "========================================="
echo "     System Resource Monitor"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="

# --- CPU Usage ---
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
echo "CPU Usage   : ${CPU_USAGE}%"
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "[ALERT] CPU usage is above ${CPU_THRESHOLD}%!"
fi

# --- Memory Usage ---
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_PERCENT=$(( (MEM_USED * 100) / MEM_TOTAL ))
echo "Memory Usage: ${MEM_PERCENT}% (${MEM_USED}MB / ${MEM_TOTAL}MB)"
if [ "$MEM_PERCENT" -gt "$MEM_THRESHOLD" ]; then
    echo "[ALERT] Memory usage is above ${MEM_THRESHOLD}%!"
fi

echo "========================================="
