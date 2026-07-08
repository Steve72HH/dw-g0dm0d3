# Privacy Model

G0DM0D3-DW is intended to be privacy-first and local-first where possible.

## Principles

- No telemetry by default.
- API keys remain local to the deployment.
- Prefer local models via Ollama when practical.
- Make provider usage explicit.
- Document which requests leave the local system.

## Admin Notes

Before production use, review:

- environment variables
- server logs
- reverse proxy access logs
- provider API settings
- browser storage behavior
