#!/usr/bin/env bash
#
STATUS="$(curl https://www.githubstatus.com/api/v2/summary.json | jq '.components[0].status' | sed 's,",,g')"

if [[ $STATUS = "operational" ]]; then
	STATUS="🟢 Operational"
elif [[ $STATUS = "partial_outage" ]]; then
	STATUS="🟡 Partial Outage"
else
	STATUS="🔴 $STATUS"
fi

echo "$STATUS"
