#!/bin/bash

# run.sh <script.st>

if [ -z "$1" ]; then
    echo "Usage: ./run.sh <script.st>"
    exit 1
fi

ST_SCRIPT=$(realpath "$1")

echo "--- Starting run for $ST_SCRIPT ---"

# 1. Download Pharo
echo "Downloading Pharo..."
wget -O- get.pharo.org/130+vm | bash

# 2. Run the script
echo "Executing script..."
./pharo Pharo.image st "$ST_SCRIPT" --quit

echo "--- Run for $ST_SCRIPT completed ---"
