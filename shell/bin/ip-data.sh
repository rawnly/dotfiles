#!/bin/bash

# IP="$(curl "https://api.ipify.org?format=json" | jq -r .ip)"
# GEOIP="$(curl --silent "https://geoip.pw/api/v2/lookup/$IP")"

# echo "$IP"

ip=$(curl --silent https://api.ipify.org?format=json | jq -r .ip)
geoip=$(curl --silent https://geoip.pw/api/v2/lookup/$ip | jq)

echo "$geoip" | jq -r .asn_org
