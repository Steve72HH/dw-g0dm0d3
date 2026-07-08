param(
    [switch]$RunNpmInstall,
    [switch]$RunBuild
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host "============================================================"
    Write-Host $Title
    Write-Host "============================================================"
}

function Test-CommandExists {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

Write-Section "G0DM0D3-DW Runtime Audit"

Write-Host "Working Directory: $(Get-Location)"

Write-Section "Git Status"

if (Test-CommandExists git) {
    git branch --show-current
    git status --short
}
else {
    Write-Warning "git was not found."
}

Write-Section "Tool Versions"

$tools = @("node", "npm", "docker", "git")

foreach ($tool in $tools) {
    if (Test-CommandExists $tool) {
        Write-Host "$tool found:"
        & $tool --version
    }
    else {
        Write-Warning "$tool was not found."
    }
}

Write-Section "Important Files"

$files = @(
    "package.json",
    "package-lock.json",
    "Dockerfile",
    "docker-compose.yml",
    "docker-compose.dw-traefik.yml",
    ".env.example",
    "next.config.js",
    "tsconfig.json"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "[OK] $file"
    }
    else {
        Write-Warning "[MISSING] $file"
    }
}

Write-Section "Package Metadata"

if (Test-Path "package.json") {
    $package = Get-Content "package.json" -Raw | ConvertFrom-Json

    Write-Host "Name:    $($package.name)"
    Write-Host "Version: $($package.version)"
    Write-Host "Private: $($package.private)"

    Write-Host ""
    Write-Host "Scripts:"
    if ($package.scripts) {
        $package.scripts.PSObject.Properties | ForEach-Object {
            Write-Host "  $($_.Name): $($_.Value)"
        }
    }
    else {
        Write-Warning "No scripts found in package.json."
    }
}
else {
    Write-Warning "package.json not found."
}

Write-Section "Environment Template Check"

if (Test-Path ".env.example") {
    $envExample = Get-Content ".env.example"

    $expectedVars = @(
        "NODE_ENV",
        "PORT",
        "API_PORT",
        "NEXT_PUBLIC_APP_NAME",
        "NEXT_PUBLIC_APP_URL",
        "OPENROUTER_API_KEY",
        "OPENAI_API_KEY",
        "ANTHROPIC_API_KEY",
        "GOOGLE_API_KEY",
        "OLLAMA_BASE_URL",
        "DW_TELEMETRY_ENABLED",
        "DW_LOCAL_FIRST",
        "API_AUTH_TOKEN",
        "RATE_LIMIT_WINDOW_MS",
        "RATE_LIMIT_MAX_REQUESTS"
    )

    foreach ($var in $expectedVars) {
        if ($envExample -match "^$var=") {
            Write-Host "[OK] $var"
        }
        else {
            Write-Warning "[MISSING] $var"
        }
    }
}

Write-Section "Docker Compose Config Check"

if ((Test-CommandExists docker) -and (Test-Path "docker-compose.dw-traefik.yml")) {
    docker compose -f docker-compose.dw-traefik.yml config | Out-Null
    Write-Host "[OK] docker-compose.dw-traefik.yml is syntactically valid."
}
else {
    Write-Warning "Docker unavailable or docker-compose.dw-traefik.yml missing."
}

if ($RunNpmInstall) {
    Write-Section "npm install"
    npm install
}
else {
    Write-Host ""
    Write-Host "Skipping npm install. Use -RunNpmInstall to execute it."
}

if ($RunBuild) {
    Write-Section "npm build"
    npm run build
}
else {
    Write-Host ""
    Write-Host "Skipping npm run build. Use -RunBuild to execute it."
}

Write-Section "Audit Complete"
