#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Reads a log file line by line, counts keyword
#              occurrences, and prints a summary with last 5 matches.
#              Accepts log file path and keyword as arguments.
# Usage: ./script4_log_analyzer.sh /var/log/syslog error
#        ./script4_log_analyzer.sh /var/log/messages WARNING
# ============================================================

# --- Command-line arguments ---
# $1 is the first argument (log file path)
# $2 is the second argument (keyword to search), defaults to "error"
LOGFILE=$1
KEYWORD=${2:-"error"}       # If no keyword given, default to "error"

# --- Counters (initialized to zero) ---
COUNT=0                     # Tracks how many lines match the keyword
LINE_NUMBER=0               # Tracks current line number for display
MATCH_LINES=()              # Array to store matching lines for display

# ================================================================
# INPUT VALIDATION — check arguments before processing
# ================================================================

# Check if a log file argument was provided at all
if [ -z "$LOGFILE" ]; then
    echo "================================================================"
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo "================================================================"
    exit 1
fi

# ================================================================
# DO-WHILE STYLE RETRY LOOP
# Try to find a valid, non-empty log file
# In bash there's no native do-while, so we use: while true + break
# ================================================================

MAX_RETRIES=3       # Maximum number of times to ask for a new file
ATTEMPT=0           # Current attempt counter

while true; do
    ATTEMPT=$((ATTEMPT + 1))    # Increment attempt counter

    # Check 1: Does the file exist?
    if [ ! -f "$LOGFILE" ]; then
        echo "[!] Attempt $ATTEMPT/$MAX_RETRIES: File '$LOGFILE' not found."

        # If we've hit max retries, give up
        if [ $ATTEMPT -ge $MAX_RETRIES ]; then
            echo "[✘] Maximum retries reached. Exiting."
            exit 1
        fi

        # Ask the user for a different file path
        read -p "    Enter a different log file path: " LOGFILE
        continue    # Go back to the top of the while loop
    fi

    # Check 2: Is the file empty?
    if [ ! -s "$LOGFILE" ]; then
        echo "[!] Attempt $ATTEMPT/$MAX_RETRIES: File '$LOGFILE' exists but is empty."

        if [ $ATTEMPT -ge $MAX_RETRIES ]; then
            echo "[✘] Maximum retries reached. Exiting."
            exit 1
        fi

        read -p "    Enter a different log file path: " LOGFILE
        continue
    fi

    # If we reach here, file exists and is non-empty — break the loop
    echo "[✔] Log file found: $LOGFILE"
    break

done

# ================================================================
# MAIN ANALYSIS — while read loop processes file line by line
# ================================================================

echo ""
echo "================================================================"
echo "  LOG FILE ANALYZER                                            "
echo "================================================================"
echo "  File    : $LOGFILE"
echo "  Keyword : '$KEYWORD' (case-insensitive search)"
echo "================================================================"
echo ""
echo "  Scanning..."
echo ""

# while read loop: reads the file one line at a time
# IFS= preserves leading/trailing whitespace in each line
# -r prevents backslash from being treated as escape character
while IFS= read -r LINE; do
    LINE_NUMBER=$((LINE_NUMBER + 1))    # Increment line counter

    # if-then: check if this line contains our keyword (case-insensitive)
    # grep -iq: -i = case insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))            # Increment match counter

        # Store this matching line in our array (with line number prefix)
        MATCH_LINES+=("Line $LINE_NUMBER: $LINE")
    fi

done < "$LOGFILE"   # Feed the file into the while loop via stdin redirection

# ================================================================
# RESULTS SUMMARY
# ================================================================

echo "  SCAN COMPLETE"
echo "  -------------"
echo "  Total lines scanned  : $LINE_NUMBER"
echo "  Keyword matches      : $COUNT"
echo "  Match rate           : $(awk "BEGIN {printf \"%.2f\", ($COUNT/$LINE_NUMBER)*100}")%"
echo ""

# Only show last-matches section if we found anything
if [ $COUNT -gt 0 ]; then
    echo "  LAST 5 MATCHING LINES"
    echo "  ---------------------"

    # Calculate how many to show (min of 5 and total count)
    SHOW=$COUNT
    if [ $SHOW -gt 5 ]; then
        SHOW=5
    fi

    # Get total number of matches stored
    TOTAL=${#MATCH_LINES[@]}

    # Calculate starting index to show last 5
    START=$((TOTAL - SHOW))

    # Loop through the last SHOW entries in our array
    for (( i=START; i<TOTAL; i++ )); do
        echo "  ${MATCH_LINES[$i]}"
    done

    echo ""
    echo "  (Showing last $SHOW of $COUNT matches)"
else
    echo "  [✘] No lines matched keyword '$KEYWORD' in this file."
    echo "      Try a different keyword, e.g.: ERROR, WARNING, FAILED, python"
fi

echo ""
echo "================================================================"
echo "  TIP: Common log files to analyze on Linux:"
echo "    /var/log/syslog       → General system log (Debian/Ubuntu)"
echo "    /var/log/messages     → General system log (RHEL/Fedora)"
echo "    /var/log/auth.log     → Authentication events"
echo "    /var/log/kern.log     → Kernel messages"
echo "    ~/.xsession-errors    → Desktop session errors"
echo "================================================================"
