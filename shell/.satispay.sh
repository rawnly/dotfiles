#!/bin/bash

export SLACK_USER_ID="U067RQQ94NM"

tpstart() {
	if [[ "$1" != https://satispay.tpondemand.com/entity/* ]]; then
		echo "Invalid url: $1"
		return 1
	fi
	feature_name="$(echo "$1" | cut -d/ -f5 | sed s/-/_/g)"
	git checkout -b "feature/$feature_name" develop
}

tpopen() {
	if [[ ! -d ".git" ]]; then
		echo "Not a git repository"
		return 1
	fi

	branch_name="$(git branch --show-current)"
	branch_type="$(echo "$branch_name" | cut -d/ -f1)"

	if [[ "$branch_type" != "feature" ]]; then
		echo "Not a feature branch"
		return 1
	fi

	feature_name="$(echo "$branch_name" | cut -d/ -f2)"
	open "https://satispay.tpondemand.com/entity/$feature_name"
}

tplink() {
	if [[ ! -d ".git" ]]; then
		echo "Not a git repository"
		return 1
	fi

	branch_name="$(git branch --show-current)"
	branch_type="$(echo "$branch_name" | cut -d/ -f1)"

	if [[ "$branch_type" != "feature" ]]; then
		echo "Not a feature branch"
		return 1
	fi

	feature_name="$(echo "$branch_name" | cut -d/ -f2)"
	echo "https://satispay.tpondemand.com/entity/$feature_name"
}

current_repository() {
	pwd | awk -F/ '{print $NF}'
}

current_branch() {
	git branch --show-current
}
