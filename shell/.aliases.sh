#!/bin/bash

alias curl="curlie --silent"

alias tree="tree -C"
alias now="node -e \"console.log(Date.now())\""

# Git shortcuts
alias git-tree="git log --graph --oneline --all" # git-tree
alias cherry-pick="git cherry-pick"              # cherry-pick <commit-sha>

# ColorLS
alias ls="exa --group-directories-first -a --icons -s extension -x"

alias src="omz reload"
alias reload="omz reload"

alias b="brew"
alias c="clear"
alias g="git"
alias nv="nvim"
alias py="python3"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

alias cpf="cp -rf -i"
alias rmf="rm -rf -i"

alias mkdirp="mkdir -p"

# IP addresses
alias ip="curl --silent 'https://api.ipify.org?format=json' | jq -r .ip"
alias localip="ipconfig getifaddr en0"

# Copy my public key to the pasteboard
alias pbk="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
alias timeshell="/usr/bin/time zsh -i -c exit"

# Git Aliases
alias gpc="git push origin \$(branchName)"

# Generate a 32-byte random string
alias secret="openssl rand -base64 32 | tr -d '\n' | tr -d ' '"

# Recursively delete `.DS_Store` files
alias cat=better_cat
alias gpf='git pull --ff-only'
alias nah='git checkout -- .'
alias gs="git status -s"
alias genpass="genpass-monkey"
alias cd="z"
alias find=fd

alias pp="portPid"
alias p="pnpm"
alias y="yarn"

# parse timestamp to date
# alias as_date='node -e "console.log(new Date($1).toISOString())"'
alias xdg-open='open'
alias vi="nvim"
alias vim="nvim"
alias gac="git-add-commit"

alias la="lazygit"
alias gca="github-actions-autodocs"

alias tf="terraform"
alias vg="vagrant"

dalle() {
	openai api image.create -p "$1" --response-format url -n 1 | jq .data[0].url | xargs open
}
