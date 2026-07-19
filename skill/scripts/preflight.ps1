param(
    [Parameter(Mandatory = $true)]
    [string]$PackagePath,
    [string]$ChromePluginRoot = "",
    [ValidateSet("standard", "privileged")]
    [string]$DiagnosticMode = "standard"
)

$ErrorActionPreference = "Stop"

function New-CheckResult {
    param([string]$Name, [string]$Status, [string]$Detail)
    [pscustomobject]@{ name = $Name; status = $Status; detail = $Detail }
}

$checks = [System.Collections.Generic.List[object]]::new()
$resolvedPackage = $null

try {
    $resolvedPackage = (Resolve-Path -LiteralPath $PackagePath).Path
    $checks.Add((New-CheckResult "package_path" "pass" $resolvedPackage))
} catch {
    $checks.Add((New-CheckResult "package_path" "fail" $_.Exception.Message))
}

$manifest = $null
if ($resolvedPackage) {
    $manifestPath = Join-Path $resolvedPackage "publishing-task.json"
    try {
        $manifest = Get-Content -Raw -Encoding UTF8 -LiteralPath $manifestPath | ConvertFrom-Json
        $checks.Add((New-CheckResult "manifest" "pass" $manifestPath))
    } catch {
        $checks.Add((New-CheckResult "manifest" "fail" $_.Exception.Message))
    }
}

if ($manifest -and $resolvedPackage) {
    $required = @("title.txt", $manifest.description_file, $manifest.tags_file) + @($manifest.image_files)
    $missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $resolvedPackage $_) -PathType Leaf) })
    if ($missing.Count -eq 0) {
        $checks.Add((New-CheckResult "required_files" "pass" ("{0} files present" -f $required.Count)))
    } else {
        $checks.Add((New-CheckResult "required_files" "fail" ("Missing: " + ($missing -join ", "))))
    }

    try {
        Add-Type -AssemblyName System.Drawing
        $badImages = [System.Collections.Generic.List[string]]::new()
        foreach ($imageName in @($manifest.image_files)) {
            $imagePath = Join-Path $resolvedPackage $imageName
            if (-not (Test-Path -LiteralPath $imagePath -PathType Leaf)) { continue }
            $image = [System.Drawing.Image]::FromFile($imagePath)
            try {
                if ($image.Width -ne 1080 -or $image.Height -ne 1440 -or [System.IO.Path]::GetExtension($imagePath).ToLowerInvariant() -ne ".png") {
                    $badImages.Add(("{0}:{1}x{2}" -f $imageName, $image.Width, $image.Height))
                }
            } finally {
                $image.Dispose()
            }
        }
        if ($badImages.Count -eq 0) {
            $checks.Add((New-CheckResult "image_spec" "pass" "All manifest images are 1080x1440 PNG"))
        } else {
            $checks.Add((New-CheckResult "image_spec" "fail" ($badImages -join ", ")))
        }
    } catch {
        $checks.Add((New-CheckResult "image_spec" "fail" $_.Exception.Message))
    }
}

if (-not $ChromePluginRoot) {
    $cacheRoot = Join-Path $env:USERPROFILE ".codex\plugins\cache\openai-bundled\chrome"
    if (Test-Path -LiteralPath $cacheRoot) {
        $candidate = Get-ChildItem -LiteralPath $cacheRoot -Directory |
            Where-Object { $_.Name -ne "latest" } |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1
        if ($candidate) { $ChromePluginRoot = $candidate.FullName }
    }
}

if (-not $ChromePluginRoot -or -not (Test-Path -LiteralPath $ChromePluginRoot -PathType Container)) {
    $checks.Add((New-CheckResult "chrome_plugin" "fail" "Bundled Chrome plugin directory was not found"))
} else {
    $checks.Add((New-CheckResult "chrome_plugin" "pass" $ChromePluginRoot))
    $diagnostics = @(
        @{ name = "chrome_running"; script = "chrome-is-running.js" },
        @{ name = "chrome_extension"; script = "check-extension-installed.js" },
        @{ name = "native_host"; script = "check-native-host-manifest.js" }
    )
    foreach ($diagnostic in $diagnostics) {
        $scriptPath = Join-Path $ChromePluginRoot (Join-Path "scripts" $diagnostic.script)
        try {
            $previousErrorAction = $ErrorActionPreference
            $ErrorActionPreference = "Continue"
            $output = & node $scriptPath --json 2>&1 | Out-String
            $exitCode = $LASTEXITCODE
            $ErrorActionPreference = $previousErrorAction
            if ($exitCode -eq 0) {
                $checks.Add((New-CheckResult $diagnostic.name "pass" ($output.Trim())))
            } elseif ($DiagnosticMode -eq "standard") {
                $checks.Add((New-CheckResult $diagnostic.name "unknown_due_to_access" ($output.Trim())))
            } else {
                $checks.Add((New-CheckResult $diagnostic.name "fail" ($output.Trim())))
            }
        } catch {
            $ErrorActionPreference = "Stop"
            $checks.Add((New-CheckResult $diagnostic.name "fail" $_.Exception.Message))
        }
    }
}

$failed = @($checks | Where-Object status -eq "fail")
$unknown = @($checks | Where-Object status -eq "unknown_due_to_access")
$verdict = if ($failed.Count -gt 0) { "blocked" } elseif ($unknown.Count -gt 0) { "needs_privileged_diagnostics" } else { "ready" }

[pscustomobject]@{
    schema_version = 1
    verdict = $verdict
    package_path = $resolvedPackage
    checks = $checks
} | ConvertTo-Json -Depth 8

if ($verdict -eq "blocked") { exit 2 }
if ($verdict -eq "needs_privileged_diagnostics") { exit 3 }
exit 0
