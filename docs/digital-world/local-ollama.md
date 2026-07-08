# Local Ollama Notes

G0DM0D3-DW should support local-first workflows wherever practical.

## Goal

Use local models for testing, private experimentation, offline workflows, and cost control.

## Example Local Endpoint

```text
http://localhost:11434
```

## Recommended Test Models

Examples for local testing:

- llama3.1
- qwen2.5-coder
- mistral
- deepseek-coder
- phi
- gemma

Model availability depends on the local Ollama installation.

## Basic Ollama Checks

```bash
ollama list
ollama ps
curl http://localhost:11434/api/tags
```

## Docker Host Notes

If G0DM0D3-DW runs inside Docker and Ollama runs on the host, the container must be able to reach the Ollama endpoint.

Possible approaches:

- run Ollama on the same Docker network
- expose Ollama only to trusted internal networks
- use host gateway routing where supported
- avoid exposing Ollama directly to the public internet

## Security Notes

- Do not expose Ollama publicly without authentication and network restrictions.
- Treat local model prompts and outputs as sensitive operational data.
- Review logs before using sensitive input.
- Prefer private networks or VPN access.
