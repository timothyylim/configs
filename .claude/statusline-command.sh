#!/bin/bash

input=$(cat)
dir=$(echo "$input" | jq -r '.workspace.current_dir')

printf "\x1b[38;2;122;64;48m%s\x1b[0m" "$(basename "$dir")"

# Use symbolic-ref for branches (works even with no commits)
git_branch=$(git -C "$dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$git_branch" ]; then
  printf " \x1b[38;2;232;100;58m[%s]\x1b[0m" "$git_branch"
fi

# Context usage progress bar
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  filled=$(( used_int / 10 ))
  empty=$(( 10 - filled ))
  bar=""
  for i in $(seq 1 $filled); do bar="${bar}█"; done
  for i in $(seq 1 $empty); do bar="${bar}░"; done
  if [ "$used_int" -ge 80 ]; then
    color="\x1b[38;5;203m"
  elif [ "$used_int" -ge 50 ]; then
    color="\x1b[38;5;214m"
  else
    color="\x1b[38;2;232;100;58m"
  fi
  # Raw token counts derived from percentage (consistent with the bar)
  ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
  if [ -n "$ctx_size" ]; then
    used_k=$(awk "BEGIN { printf \"%.0f\", $used_int * $ctx_size / 100000 }")
    total_k=$(awk "BEGIN { printf \"%.0f\", $ctx_size / 1000 }")
    printf "  ${color}%s %dk/%dk (%d%%)\x1b[0m" "$bar" "$used_k" "$total_k" "$used_int"
  else
    printf "  ${color}%s %d%%\x1b[0m" "$bar" "$used_int"
  fi
fi

# Rate limit reset countdown
resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$resets_at" ]; then
  now=$(date +%s)
  diff=$(( resets_at - now ))
  if [ "$diff" -gt 0 ]; then
    hours=$(( diff / 3600 ))
    minutes=$(( (diff % 3600) / 60 ))
    if [ "$hours" -ge 1 ]; then
      countdown="${hours}h${minutes}m"
    else
      countdown="${minutes}m"
    fi
    printf "  \x1b[38;2;122;64;48m↺ %s\x1b[0m" "$countdown"
  fi
fi

printf "\n"
