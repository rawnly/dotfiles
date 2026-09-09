#!/usr/bin/env bash

#MISE description="Installs tailascale"
#MISE interactive=true

source "${MISE_ORIGINAL_CWD}/mise-tasks/lib/dx.sh"

if ! command -v htmlq; then
  echo "htmlq is required."
  exit 1
fi

pkg_href=$(curl --silent --fail https://pkgs.tailscale.com/stable/?v=latest | htmlq 'details#macos li:last-child > a[href]' -a href)
uri="https://pkgs.tailscale.com/stable/$pkg_href"
tempd=$(mktemp -d)
download_path="$tempd/$pkg_href"
appdir="/Applications"

cleanup() {
  echo "Cleaning up downloaded assets"
  rm -rf "$tempd"
}

trap cleanup EXIT SIGINT

dx::download "$uri" "$download_path"
dx::pkg::install "$download_path" "$appdir"
dx::completed "Tailscale"
