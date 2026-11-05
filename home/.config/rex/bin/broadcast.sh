#!/bin/sh
# Prompt loop for the broadcast action: each line goes to every pane in this tab. ctrl+d quits.
echo "Broadcast to every pane in this tab. Empty line sends Enter, ctrl+d quits."
while printf 'broadcast> ' && IFS= read -r line; do
	rex do broadcast text="$line" >/dev/null || echo "broadcast failed"
done
