#!/bin/bash
# System information script — Zhebegenov Ersultan, IT2-2309

# Path to the info file (project root = one level above this script)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INFO_FILE="$SCRIPT_DIR/../Zhebegenov_Ersultan_info.txt"

LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo "Name: Ersultan"
echo "Surname: Zhebegenov"
echo "Group: IT2-2309"
echo "Student ID: 37138"
echo "$LINE"
echo "System Information"
echo "$LINE"
echo "Username: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Operating System: $(uname -s -r -m)"
if [ -f /etc/os-release ]; then
    echo "Distribution: $(. /etc/os-release && echo "$PRETTY_NAME")"
fi
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 " used of " $2 " (" $5 ")"}')"
if command -v free >/dev/null 2>&1; then
    echo "Memory Usage: $(free -h | awk '/^Mem:/ {print $3 " used of " $2}')"
else
    echo "Memory Usage: $(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%d MB used of %d MB", (t-a)/1024, t/1024}' /proc/meminfo)"
fi
echo "$LINE"

# Check that the student information file exists
if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
