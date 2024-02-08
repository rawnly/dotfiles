#!/usr/bin/env bash

if ! brew --version; then
	echo "Installing Homebrew"

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# basics
brew install git node go python3 oven-sh/tap/bun

brew install httpie curlie

# scripting
brew install zoxide bat exa fzf fd ripgrep jq glow tokei tree broot dog dust hyperfine atuin sd delta
brew install orbstack biome goreleaser

# shell stuff
brew install bash zsh-completions zsh-vi-mode zplug zsh-syntax-highlighting zsh-autosuggestions

brew install tmux neovim helix caarlos0/tap/svu wezterm

brew install --cask arc 1password spotify raycast
brew install --cask hammerspoon
