# Traefik Deployment Notes

This document describes a self-hosted deployment approach for G0DM0D3-DW behind Traefik.

## Target Setup

- Docker Compose or Docker Swarm
- Traefik as reverse proxy
- HTTPS via Let's Encrypt
- External Docker network, for example `proxy`
- Secrets stored in `.env`, not committed to Git

## Example Host

```text
godmode.digital-world.dev
```

## Required DNS

Create an A record:

```text
godmode.digital-world.dev -> 88.99.141.175
```

Do not create an AAAA record unless the service is actually reachable via IPv6.

## Required Docker Network

Create the external proxy network once:

```bash
docker network create proxy
```

## Environment File

Copy the example file:

```bash
cp .env.example .env
```

Then edit `.env` and add the provider keys you actually want to use.

Never commit `.env`.

## Build Image

From the repository root:

```bash
docker build -t g0dm0d3-dw:latest .
```

## Start With Traefik Compose

```bash
docker compose -f docker-compose.dw-traefik.yml up -d
```

## Check Status

```bash
docker ps
docker logs --tail=100 g0dm0d3-dw
docker network inspect proxy
```

## Traefik Checks

If HTTPS does not work, check:

```bash
docker logs --tail=200 traefik | grep -i "g0dm0d3\|godmode\|certificate\|resolver\|error"
```

Also verify DNS:

```bash
dig +short godmode.digital-world.dev
```

Expected result:

```text
88.99.141.175
```

## Security Notes

- Keep API keys out of images and repositories.
- Prefer private deployments for research environments.
- Enable authentication before exposing the service publicly.
- Review upstream behavior before enabling public access.
- Use provider-side spending limits where possible.
- Do not expose internal API endpoints without authentication.
