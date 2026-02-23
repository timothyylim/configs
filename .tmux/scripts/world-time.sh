#!/bin/bash

# Display current time in multiple timezones
echo ""
echo "  🌍 WORLD TIME"
echo ""
echo "  Atlanta    🇺🇸  $(TZ=America/New_York date '+%I:%M %p %Z')"
echo "  Oslo       🇳🇴  $(TZ=Europe/Oslo date '+%H:%M %Z')"
echo "  Kuala Lumpur 🇲🇾  $(TZ=Asia/Kuala_Lumpur date '+%H:%M %Z')"
echo "  Tokyo      🇯🇵  $(TZ=Asia/Tokyo date '+%H:%M %Z')"
echo "  Sydney     🇦🇺  $(TZ=Australia/Sydney date '+%H:%M %Z')"
echo ""
