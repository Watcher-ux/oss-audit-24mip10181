#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Displays a welcome screen with key system info
# ============================================================

# --- Student & Software Variables ---
STUDENT_NAME="Ansh Choubey"          # Replace with your name
ROLL_NUMBER="24MIP10181"    # Replace with your roll number
SOFTWARE_CHOICE="Python"            # Our chosen OSS project

# --- Gather System Information using command substitution $() ---
KERNEL=$(uname -r)                              # Linux kernel version
DISTRO=$(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                             # Current logged-in user
HOME_DIR=$HOME                                  # Home directory of current user
UPTIME=$(uptime -p)                             # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')           # e.g. Monday, 01 January 2025
CURRENT_TIME=$(date '+%H:%M:%S')               # e.g. 14:30:00
HOSTNAME=$(hostname)                            # Machine hostname

# --- Python-specific: check if python3 is installed and get version ---
if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1)   # Get Python version string
else
    PYTHON_VERSION="Python3 not found"
fi

# --- OS License Detection ---
# Linux distributions are typically GPL v2 licensed at the kernel level
OS_LICENSE="GPL v2 (Linux Kernel) + Distribution-specific licenses"

# --- Display the Welcome Screen ---
echo "================================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT             "
echo "================================================================"
echo ""
echo "  Student    : $STUDENT_NAME ($ROLL_NUMBER)"
echo "  Project    : Auditing [ $SOFTWARE_CHOICE ]"
echo "================================================================"
echo ""
echo "  SYSTEM INFORMATION"
echo "  ------------------"
echo "  Hostname         : $HOSTNAME"
echo "  Distribution     : $DISTRO"
echo "  Kernel Version   : $KERNEL"
echo "  Logged-in User   : $USER_NAME"
echo "  Home Directory   : $HOME_DIR"
echo ""
echo "  TIME & UPTIME"
echo "  -------------"
echo "  Current Date     : $CURRENT_DATE"
echo "  Current Time     : $CURRENT_TIME"
echo "  System Uptime    : $UPTIME"
echo ""
echo "  OPEN SOURCE SOFTWARE"
echo "  --------------------"
echo "  Auditing         : $SOFTWARE_CHOICE"
echo "  Python Version   : $PYTHON_VERSION"
echo "  OS License       : $OS_LICENSE"
echo ""
echo "  Note: This OS runs on the Linux kernel, which is licensed"
echo "  under GPL v2 — meaning anyone can view, modify, and"
echo "  redistribute it, provided changes stay open source."
echo ""
echo "================================================================"
echo "  'With enough eyeballs, all bugs are shallow.' — Linus's Law  "
echo "================================================================"
