#!/bin/bash

echo ""
echo "  atlanta      $(TZ=America/New_York date '+%H:%M')"
echo "  jakarta      $(TZ=Asia/Jakarta date '+%H:%M')"
echo "  kuala lumpur $(TZ=Asia/Kuala_Lumpur date '+%H:%M')"
echo "  tokyo        $(TZ=Asia/Tokyo date '+%H:%M')"
echo "  sydney       $(TZ=Australia/Sydney date '+%H:%M')"
echo ""
