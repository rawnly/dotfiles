#!/usr/bin/env fish

alias tree "tree -C"

# ColorLS
alias ls="eza --group-directories-first -a --icons -s extension -x"
alias l="eza -lhF --group-directories-first --icons -s extension -x -a --no-user --no-time --smart-group --no-permissions --git"

# IP addresses
alias ip "curl --silent 'https://api.ipify.org?format=json' | jq -r .ip"
alias localip "ipconfig getifaddr en0"

# Copy my public key to the pasteboard
alias pbk "more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

# Git Aliases
alias gpc "git push origin \$(branchName)"

# Generate a 32-byte random string
alias secret="openssl rand -base64 32 | tr -d '\n' | tr -d ' '"

# Recursively delete `.DS_Store` files
alias cat 'bat -p'
alias cd z

# keep scrollback
alias c="printf '\033[H\033[2J'"

alias pp portPid

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
