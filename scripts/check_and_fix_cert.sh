#!/usr/bin/env bash
set -euo pipefail

CERT_PATH="${1:-certs/server.crt}"
KEY_PATH="${2:-certs/server.key}"
DAYS_THRESHOLD=0

if [[ ! -f "$CERT_PATH" ]]; then
    echo "Certificate not found. Generating new one..."
    NEED_RENEW=1
else
    echo "Checking certificate validity..."

    if ! openssl x509 -checkend $((DAYS_THRESHOLD * 86400)) -noout -in "$CERT_PATH"; then
        echo "Certificate expired or invalid."
        NEED_RENEW=1
    else
        echo "Certificate is valid."
        NEED_RENEW=0
    fi
fi

if [[ "$NEED_RENEW" -eq 1 ]]; then
    echo "Generating new self-signed certificate..."

    mkdir -p certs

    openssl req -x509 -nodes -newkey rsa:2048 \
        -keyout "$KEY_PATH" \
        -out "$CERT_PATH" \
        -days 365 \
        -subj "/C=SK/ST=Bratislava/L=Bratislava/O=DevOpsDemo/OU=IT/CN=localhost"

    echo "New certificate generated."
fi

echo "Done."
