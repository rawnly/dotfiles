#! /bin/bash
function nvo() {
	fd "$1" | fzf --bind 'enter:become(nvim {})'
}

function toggle-tmux-popup() {
	session_name="scratchpad"

	if [ "$(tmux display-message -p -F "#{session_name}")" = "$session_name" ]; then
		tmux detach-client
	else
		tmux display-popup -d '#{pane_current_path}' -xC -yC -w80% -h75% -E "tmux new-session -A -s $session_name"
	fi
}

function scratchpad() {
	file_name="$(date +%s)_${1}"

	if [ -z "$1" ]; then
		file_name="$(date +%s)"
	fi

	echo "#! /usr/bin/env bash\n" >"/tmp/${file_name}.sh"

	nvim "/tmp/${file_name}.sh"

	source "/tmp/${file_name}.sh"

	if [ -z "$1" ]; then
		rm "/tmp/${file_name}.sh"
	fi

	echo "Script loaded!"
}

function private-mode() {
	echo "WARNING: Entering private mode"

	unset HISTFILE
	HISTFILE=/tmp/.history

	# clean old history
	rm $HISTFILE 2>/dev/null
}

function scripts() {
	jq .scripts <package.json
}

function better_cat() {
	filename=$(basename "$@")
	extension="${filename##*.}"

	if [[ $extension = "md" ]]; then
		glow "$@"
	else
		bat --theme=TwoDark --style=header,grid,snip,changes "$@"
	fi
}

function identity() {
	case "$@" in
	"aquacloud" | "aqua")
		git config user.name federico.vitale
		git config user.email federico.vitale@aquacloud.it
		;;
	*)
		git config user.name rawnly
		git config user.email rawnly@users.noreply.github.com
		;;
	esac

	echo "switched to @$(git config user.name)"
}

function qrcode() {
	local input="$*"
	[ -z "$input" ] && local input="@/dev/stdin"
	curl --silent -d "$input" https://qrcode.show
}

function mdc() {
	mkdir -p "$1" && cd $_
}

# downfor.cloud appears to be down...
# function isDown() {
# 	curl "https://api-prod.downfor.cloud/httpcheck/$1" \
# 		--silent \
# 		--fail \
# 		-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0' \
# 		-H 'Accept: */*' \
# 		-H 'Accept-Language: en' \
# 		-H 'Referer: https://downforeveryoneorjustme.com/' \
# 		-H 'Origin: https://downforeveryoneorjustme.com' \
# 		-H 'DNT: 1' \
# 		-H 'Connection: keep-alive' \
# 		--compressed | jq ".isDown"
# }

function branchName() {
	echo "$(g branch | grep '*' | sed 's/*//g' | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g")"
}

function featureName() {
	"$(branchName | awk -F/ '{print $2}')"
}

function get-module() {
	if [ -z "$1" ]; then

		echo "No module name specified!"
		echo "Usage: get-module <module_name>"

		return
	fi

	open "https://npmjs.com/$1"
}

function trash {
	if [ -z "$1" ]; then
		echo "No files."
		return 0
	fi

	TRASH="$HOME/.Trash"

	mv "$1" "$TRASH/$1"
}

function portPid {
	if [ -z "$1" ]; then
		echo "No port specified"
		return 0
	fi

	pid="$(lsof -i "tcp:$1" | awk '{print $2}' | grep -E '\d')"

	echo "$pid"
}

function transfer {
	if [ $# -eq 0 ]; then
		echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
		return 1
	fi

	tmpfile=$(mktemp -t transferXXX)

	if tty -s; then
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >>$tmpfile
	else
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >>$tmpfile
	fi

	cat $tmpfile
	rm -f $tmpfile
}

# Determine size of a file or total size of a directory
function size-of() {
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$*" ]]; then
		du $arg -- "$*"
	else
		du $arg .[^.]* ./*
	fi
}

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Compare original and gzipped file size
function gz() {
	local origsize=$(wc -c <"$1")
	local gzipsize=$(gzip -c "$1" | wc -c)
	local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
	printf "orig: %d bytes\n" "$origsize"
	printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

function findPackages() {
	SCOPE=".dependencies"

	if [[ "$2" == "-D" ]]; then
		SCOPE=".devDependencies"
	fi

	packages=$(cat "package.json" | jq $SCOPE | grep "$1" | sed s/\"//g | awk -F: '{printf $1}' | xargs)

	echo "$packages"
}
