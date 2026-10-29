#!/usr/bin/env bash

#MISE description="Installs DIA"
#MISE interactive=true

uri="https://releases.diabrowser.com/release/Dia-latest.dmg"
tempd=$(mktemp -d)
download_path="$tempd/dia.dmg"
appdir="/Applications"

source "${MISE_ORIGINAL_CWD}/mise-tasks/lib/dx.sh"

cleanup() {
  echo "Cleaning up downloaded assets"
  rm -rf "$tempd"
}

trap cleanup EXIT SIGINT

dx::download "$uri" "$download_path"

killall Dia || true

dx::dmg::install "$download_path" "$appdir"

dx::completed "Dia"
