#!/bin/bash
# ============================================================
# Script: log_cleanup.sh
# Description: Deletes log files older than N days from a
#              specified directory to free up disk space.
# Usage: bash log_cleanup.sh /path/to/logs 7
# ============================================================

LOG_DIR="${1:-/var/log/myapp}"
DAYS="${2:-7}"

echo "========================================="
echo "     Log Cleanup Script"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="
echo "Directory : $LOG_DIR"
echo "Deleting logs older than $DAYS days..."
echo "-----------------------------------------"

if [ ! -d "$LOG_DIR" ]; then
    echo "[ERROR] Directory '$LOG_DIR' does not exist. Exiting."
    exit 1
fi

DELETED=0
while IFS= read -r -d '' file; do
    echo "Deleting: $file"
    rm -f "$file"
    ((DELETED++))
done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +"$DAYS" -print0)

echo "-----------------------------------------"
echo "Done. Total files deleted: $DELETED"
echo "========================================="
