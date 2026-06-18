#!/bin/bash

# Function to ping an IP address once
ping_ip() {
    local ip=$1
    # Ping the IP address once to check connectivity
    if ping -c 1 -W 1 $ip > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Function to get ping statistics (min, avg, max)
get_ping_statistics() {
    local ip=$1
    # Ping the IP address 5 times
    local stats=$(ping -c 5 $ip | tail -1 | awk '{print $4}')
    # Extract min, avg, max from the result
    local min=$(echo $stats | cut -d '/' -f 1)
    local avg=$(echo $stats | cut -d '/' -f 2)
    local max=$(echo $stats | cut -d '/' -f 3)
    echo "$min $avg $max"
}

# Function to get the domain name for an IP address
get_domain_name() {
    local ip=$1
    # Use nslookup to find the domain name
    local domain=$(nslookup $ip | awk '/name =/ {print $4}')
    # If domain is empty, return a default message
    echo ${domain:-"Domain name not found"}
}

# Main function to ping a sequence of IPs
main() {
    local start_ip=$1
    local count=$2

    # Convert IP address to an array of integers
    IFS='.' read -r -a ip_parts <<< "$start_ip"

    for ((i=0; i<$count; i++)); do
        # Construct the current IP address
        local ip="${ip_parts[0]}.${ip_parts[1]}.${ip_parts[2]}.${ip_parts[3]}"
        echo "Pinging IP: $ip"

        if ping_ip $ip; then
            echo "IP $ip is reachable."
            read min avg max <<< $(get_ping_statistics $ip)
            echo "Min Delay: $min ms, Avg Delay: $avg ms, Max Delay: $max ms"
            domain_name=$(get_domain_name $ip)
            echo "Domain Name: $domain_name"
        else
            echo "No connection to IP $ip."
        fi

        # Increment the last octet of the IP address
        ((ip_parts[3]++))
        for ((j=3; j>0; j--)); do
            if [ ${ip_parts[j]} -gt 255 ]; then
                ip_parts[j]=0
                ((ip_parts[j-1]++))
            fi
        done
    done
}

# Example usage: start from IP 192.168.1.1 and ping 5 addresses
start_ip="10.0.4.1"
count=5
main $start_ip $count








