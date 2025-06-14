#!/usr/bin/env bash
# health_check.sh — finds the first badge URL that returns 200 for N checks

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
  echo "=== $(date +'%T') ==="
  for url in "${URLS[@]}"; do
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    printf "  %s  %s\n" "$code" "$url"
    if [[ "$code" == "200" ]]; then
      (( count200["$url"]++ ))
    else
      count200["$url"]=0
    fi

    # If any URL has reached CONSEC consecutive 200s, we declare it stable
    if (( count200["$url"] >= CONSEC )); then
      echo
      echo "✅ Stable badge URL detected (200 for $CONSEC checks):"
      echo "   $url"
      exit 0
    fi
  done
  echo "Sleeping $SLEEP seconds..."
  echo
  sleep "$SLEEP"
done

