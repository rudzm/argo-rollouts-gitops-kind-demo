#!/usr/bin/env bash
set -euo pipefail
URL="${1:-http://127.0.0.1:8888/}"
CONCURRENCY="${CONCURRENCY:-1}"
SLEEP_SECONDS="${SLEEP_SECONDS:-0.2}"
while true; do
  for _ in $(seq 1 "$CONCURRENCY"); do
    curl -s -o /dev/null -w '%{http_code}\n' "$URL" -H 'Host: demo.example.me' &
  done
  wait
  sleep "$SLEEP_SECONDS"
done
