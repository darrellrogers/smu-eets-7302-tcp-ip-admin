#!/bin/bash

# Define the starting IP and the number of IP addresses to ping
START_IP="10.0.4.1"
COUNT=25

# Loop through the IP addresses
for ((i=0; i<$COUNT; i++)); do
  # Calculate the current IP address
  IP=$(echo "$START_IP" | awk -F. '{print $1"."$2"."$3"."($4+'$i')}')

  # Ping the IP address once to check connectivity
  if ping -c 1 -W 1 $IP > /dev/null 2>&1; then
    # If the IP is reachable, run 5 more pings and report the statistics
    echo "Pinging IP: $IP"
    ping -c 5 $IP | tail -1 | awk '{print "Min Delay: "$4" ms, Avg Delay: "$5" ms, Max Delay: "$6" ms"}'
    # Report the domain name for the IP
    DOMAIN=$(nslookup $IP | awk '/name =/ {print $4}')
    echo "Domain Name: ${DOMAIN:-"Domain name not found"}"
  else
    # If the IP is not reachable, indicate no connection
    echo "No connection to IP $IP"
  fi
done


