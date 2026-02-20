#!/bin/bash

while read session; do
  case "$session" in
    alexis) echo "✦ $session" ;;         # sparkle
    bifrost) echo "❄ $session" ;;        # snowflake
    config) echo "⚙ $session" ;;         # gear
    ethstrat) echo "⊙ $session" ;;       # circle (network node)
    habitat) echo "◈ $session" ;;        # diamond (tree/nature)
    hyperspeed) echo "⚡ $session" ;;     # lightning
    thibault) echo "⚜ $session" ;;       # fleur-de-lis
    totormis) echo "🐢 $session" ;;      # turtle
    visions) echo "◉ $session" ;;        # eye
    *) echo "$session" ;;
  esac
done
