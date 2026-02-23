#!/bin/bash

# Get hours for each timezone (0-23)
atlanta_hour=$(TZ=America/New_York date '+%H' | sed 's/^0//')
jakarta_hour=$(TZ=Asia/Jakarta date '+%H' | sed 's/^0//')
kuala_lumpur_hour=$(TZ=Asia/Kuala_Lumpur date '+%H' | sed 's/^0//')
tokyo_hour=$(TZ=Asia/Tokyo date '+%H' | sed 's/^0//')
sydney_hour=$(TZ=Australia/Sydney date '+%H' | sed 's/^0//')

# Timeline header
echo ""
echo "                0     6     12    18    24"
echo "                |-----|-----|-----|-----|"

# Function to draw a city on the timeline
draw_city() {
    local name=$1
    local hour=$2
    local pos=$((hour * 5 / 6))  # Map 0-23 hours to 0-50 chars roughly
    local line=$(printf '%*s' $((pos + 2)) | tr ' ' '-')
    printf "  %-15s%s*\n" "$name" "$line"
}

draw_city "atlanta" "$atlanta_hour"
draw_city "jakarta" "$jakarta_hour"
draw_city "kuala lumpur" "$kuala_lumpur_hour"
draw_city "tokyo" "$tokyo_hour"
draw_city "sydney" "$sydney_hour"

echo ""
