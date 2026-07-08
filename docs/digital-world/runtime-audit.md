# Runtime Audit

This document describes the basic runtime audit process for G0DM0D3-DW.

## Purpose

The runtime audit checks whether the local development environment, package metadata, environment template, and Docker Compose configuration are plausible.

## PowerShell Audit Script

Run from the repository root:

pwsh ./tools/runtime-audit.ps1

Optional full check:

pwsh ./tools/runtime-audit.ps1 -RunNpmInstall -RunBuild

## What It Checks

- current Git branch
- clean or dirty working tree
- Node.js version
- npm version
- Docker version
- important project files
- package.json metadata
- package.json scripts
- expected .env.example variables
- Docker Compose syntax for docker-compose.dw-traefik.yml

## Recommended Use

Run this script before larger merges, deployment changes, Docker changes, or dependency updates.

## Notes

- The default run does not install dependencies.
- The default run does not build the project.
- Use optional switches when you intentionally want heavier checks.
