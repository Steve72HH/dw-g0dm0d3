# Provider Security Notes

This document describes operational security notes for using external AI providers with G0DM0D3-DW.

## API Key Handling

- Never commit API keys to Git.
- Store keys in .env or a proper secret manager.
- Use separate API keys for development and production.
- Rotate keys if they were exposed.
- Restrict keys where the provider supports it.

## Cost Control

Before exposing a deployment:

- configure provider spending limits
- monitor usage
- restrict access to trusted users
- add rate limits
- avoid public unauthenticated endpoints

## Provider Awareness

Different providers may have different policies, logging behavior, pricing, model availability, context limits, and safety behavior.

Document which providers are enabled in each deployment.

## Recommended Deployment Defaults

- telemetry disabled
- authentication enabled
- .env excluded from Git
- provider usage documented
- reverse proxy logs reviewed
- rate limiting enabled
- private or VPN-only access for research instances

## Incident Checklist

If a key is exposed:

1. Revoke the key immediately.
2. Create a new key.
3. Review provider usage logs.
4. Check Git history.
5. Remove secrets from local files.
6. Audit deployment logs.
7. Document the incident.
