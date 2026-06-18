#!/bin/bash
# ============================================================
# Script: list_users.sh
# Description: Lists all non-system users on the machine
#              along with their home directory and shell.
# Usage: bash list_users.sh
# ============================================================

echo "========================================="
echo "     User Listing Script"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="
printf "%-20s %-30s %-20s\n" "USERNAME" "HOME DIRECTORY" "SHELL"
echo "---------------------------------------------------------"

while IFS=: read -r username _ uid _ _ home shell; do
    if [ "$uid" -ge 1000 ] && [ "$uid" -ne 65534 ]; then
        printf "%-20s %-30s %-20s\n" "$username" "$home" "$shell"
    fi
done < /etc/passwd

echo "========================================="
