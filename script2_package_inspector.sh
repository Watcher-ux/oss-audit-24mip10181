#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Checks if a FOSS package is installed, shows
#              its version/license, and prints a philosophy note
# ============================================================

# --- The package we are inspecting (our chosen OSS: Python) ---
PACKAGE="python3"

# --- Detect package manager: supports both rpm and dpkg systems ---
# rpm  → used on Fedora, RHEL, CentOS
# dpkg → used on Debian, Ubuntu
detect_package_manager() {
    if command -v rpm &>/dev/null; then
        echo "rpm"
    elif command -v dpkg &>/dev/null; then
        echo "dpkg"
    else
        echo "unknown"
    fi
}

PKG_MANAGER=$(detect_package_manager)   # Store detected package manager

echo "================================================"
echo "       FOSS PACKAGE INSPECTOR                  "
echo "================================================"
echo "  Package to inspect : $PACKAGE"
echo "  Package manager    : $PKG_MANAGER"
echo "================================================"
echo ""

# --- Check if the package is installed using if-then-else ---
if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based check
    if rpm -q $PACKAGE &>/dev/null; then
        echo "[✔] $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details (from rpm):"
        echo "  ---------------------------"
        # Use grep with pipe to filter only relevant fields
        rpm -qi $PACKAGE | grep -E 'Name|Version|License|Summary|URL'
    else
        echo "[✘] $PACKAGE is NOT installed."
        echo "    To install: sudo dnf install python3"
    fi

elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg-based check (Debian/Ubuntu)
    if dpkg -l $PACKAGE 2>/dev/null | grep -q "^ii"; then
        echo "[✔] $PACKAGE is INSTALLED on this system."
        echo ""
        echo "  Package Details (from dpkg):"
        echo "  ----------------------------"
        # dpkg -s gives full status; pipe through grep for key fields
        dpkg -s $PACKAGE | grep -E 'Package|Version|License|Description'
        echo ""
        # Also show the actual Python version from the binary
        echo "  Runtime Version  : $(python3 --version 2>&1)"
    else
        echo "[✘] $PACKAGE is NOT installed."
        echo "    To install: sudo apt install python3"
    fi

else
    # Fallback: try running python3 directly if no package manager found
    if command -v python3 &>/dev/null; then
        echo "[✔] python3 binary found (package manager not detected)"
        echo "  Version: $(python3 --version 2>&1)"
    else
        echo "[✘] Could not detect package manager or python3 binary."
    fi
fi

echo ""
echo "================================================"
echo "  OPEN SOURCE PHILOSOPHY NOTES                  "
echo "================================================"
echo ""

# --- case statement: prints a philosophy note based on package name ---
# This demonstrates the 'case' construct in bash
case $PACKAGE in
    python3 | python)
        echo "  Python (PSF License):"
        echo "  'There should be one obvious way to do it.'"
        echo "  Python was born from frustration with closed tools."
        echo "  Guido van Rossum shared it freely on Usenet in 1991."
        echo "  Today it powers AI, science, and education worldwide."
        ;;
    httpd | apache2)
        echo "  Apache HTTP Server (Apache 2.0 License):"
        echo "  The web server that helped build the open internet."
        echo "  Apache allows commercial use with no copyleft requirement."
        ;;
    mysql | mysql-server)
        echo "  MySQL (GPL v2 / Commercial dual license):"
        echo "  Open source at the heart of millions of applications."
        echo "  Dual licensing means freedom — and a business model."
        ;;
    vlc)
        echo "  VLC Media Player (LGPL/GPL):"
        echo "  Built by students in Paris who just wanted to stream video."
        echo "  Proves open source can be both powerful and user-friendly."
        ;;
    firefox)
        echo "  Firefox (MPL 2.0):"
        echo "  A nonprofit browser fighting for an open web."
        echo "  Born from Netscape's decision to open its source code."
        ;;
    git)
        echo "  Git (GPL v2):"
        echo "  Linus built it in two weeks after a proprietary tool failed him."
        echo "  Now the backbone of nearly all software development."
        ;;
    *)
        # Default case if package name doesn't match any above
        echo "  $PACKAGE: An open-source tool contributing to the free software ecosystem."
        ;;
esac

echo ""
echo "================================================"
