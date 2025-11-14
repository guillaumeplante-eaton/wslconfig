#╔════════════════════════════════════════════════════════════════════════════════╗
#║                                                                                ║
#║   BackupWslConfig.ps1                                                          ║
#║                                                                                ║
#╟────────────────────────────────────────────────────────────────────────────────╢
#║   Written by Guillaume Plante <guillaumeplante@eaton.com>                      ║
#║                                                                                ║
#║   Copyright (C) 2025 Eaton Corporation. All rights reserved                    ║
#║   This file and its contents are proprietary and confidential.                 ║
#║   Unauthorized copying or distribution is prohibited.                          ║
#╚════════════════════════════════════════════════════════════════════════════════╝


function Invoke-BackupWslConfig {
    param()
    # Helper function for colored logging
    function Write-Log {
        param(
            [string]$Message,
            [string]$Type = "INFO"
        )
        switch ($Type) {
            "INFO" { Write-Host "[INFO] $Message" -ForegroundColor Cyan }
            "SUCCESS" { Write-Host "[OK]   $Message" -ForegroundColor Green }
            "ERROR" { Write-Host "[ERR]  $Message" -ForegroundColor Red }
            "WARN" { Write-Host "[WARN] $Message" -ForegroundColor Yellow }
            default { Write-Host "[LOG]  $Message" -ForegroundColor White }
        }
    }

    $Path = "{0}{1}\.wslconfig" -f  $ENV:HOMEDRIVE, $ENV:HOMEPATH


    $NowString = Get-date -UFormat "%d%H%M%S"
    $RootPath = (Resolve-Path -Path "$PSScriptRoot\..").Path
    $BackupRootPath = Join-Path "$RootPath" "backup"
    $BackupPath = Join-Path "$BackupRootPath" "$NowString"

    Write-Log "[Invoke-BackupWslConfig] RootPath   $RootPath"
    

    Write-Log "Detected Windows 11 ($osVersion)."


    if (!(Test-Path "$BackupPath" -PathType Container)) {
        Write-Log "Creating backupPath $BackupPath"
        New-Item -Path "$BackupPath" -ItemType Directory -Force -ErrorAction Ignore | Out-Null
    }

    if (!(Test-Path "$FilePath" -PathType Leaf)) {
        New-Item -Path "$FilePath" -ItemType File -Force -ErrorAction Ignore | Out-Null
    }


    Write-Log "Detected Windows 11 ($osVersion)." "SUCCESS"

    try {
        Write-Log "Clearing Windows Search History (local profile)..." "INFO"
        $searchHistPath = "$env:LOCALAPPDATA\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\AppSearch\Indexed\"
        if (Test-Path $searchHistPath) {
            Remove-Item "$searchHistPath*" -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$False
            Write-Log "Cleared Windows Search history." "SUCCESS"
        } else {
            Write-Log "No local search history found for this user." "WARN"
        }
    } catch {
        Write-Log "Failed to clear Windows Search history: $_" "ERROR"
    }

}
