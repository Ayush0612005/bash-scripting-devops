#!/bin/bash
# ============================================================
# Script: disk_space_monitor.sh
# Description: Checks disk usage on all mounted partitions.
#              Alerts if any partition exceeds the threshold.
# Usage: bash disk_space_monitor.sh
# ============================================================

THRESHOLD=80

echo "========================================="
echo "     Disk Space Monitor"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5 " " $1 " mounted on " $6}' | while read -r output; do
    USAGE=$(echo "$output" | awk '{print $1}' | cut -d'%' -f1)
    PARTITION=$(echo "$output" | awk '{print $2}')
    MOUNT=$(echo "$output" | awk '{print $5}')

    echo "Partition : $PARTITION"
    echo "Mount     : $MOUNT"
    echo "Usage     : ${USAGE}%"

    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "[ALERT] Disk usage on $PARTITION is at ${USAGE}% — above threshold of ${THRESHOLD}%!"
    fi
    echo "-----------------------------------------"
done
