# Runtime Audit

This document describes the basic runtime audit process for G0DM0D3-DW.

## Purpose

The runtime audit checks whether the local development environment, package metadata, environment template, and optional Docker Compose configuration are plausible.

## Basic Check

Run from the repository root:

pwsh ./tools/runtime-audit.ps1

## Optional Docker Compose Check

Create a local environment file first:

Copy-Item .env.example .env

Then run:

pwsh ./tools/runtime-audit.ps1 -CheckDockerCompose

## Optional Full Check

Run:

pwsh ./tools/runtime-audit.ps1 -RunNpmInstall -RunBuild

## Optional Full Check With Docker Compose

Run:

pwsh ./tools/runtime-audit.ps1 -RunNpmInstall -RunBuild -CheckDockerCompose

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
- local .env presence
- optional Docker Compose syntax for docker-compose.dw-traefik.yml

## Recommended Use

Run this script before larger merges, deployment changes, Docker changes, or dependency updates.

## Notes

- The default run does not install dependencies.
- The default run does not build the project.
- The default run does not validate Docker Compose.
- Docker Compose validation expects a local .env file because docker-compose.dw-traefik.yml references env_file .env.
- Use optional switches only when you intentionally want heavier checks.
