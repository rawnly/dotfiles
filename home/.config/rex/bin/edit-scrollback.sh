#!/bin/sh
# Dump block $1's screen+scrollback to a temp file and open it in nvim, at the end.
tmp=$(mktemp "${TMPDIR:-/tmp}/rex-scrollback.XXXXXX") || exit 1
trap 'rm -f "$tmp"' EXIT
rex capture -b "$1" --trim > "$tmp" || exit 1
nvim -R "+normal G" "$tmp"
