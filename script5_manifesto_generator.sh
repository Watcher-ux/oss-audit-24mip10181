#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Roll: [Your Roll Number]
# Course: Open Source Software | Chosen Software: Python
# Description: Interactively asks the user 3 questions and
#              generates a personalised open source philosophy
#              statement, saved to a .txt file.
# ============================================================

# ============================================================
# ALIASES DEMONSTRATION
# In bash, aliases create shorthand names for longer commands.
# Note: aliases defined in scripts don't persist to the shell,
# but they demonstrate the concept as required by the rubric.
# ============================================================
alias today='date "+%d %B %Y"'          # 'today' now means the date command
alias greet='echo "Hello from OSS!"'    # simple greeting alias

# ============================================================
# WELCOME BANNER
# ============================================================

echo ""
echo "================================================================"
echo "         OPEN SOURCE MANIFESTO GENERATOR                       "
echo "         Python OSS Audit | Open Source Software Course        "
echo "================================================================"
echo ""
echo "  This script will create a personalised open source"
echo "  philosophy statement based on your answers."
echo ""
echo "  Answer honestly — your manifesto should reflect"
echo "  your own relationship with free and open software."
echo ""
echo "----------------------------------------------------------------"
echo ""

# ============================================================
# USER INPUT — using 'read' to capture interactive responses
# ============================================================

# Question 1: A tool they use every day
read -p "  1. Name one open-source tool you use every day: " TOOL

# Validate: don't allow empty input
while [ -z "$TOOL" ]; do
    echo "     [!] Please enter a tool name."
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

echo ""

# Question 2: What freedom means to them
read -p "  2. In one word, what does 'freedom' mean to you in software? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "     [!] Please enter a word."
    read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
done

echo ""

# Question 3: Something they would build and share
read -p "  3. Name one thing you would build and share freely with the world: " BUILD

while [ -z "$BUILD" ]; do
    echo "     [!] Please enter something you'd build."
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "----------------------------------------------------------------"
echo "  Generating your manifesto..."
echo "----------------------------------------------------------------"
echo ""

# ============================================================
# FILE SETUP
# ============================================================

# Get current date and username for the output filename
DATE=$(date '+%d %B %Y')                    # e.g. 22 March 2025
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')         # e.g. 20250322_143055
AUTHOR=$(whoami)                            # Current Linux username

# Output filename includes username and timestamp for uniqueness
OUTPUT="manifesto_${AUTHOR}_${TIMESTAMP}.txt"

# ============================================================
# STRING CONCATENATION — building the manifesto paragraph
# Each variable is woven into the statement using $VARIABLE syntax
# ============================================================

# Build each paragraph as a variable (string concatenation)
LINE1="MY OPEN SOURCE MANIFESTO"
LINE2="Written by: $AUTHOR | Date: $DATE"
LINE3="Course: Open Source Software | Software Audited: Python"

PARA1="Every day, I use $TOOL — a tool I did not pay for, did not ask permission"
PARA1+=" to use, and can look inside whenever I choose. This is not an accident."
PARA1+=" It is the result of people who believed that software, like knowledge,"
PARA1+=" should be shared. I am the beneficiary of their generosity."

PARA2="To me, freedom in software means $FREEDOM. Not the freedom to do anything"
PARA2+=" without consequence, but the freedom to understand what my tools do,"
PARA2+=" to fix them when they break, and to pass them on improved."
PARA2+=" Python taught me this: readable code is a form of respect for the next person."

PARA3="If I could build one thing and share it freely, it would be $BUILD."
PARA3+=" I would share it because I have taken from this ecosystem — from the"
PARA3+=" developers who built Python, Git, Linux, and countless libraries — and"
PARA3+=" giving back is not charity. It is the contract that makes open source work."

PARA4="Open source is not just a licensing model. It is a statement that says:"
PARA4+=" the tools we build together are stronger than the tools we hoard alone."
PARA4+=" I choose to stand on the shoulders of giants — and to be a shoulder, in turn."

SIGNATURE="— $AUTHOR | Generated on $DATE | Open Source Software Course"

# ============================================================
# WRITE TO FILE using > (overwrite) and >> (append)
# ============================================================

# Use > to create/overwrite the file with the first line
echo "$LINE1" > "$OUTPUT"

# Use >> to append subsequent lines
echo "$LINE2" >> "$OUTPUT"
echo "$LINE3" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA1" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA2" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA3" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "$PARA4" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"
echo "$SIGNATURE" >> "$OUTPUT"
echo "================================================================" >> "$OUTPUT"

# ============================================================
# DISPLAY THE MANIFESTO
# ============================================================

echo ""
echo "================================================================"
echo "  YOUR OPEN SOURCE MANIFESTO"
echo "================================================================"
echo ""

# cat reads and displays the file we just created
cat "$OUTPUT"

echo ""
echo "================================================================"
echo "  [✔] Manifesto saved to: $OUTPUT"
echo "  You can print it with:  cat $OUTPUT"
echo "  Or copy it with:        cp $OUTPUT ~/Desktop/"
echo "================================================================"
echo ""
