#!/bin/bash
# ============================================================
# Script: create_user.sh
# Description: Creates a new Linux user with a home directory,
#              assigns them to a group, and sets a password.
# Usage: sudo bash create_user.sh <username> <group>
# ============================================================

USERNAME="$1"
GROUP="${2:-developers}"

if [ -z "$USERNAME" ]; then
    echo "[ERROR] No username provided."
    echo "Usage: sudo bash create_user.sh <username> [group]"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] Please run as root (use sudo)."
    exit 1
fi

echo "========================================="
echo "     User Creation Script"
echo "  Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="

# Create group if it doesn't exist
if ! getent group "$GROUP" > /dev/null 2>&1; then
    groupadd "$GROUP"
    echo "[INFO] Group '$GROUP' created."
fi

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo "[ERROR] User '$USERNAME' already exists."
    exit 1
fi

# Create user
useradd -m -g "$GROUP" -s /bin/bash "$USERNAME"
echo "[SUCCESS] User '$USERNAME' created and added to group '$GROUP'."

# Set password
echo "Set a password for $USERNAME:"
passwd "$USERNAME"

echo "========================================="
