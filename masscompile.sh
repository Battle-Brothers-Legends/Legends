#!/bin/bash
# put this in the bbsq directory
# Ensure the executables are in the same directory as the script
SCRIPT_DIR=$(dirname "$0")
SQ_CMD="wine $SCRIPT_DIR/sq.exe"
BBSQ_CMD="wine $SCRIPT_DIR/bbsq.exe"

# Recursively find and compile all .nut files
find "$1" -type f -name "*.nut" | while read -r file; do
    echo "${file%.nut}"
    $SQ_CMD -o "${file%.nut}.cnut" -c "$file"
    $BBSQ_CMD -e "${file%.nut}.cnut"
done

