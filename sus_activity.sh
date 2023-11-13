#!/bin/bash

# Define the user to monitor
target_user="edward"

# Define the time range (midnight to 6 AM)
start_time=0
end_time=6

# Read authentication logs and filter suspicious activities
grep "sshd" /var/log/auth.log | awk -v target_user="$target_user" -v start_time="$start_time" -v end_time="$end_time" '{
    timestamp=$1 " " $2 " " $3
    ip_address=$NF
    username=$(NF-2)

    # Extract hour from the timestamp
    hour=$(date -d "$timestamp" +"%H")

    # Check for suspicious activity
    if ((hour >= start_time && hour < end_time) && username == target_user) {
	    echo "Suspicious login attempt at $timestamp from $ip_address for user $target_user"
    }
}'
    
