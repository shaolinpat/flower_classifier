#!/usr/bin/env bash
# health_check.sh — finds all badge URLs that return 200 for N checks

# Read URLs
URLS=()
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  URLS+=("$line")
done < badges.txt

CONSEC=50             # number of consecutive 200s required
SLEEP=5               # seconds between checks
declare -A count200

iter=0

echo "Testing ${#URLS[@]} badge URLs; need $CONSEC consecutive 200 responses."
echo

while true; do
  ((iter++))
  echo "=== Iteration $iter at $(date +'%T') ==="

  # Track which URLs became stable this round
  stable=()

  for url in "${URLS[@]}"; do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    printf "  %3s  %s\n" "$code" "$url"
    
    if [[ "$code" == "200" ]]; then
      (( count200["$url"]++ ))
    else
      count200["$url"]=0
    fi

    # If this URL has now reached the threshold, record it
    if (( count200["$url"] >= CONSEC )); then
      stable+=("$url")
    fi
  done

  # If any URLs are stable, print them all and exit
  if (( ${#stable[@]} )); then
    echo
    echo "✅ The following URLs have been stable for $CONSEC consecutive checks:"
    for s in "${stable[@]}"; do
      echo "   $s"
    done
    exit 0
  fi

  echo "Sleeping $SLEEP seconds..."
  echo
  sleep "$SLEEP"
done

