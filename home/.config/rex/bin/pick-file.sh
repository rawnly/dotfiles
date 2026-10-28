#!/bin/sh
# Pick a file with bracco (in this floating pane), then edit it in a new, focused tab.
f=$(bracco) || exit 0
[ -n "$f" ] || exit 0
win=$(rex window new -c "$PWD" --focus=false --json "$(basename "$f")" -- nvim "$f" | jq -r .window_id) || exit 1
# `rex window focus` only changes the server's active window; the app client
# keeps showing its own tab. session.select tells the client to switch.
rex do session.select session_id="$REX_SESSION" window_id="$win"
exec rex block close "$REX_BLOCK"
