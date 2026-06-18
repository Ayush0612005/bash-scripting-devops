#!/bin/bash
# ============================================================
# Script: backup_files.sh
# Description: Creates a timestamped compressed backup (.tar.gz)
#              of a specified source directory.
# Usage: bash backup_files.sh /source/dir /backup/destination
# ============================================================

SOURCE="${1:-/home/$USER/projects}"
DEST="${2:-/home/$USER/backups}"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

echo "========================================="
echo "     File Backup Script"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="
echo "Source      : $SOURCE"
echo "Destination : $DEST"
echo "Backup file : $BACKUP_NAME"
echo "-----------------------------------------"

if [ ! -d "$SOURCE" ]; then
    echo "[ERROR] Source directory '$SOURCE' not found. Exiting."
    exit 1
fi

mkdir -p "$DEST"

tar -czf "$DEST/$BACKUP_NAME" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Backup created at: $DEST/$BACKUP_NAME"
else
    echo "[ERROR] Backup failed!"
    exit 1
fi

echo "========================================="
