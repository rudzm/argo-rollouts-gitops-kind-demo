#!/usr/bin/env bash
set -euo pipefail
URL="${1:-http://demo.localtest.me/}"
CONCURRENCY="${CONCURRENCY:-1}"
SLEEP_SECONDS="${SLEEP_SECONDS:-0.2}"
while true; do
  for _ in $(seq 1 "$CONCURRENCY"); do
    curl -s -o /dev/null -w '%{http_code}\n' "$URL" &
  done
  wait
  sleep "$SLEEP_SECONDS"
done
