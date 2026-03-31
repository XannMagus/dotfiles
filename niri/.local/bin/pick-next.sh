#!/usr/bin/env bash

TARGET_DIR="${1:-$PWD}"
STATE_FILE="/tmp/pool_$(echo -n "$TARGET_DIR" | md5sum | cut -d ' ' -f1)"

if [[ ! -s "$STATE_FILE" ]]; then
    find "$TARGET_DIR" -maxdepth 1 -type f > "$STATE_FILE"
    shuf "$STATE_FILE" -o "$STATE_FILE"
fi

NEXT_FILE=$(head -n 1 "$STATE_FILE")

sed -i '1d' "$STATE_FILE"

echo "$NEXT_FILE"
