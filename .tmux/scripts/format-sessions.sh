#!/bin/bash

while read session; do
  case "$session" in
    alexis) echo "✦ $session" ;;
    bifrost) echo "❄ $session" ;;
    config) echo "◈ $session" ;;
    confg) echo "⚒ $session" ;;
    configs) echo "◈ $session" ;;
    ethstrat) echo "⊙ $session" ;;
    habitat) echo "◈ $session" ;;
    hyperspeed) echo "⚡ $session" ;;
    thibault) echo "⚜ $session" ;;
    totormis) echo "🤖 $session" ;;
    visions) echo "◉ $session" ;;
    *) echo "$session" ;;
  esac
done
