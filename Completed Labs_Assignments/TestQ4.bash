#!/bin/bash

# IP address
if [ -z "$1" ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

# Variables
IP_ADDRESS="$1"
NAME="Darrell Rogers"
DATE=$(date)

# Print name and system date
echo "Name: $NAME"
echo "Date: $DATE"

# Ping the provided IP address
if ping -c 1 -W 1 "$IP_ADDRESS" &> /dev/null; then
    echo "Result: $IP_ADDRESS is reachable."
else
    echo "Result: $IP_ADDRESS is unreachable."
fi
