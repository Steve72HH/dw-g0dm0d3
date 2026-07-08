# Digital World Test Plan

This document defines basic checks before merging larger changes into G0DM0D3-DW.

## Git Checks

- git status --short is clean
- branch name matches the change
- commits are small and understandable
- no .env file is staged
- no API keys or secrets are present

## Dependency Checks

Run:

npm install
npm audit

If available, also run:

npm run lint
npm run build

## Docker Checks

Run:

docker build -t g0dm0d3-dw:latest .

If using Traefik compose:

docker compose -f docker-compose.dw-traefik.yml config

## Documentation Checks

- README links work
- Digital World docs are discoverable
- deployment docs do not contain real secrets
- hostnames and IP addresses are intentional

## Security Checks

- .env is not committed
- API_AUTH_TOKEN is documented
- public exposure requires authentication
- provider cost limits are configured
- no internal service is exposed unintentionally

## Manual Smoke Test

Before release, verify:

1. app starts
2. UI loads
3. provider configuration is readable
4. local or external model call works
5. no secret appears in browser console
6. no secret appears in server logs
