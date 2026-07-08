# Windows Quickstart

This guide describes a basic Windows development setup for G0DM0D3-DW.

## Target Environment

- Windows 11
- PowerShell 7
- Git
- GitHub CLI
- Node.js LTS
- Docker Desktop optional

## Clone Repository

Run:

git clone https://github.com/Steve72HH/dw-g0dm0d3.git
cd dw-g0dm0d3

## Install Dependencies

Run:

npm install

## Environment File

Copy the example environment file:

Copy-Item .env.example .env

Then edit .env and add only the provider keys you need.

Never commit .env.

## Start Development Server

Check available scripts first:

npm run

Then start the development server using the matching project script, usually:

npm run dev

## Useful Checks

Run:

git status --short
npm audit
npm run lint

Some scripts may not exist yet depending on upstream state. Check package.json before assuming a command exists.

## PowerShell Notes

- Use PowerShell 7 where possible.
- Keep secrets out of command history.
- Do not run unknown scripts with elevated privileges.
- Use Git branches for every logical change.
