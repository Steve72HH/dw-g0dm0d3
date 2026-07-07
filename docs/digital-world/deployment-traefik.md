# Traefik Deployment Notes

This document describes a planned self-hosted deployment for G0DM0D3-DW behind Traefik.

## Target Setup

- Docker Compose or Docker Swarm
- Traefik as reverse proxy
- HTTPS via Let's Encrypt
- External Docker network, for example proxy
- Secrets stored in .env, not committed to Git

## Example Host

godmode.digital-world.dev

## Notes

- Keep API keys out of images and repositories.
- Prefer private deployments for research environments.
- Enable rate limits and authentication before exposing the service publicly.
- Review upstream behavior before enabling public access.
