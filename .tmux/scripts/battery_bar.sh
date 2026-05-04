#!/usr/bin/env bash
pmset -g batt | grep -q 'AC Power' && exit 0
pct=$(pmset -g batt | grep -o '[0-9]*%' | head -1 | tr -d '%')
[ -z "$pct" ] && exit 0
filled=$(( (pct * 10 + 99) / 100 ))
bar=""
for i in $(seq 1 10); do
  [ $i -le $filled ] && bar="${bar}█" || bar="${bar}░"
done
echo "$bar"
