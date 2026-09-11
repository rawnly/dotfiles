#!/usr/bin/env bash

function dx::download {
  uri="$1"
  dest="$2"

  curl --silent --fail -L "$uri" > "$dest"

  echo "Downloaded to: '${dest}'"
}


function mount {
  if [ -z "$1" ]; then 
    echo "Usage: $0 <dmg>"
    exit 1
  fi

  hdiutil attach "$1" | grep Volumes | cut -f 3
}

function unmount {
  if [ -z "$1" ]; then 
    echo "Usage: $0 <volume>"
    exit 1
  fi

  hdiutil detach "/Volumes/$1" 2>&1 /dev/null
}

function dx::dmg::install {
  set -x 
  dmg="$1"
  dest="${2:/Applications}"

  echo "Mounting dmg..."
  volume=$(mount "$dmg")
  echo "Volume mounted at: $volume"

  for app in "$volume"/*.app; do
    echo "Copying $app"
    sudo cp -rf "${volume}/${app}" "$dest"
  done

  echo "Unmounting volume: $volume"
  unmount "$volume"
  set +x 
}

function dx::pkg::install {
  if [ -z "$1" ]; then 
    echo "Usage: install_pkg <pkg> [dest]"
    exit 1
  fi

  sudo -S installer -pkg "$1" -target "${2:/Applications}"
}

function dx::completed {
  echo "$1 installation completed"
}
