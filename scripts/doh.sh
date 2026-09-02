#!/usr/bin/env bash

# doh.sh
#
# Query DNS records using DNS-over-HTTPS (DoH).
#
# Usage:
#   ./doh.sh <domain> [record_type]
#
# Examples:
#   ./doh.sh google.com
#   ./doh.sh google.com A
#   ./doh.sh google.com AAAA
#   ./doh.sh gmail.com MX
#   ./doh.sh google.com TXT
#
# Dependencies:
#   curl
#   jq
#
# DoH provider:
#   Google Public DNS
#   https://dns.google/

DOMAIN="$1"
TYPE="${2:-A}"

if [[ -z "$DOMAIN" ]]; then
    echo "Usage: $0 <domain> [type]"
    echo "Example:"
    echo "  $0 example.com"
    echo "  $0 example.com AAAA"
    echo "  $0 example.com MX"
    exit 1
fi

curl -fsS \
    "https://dns.google/resolve?name=${DOMAIN}&type=${TYPE}" \
    | jq -r '
        if .Status != 0 then
            "DNS query failed, status=\(.Status)"
        elif (.Answer // [] | length) == 0 then
            "No records found"
        else
            .Answer[] | "\(.name)\t\(.TTL)\t\(.type)\t\(.data)"
        end
    '
