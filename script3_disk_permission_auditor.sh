#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Loops through key system directories and reports
#              permissions, ownership, and disk usage.
#              Also checks Python's config directory.
# ============================================================

# --- List of important system directories to audit ---
# These are standard Linux Filesystem Hierarchy Standard (FHS) paths
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/var")

echo "================================================================"
echo "         DISK AND PERMISSION AUDITOR                           "
echo "================================================================"
printf "%-20s %-25s %-10s\n" "Directory" "Permissions (type/user/group)" "Size"
echo "----------------------------------------------------------------"

# --- for loop: iterate over each directory in the DIRS array ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists using -d flag
    if [ -d "$DIR" ]; then

        # Extract permissions, owner user, and owner group using awk
        # ls -ld gives a long listing of the directory itself (not contents)
        # awk '{print $1, $3, $4}' picks columns: perms, user, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get human-readable size with du -sh
        # 2>/dev/null suppresses "permission denied" errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "%-20s %-25s %-10s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"

    else
        # Directory doesn't exist on this system
        printf "%-20s %-25s\n" "$DIR" "[does not exist]"
    fi

done

echo "----------------------------------------------------------------"
echo ""

# ================================================================
# PYTHON-SPECIFIC SECTION
# Check Python's key directories and config locations
# ================================================================
echo "================================================================"
echo "  PYTHON INSTALLATION FOOTPRINT                                "
echo "================================================================"
echo ""

# --- Define possible Python-related directories to check ---
# These vary by distro and Python version
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib64/python3"
    "/usr/local/lib/python3"
    "/etc/python3"
    "/usr/bin/python3"
    "/usr/local/bin/python3"
)

# --- Also try to find the actual Python lib path dynamically ---
# command -v checks if a command exists and returns its path
if command -v python3 &>/dev/null; then
    # Ask Python itself where its standard library lives
    PYTHON_LIB=$(python3 -c "import sys; print(sys.prefix)" 2>/dev/null)
    PYTHON_VERSION_DIR=$(python3 -c "import sys; print(sys.version[:3])" 2>/dev/null)
    echo "  Python3 found at   : $(command -v python3)"
    echo "  Python prefix      : $PYTHON_LIB"
    echo "  Python version     : $(python3 --version 2>&1)"
    echo ""

    # Add the dynamically discovered lib path to our check list
    PYTHON_DIRS+=("$PYTHON_LIB/lib/python${PYTHON_VERSION_DIR}")
    PYTHON_DIRS+=("$PYTHON_LIB/bin")
else
    echo "  python3 not found in PATH."
fi

echo "  Checking Python-related directories:"
echo "  -------------------------------------"

# --- Another for loop to check each Python directory ---
for PYDIR in "${PYTHON_DIRS[@]}"; do
    if [ -e "$PYDIR" ]; then
        # Get permissions of this path (works for files and dirs)
        PY_PERMS=$(ls -ld "$PYDIR" | awk '{print $1, $3, $4}')
        PY_SIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
        printf "  %-40s %-20s %s\n" "$PYDIR" "$PY_PERMS" "${PY_SIZE:-N/A}"
    else
        printf "  %-40s %s\n" "$PYDIR" "[not found on this system]"
    fi
done

echo ""
echo "================================================================"
echo "  WHY PERMISSIONS MATTER FOR OPEN SOURCE SOFTWARE              "
echo "================================================================"
echo ""
echo "  In Linux, file permissions control WHO can read, write, or"
echo "  execute a file. For open-source software like Python:"
echo ""
echo "  • Binaries in /usr/bin are owned by root but executable by all"
echo "  • Config in /etc is readable by all but writable only by root"
echo "  • This prevents malicious modification of shared OSS tools"
echo "  • Open source means the SOURCE is open — not that files are"
echo "    unprotected at runtime. Linux permissions enforce this."
echo ""
echo "================================================================"
