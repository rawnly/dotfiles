complete -c pkg -f -n "test -f package.json" -a "$(jq -r 'keys[]' package.json)"
