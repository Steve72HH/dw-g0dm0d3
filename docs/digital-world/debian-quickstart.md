# Debian Quickstart

This guide describes a basic Debian server setup for G0DM0D3-DW.

## Target Environment

- Debian 12 or newer
- Git
- Node.js LTS
- npm
- Docker optional
- Traefik optional for production-style hosting

## Install Base Packages

Run:

sudo apt update
sudo apt install -y git curl ca-certificates gnupg

## Install Node.js

Use the Node.js LTS version recommended for your environment.

After installation, verify:

node --version
npm --version

## Clone Repository

Run:

git clone https://github.com/Steve72HH/dw-g0dm0d3.git
cd dw-g0dm0d3

## Install Dependencies

Run:

npm install

## Environment File

Create a local environment file:

cp .env.example .env

Then edit .env and add only the provider keys you need.

Never commit .env.

## Start Development Server

Check available scripts first:

npm run

Then start the development server using the matching project script, usually:

npm run dev

## Docker Build Test

Build the image:

docker build -t g0dm0d3-dw:latest .

## Operational Notes

- Keep API keys out of Git.
- Use a reverse proxy for TLS.
- Prefer private or VPN-only access for research instances.
- Add provider spending limits before exposing any deployment.
- Review logs before entering sensitive prompts.
