# Certificate Validity Check and Auto-Renew Demo

Simple automation script detecting invalid or expired TLS certificates
and regenerating them if necessary.

## Features

- Expiration detection via OpenSSL
- Self-signed certificate generation
- Idempotent behavior
- CI/CD ready
- Strict Bash mode enabled

## Usage

    chmod +x scripts/check_and_fix_cert.sh
    ./scripts/check_and_fix_cert.sh

## Use Case

Useful for:
- Lab environments
- Internal services
- CI pipelines
- Certificate lifecycle automation demos

## Security Note

For production environments use ACME / cert-manager
instead of self-signed certificates.
