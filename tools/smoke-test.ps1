param(
    [string]$BaseUrl = "http://localhost:7860",
    [string]$ApiKey = ""
)

$ErrorActionPreference = "Stop"

$passed = 0
$failed = 0

$headers = @{}
if (-not [string]::IsNullOrWhiteSpace($ApiKey)) {
    $headers["Authorization"] = "Bearer $ApiKey"
}

function Write-Ok {
    param([string]$Message)

    Write-Host "[OK]   $Message" -ForegroundColor Green
    $script:passed++
}

function Write-Fail {
    param(
        [string]$Message,
        [object]$ErrorObject
    )

    Write-Host "[FAIL] $Message" -ForegroundColor Red
    if ($ErrorObject) {
        Write-Host "       $ErrorObject" -ForegroundColor DarkRed
    }
    $script:failed++
}

function Test-Get {
    param(
        [string]$Name,
        [string]$Path
    )

    try {
        $request = @{
            Uri    = "$BaseUrl$Path"
            Method = "GET"
        }

        if ($script:headers.Count -gt 0) {
            $request.Headers = $script:headers
        }

        $result = Invoke-RestMethod @request
        Write-Ok "$Name GET $Path"
        return $result
    }
    catch {
        Write-Fail "$Name GET $Path" $_.Exception.Message
        return $null
    }
}

function Test-Post {
    param(
        [string]$Name,
        [string]$Path,
        [hashtable]$Body
    )

    try {
        $json = $Body | ConvertTo-Json -Depth 10

        $request = @{
            Uri         = "$BaseUrl$Path"
            Method      = "POST"
            ContentType = "application/json"
            Body        = $json
        }

        if ($script:headers.Count -gt 0) {
            $request.Headers = $script:headers
        }

        $result = Invoke-RestMethod @request
        Write-Ok "$Name POST $Path"
        return $result
    }
    catch {
        Write-Fail "$Name POST $Path" $_.Exception.Message
        return $null
    }
}

Write-Host ""
Write-Host "G0DM0D3 Runtime Smoke Test" -ForegroundColor Cyan
Write-Host "Base URL: $BaseUrl" -ForegroundColor Cyan

if ($ApiKey) {
    Write-Host "Auth: Bearer token provided" -ForegroundColor Cyan
}
else {
    Write-Host "Auth: none" -ForegroundColor Yellow
}

Write-Host ""

$health = Test-Get -Name "Health" -Path "/v1/health"
$info   = Test-Get -Name "Info"   -Path "/v1/info"
$models = Test-Get -Name "Models" -Path "/v1/models"
$tier   = Test-Get -Name "Tier"   -Path "/v1/tier"

if ($health -and $health.status -eq "ok") {
    Write-Ok "Health status is ok"
}
elseif ($health) {
    Write-Fail "Health status is not ok" ($health | ConvertTo-Json -Depth 5)
}

if ($info -and $info.version) {
    Write-Ok "Info version: $($info.version)"
}
elseif ($info) {
    Write-Fail "Info endpoint returned no version" ($info | ConvertTo-Json -Depth 5)
}

if ($models -and $models.data -and $models.data.Count -gt 0) {
    Write-Ok "Models returned: $($models.data.Count)"
}
elseif ($models) {
    Write-Fail "Models endpoint returned empty model list" ($models | ConvertTo-Json -Depth 5)
}

if ($tier -and $tier.tier) {
    Write-Ok "Tier detected: $($tier.tier)"
}
elseif ($tier) {
    Write-Fail "Tier endpoint returned no tier" ($tier | ConvertTo-Json -Depth 5)
}

$autotune = Test-Post `
    -Name "AutoTune" `
    -Path "/v1/autotune/analyze" `
    -Body @{
        message  = "Erkläre mir Docker Volumes technisch, aber verständlich."
        strategy = "adaptive"
    }

if ($autotune -and $autotune.params -and $autotune.detected_context) {
    Write-Ok "AutoTune detected context: $($autotune.detected_context)"

    if ($autotune.detected_context -eq "chaotic") {
        Write-Fail "AutoTune incorrectly detected Docker prompt as chaotic" ($autotune | ConvertTo-Json -Depth 10)
    }
}
elseif ($autotune) {
    Write-Fail "AutoTune response missing expected fields" ($autotune | ConvertTo-Json -Depth 5)
}

$parseltongue = Test-Post `
    -Name "Parseltongue Encode" `
    -Path "/v1/parseltongue/encode" `
    -Body @{
        text      = "This is a test message about hacking and malware."
        technique = "leetspeak"
        intensity = "medium"
    }

if ($parseltongue) {
    Write-Ok "Parseltongue endpoint responded"
}

Write-Host ""
Write-Host "Summary" -ForegroundColor Cyan
Write-Host "Passed: $passed" -ForegroundColor Green

if ($failed -gt 0) {
    Write-Host "Failed: $failed" -ForegroundColor Red
    exit 1
}

Write-Host "Failed: 0" -ForegroundColor Green
exit 0
