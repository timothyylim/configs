#!/bin/bash

# Display current time in multiple timezones
echo ""
echo "  🌍 world time"
echo ""
echo "  atlanta    🇺🇸  $(TZ=America/New_York date '+%I:%M %p %Z')"
echo "  oslo       🇳🇴  $(TZ=Europe/Oslo date '+%H:%M %Z')"
echo "  jakarta    🇮🇩  $(TZ=Asia/Jakarta date '+%H:%M %Z')"
echo "  kuala lumpur 🇲🇾  $(TZ=Asia/Kuala_Lumpur date '+%H:%M %Z')"
echo "  tokyo      🇯🇵  $(TZ=Asia/Tokyo date '+%H:%M %Z')"
echo "  sydney     🇦🇺  $(TZ=Australia/Sydney date '+%H:%M %Z')"
echo ""
