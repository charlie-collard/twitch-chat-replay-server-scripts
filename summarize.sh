#!/usr/bin/env bash
gunzip --stdout $1 | grep -m 1 -A30 "^ *\"video\": {" | sed 1,1d | awk '$0 ~ "^\\s*}" {exit} {print($0)} BEGIN {print("{")} END {print("}")}' | jq '{id, title, created_at, duration}'
