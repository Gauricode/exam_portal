<#
Usage: 
  powershell -ExecutionPolicy Bypass -File .\scripts\inspect_war.ps1

This script finds the first WAR under `target/`, extracts it to a temp folder,
and lists the contents of `WEB-INF/lib` so you can verify which dependency JARs
were packaged into the WAR.
#>

[CmdletBinding()]
param(
    [string]$projectRoot = (Get-Location).Path
)

try {
    $targetDir = Join-Path $projectRoot 'target'
    $war = Get-ChildItem -Path $targetDir -Filter *.war -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $war) {
        Write-Error "No WAR file found in $targetDir. Run 'mvn clean package' first."
        exit 1
    }

    $extractDir = Join-Path $env:TEMP ("war_extracted_{0}" -f ([System.Guid]::NewGuid().ToString()))
    New-Item -ItemType Directory -Path $extractDir | Out-Null

    Write-Host "Extracting $($war.FullName) to $extractDir"
    Expand-Archive -LiteralPath $war.FullName -DestinationPath $extractDir -Force

    $libDir = Join-Path $extractDir 'WEB-INF\lib'
    if (Test-Path $libDir) {
        Write-Host 'Libraries packaged in WEB-INF/lib:' -ForegroundColor Cyan
        Get-ChildItem -Path $libDir | ForEach-Object { Write-Host " - $($_.Name)" }
    } else {
        Write-Host 'No WEB-INF/lib directory found inside the WAR.' -ForegroundColor Yellow
    }

    Write-Host "Extraction folder: $extractDir"
    Write-Host 'You can remove the folder when finished.'
} catch {
    Write-Error "Error inspecting WAR: $_"
    exit 2
}
