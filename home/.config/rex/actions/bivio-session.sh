#!/bin/bash
set -euo pipefail

# bvo renders its picker on the terminal and returns the selection on stdout.
if ! selected=$(bvo pick); then
    exit 0
fi
[[ -n "$selected" ]] || exit 0

if [[ ! -d "$selected" ]]; then
    printf 'Not a directory: %s\n' "$selected" >&2
    exit 1
fi
path=$(cd -- "$selected" && pwd -P)
sessions=$(rex ls --json)
session_id=$(jq -r --arg path "$path" '.sessions[] | select(.label == $path) | .session_id' <<< "$sessions")

if [[ "$session_id" == *$'\n'* ]]; then
    printf 'Multiple Rex sessions are labeled %s; rename the duplicates first.\n' "$path" >&2
    exit 1
fi

if [[ -z "$session_id" ]]; then
    created=$(rex new "$path" --cwd "$path" --json)
    session_id=$(jq -er '.session_id' <<< "$created")
fi

client_args=()
if [[ -n "${1:-}" ]]; then
    client_args=(-C "$1")
fi
rex "${client_args[@]}" do session.select "session_id=$session_id"
