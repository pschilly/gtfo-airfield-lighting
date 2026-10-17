# ============================================================================
#  GTFO Airfield Lighting Installer
#  Downloads and installs the latest GTFO Airfield Lighting mod from GitHub
#  directly into your DCS Saved Games Mods\tech folder with hash verification.
#
#  Repository: https://github.com/pschilly/gtfo-airfield-lighting
# ============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "GTFO Airfield Lighting Installer"

Write-Host ""
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host "      _____ _______ ______ ____                               " -ForegroundColor Cyan
Write-Host "     / ____|__   __|  ____/ __ \                              " -ForegroundColor Cyan
Write-Host "    | |  __   | |  | |__ | |  | |                             " -ForegroundColor Cyan
Write-Host "    | | |_ |  | |  |  __|| |  | |                             " -ForegroundColor Cyan
Write-Host "    | |__| |  | |  | |   | |__| |                             " -ForegroundColor Cyan
Write-Host "     \_____|  |_|  |_|    \____/                              " -ForegroundColor Cyan
Write-Host ""
Write-Host "             AIRFIELD LIGHTING AUTO-INSTALLER                 " -ForegroundColor Yellow
Write-Host "      https://github.com/pschilly/gtfo-airfield-lighting      " -ForegroundColor DarkGray
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
#  STEP 1: Detect DCS Saved Games Mods\tech path
# ============================================================================

$userProfile = $env:USERPROFILE
$dcsPath = $null

$standardTech = Join-Path $userProfile "Saved Games\DCS\Mods\tech"
$openBetaTech = Join-Path $userProfile "Saved Games\DCS.openbeta\Mods\tech"
$standardBase = Join-Path $userProfile "Saved Games\DCS"
$openBetaBase = Join-Path $userProfile "Saved Games\DCS.openbeta"

$standardMod = Join-Path $standardTech "GTFOAirfieldLighting"
$openBetaMod = Join-Path $openBetaTech "GTFOAirfieldLighting"

if (Test-Path $standardMod) {
    $dcsPath = $standardMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "Existing GTFO Airfield Lighting mod folder detected:"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} elseif (Test-Path $openBetaMod) {
    $dcsPath = $openBetaMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "Existing GTFO Airfield Lighting mod folder detected (Open Beta):"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} elseif (Test-Path $standardTech) {
    $dcsPath = $standardMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "DCS Mods\tech folder detected:"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} elseif (Test-Path $openBetaTech) {
    $dcsPath = $openBetaMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "DCS Open Beta Mods\tech folder detected:"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} elseif (Test-Path $standardBase) {
    $dcsPath = $standardMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "DCS Saved Games folder detected (Mods\tech folder will be created):"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} elseif (Test-Path $openBetaBase) {
    $dcsPath = $openBetaMod
    Write-Host "  [ FOUND ] " -NoNewline -ForegroundColor Green
    Write-Host "DCS Open Beta folder detected (Mods\tech folder will be created):"
    Write-Host "            $dcsPath" -ForegroundColor DarkCyan
    Write-Host ""
} else {
    Write-Host "  [   !   ] " -NoNewline -ForegroundColor Yellow
    Write-Host "Could not auto-detect DCS Saved Games Mods\tech folder."
    Write-Host ""
    Write-Host "  Common locations:"
    Write-Host "    $standardTech" -ForegroundColor DarkGray
    Write-Host "    $openBetaTech" -ForegroundColor DarkGray
    Write-Host ""
    
    $promptPath = Read-Host "  Enter the full path to your DCS Mods\tech or Saved Games\DCS folder"
    Write-Host ""

    if (-not (Test-Path $promptPath)) {
        Write-Host "  [ ERROR ] " -NoNewline -ForegroundColor Red
        Write-Host "Path does not exist: $promptPath"
        Write-Host "  Please verify the path and try again."
        Write-Host ""
        Read-Host "  Press Enter to exit..."
        exit 1
    }
    
    if ($promptPath -like "*GTFOAirfieldLighting*") {
        $dcsPath = $promptPath
    } elseif ($promptPath -like "*Mods\tech*") {
        $dcsPath = Join-Path $promptPath "GTFOAirfieldLighting"
    } else {
        $dcsPath = Join-Path $promptPath "Mods\tech\GTFOAirfieldLighting"
    }
}

if (-not (Test-Path $dcsPath)) {
    New-Item -ItemType Directory -Path $dcsPath -Force | Out-Null
}

# ============================================================================
#  STEP 2: Check installed version
# ============================================================================

$versionFile = Join-Path $dcsPath ".gtfo-airfield-lighting-version"
$manifestFile = Join-Path $dcsPath ".gtfo-airfield-lighting-manifest"
$installedVersion = $null

if (Test-Path $versionFile) {
    $installedVersion = (Get-Content -Path $versionFile -Raw).Trim()
    Write-Host "  [ INFO  ] " -NoNewline -ForegroundColor Cyan
    Write-Host "Currently installed version: " -NoNewline
    Write-Host "$installedVersion" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "  [ INFO  ] " -NoNewline -ForegroundColor Cyan
    Write-Host "No previous GTFO Airfield Lighting installation detected."
    Write-Host ""
}

# ============================================================================
#  STEP 3: Query latest release or master from GitHub
# ============================================================================

$repo = "pschilly/gtfo-airfield-lighting"
$userAgent = "GTFO-Airfield-Lighting-Installer"

Write-Host "  [ . . . ] " -NoNewline -ForegroundColor DarkGray
Write-Host "Checking for latest release on GitHub..."

$latestRelease = $null
$latestTag = $null
$ref = $null
$isRelease = $false

try {
    $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest" -Headers @{'User-Agent'=$userAgent} -ErrorAction Stop
    $latestTag = $latestRelease.tag_name
    $ref = $latestTag
    $isRelease = $true
} catch {
    # If no GitHub release published yet, fallback to default branch
    try {
        $branchInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/branches/master" -Headers @{'User-Agent'=$userAgent} -ErrorAction Stop
        $latestTag = $branchInfo.commit.sha.Substring(0, 7)
        $ref = "master"
    } catch {
        try {
            $branchInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/branches/main" -Headers @{'User-Agent'=$userAgent} -ErrorAction Stop
            $latestTag = $branchInfo.commit.sha.Substring(0, 7)
            $ref = "main"
        } catch {
            Write-Host "  [ ERROR ] " -NoNewline -ForegroundColor Red
            Write-Host "Failed to query GitHub repository: $($_.Exception.Message)"
            Write-Host "  Please check your internet connection and try again."
            Write-Host ""
            Read-Host "  Press Enter to exit..."
            exit 1
        }
    }
}

Write-Host "  [  OK   ] " -NoNewline -ForegroundColor Green
if ($isRelease) {
    Write-Host "Latest release tag: " -NoNewline
    Write-Host "$latestTag" -ForegroundColor Green
} else {
    Write-Host "Latest version ($ref): " -NoNewline
    Write-Host "$latestTag" -ForegroundColor Green
}
Write-Host ""

if ($latestRelease -and $latestRelease.body) {
    Write-Host "  ---------------------- Release Notes -----------------------" -ForegroundColor DarkGray
    $latestRelease.body -split "`r?`n" | ForEach-Object { Write-Host ("    " + $_) -ForegroundColor Gray }
    Write-Host "  ------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""
}

# ============================================================================
#  STEP 4: Compare versions & offer integrity scan
# ============================================================================

if ($installedVersion -eq $latestTag) {
    Write-Host "  [  OK   ] " -NoNewline -ForegroundColor Green
    Write-Host "You already have the latest version ($latestTag)."
    Write-Host ""
    $scanChoice = Read-Host "  Scan files to verify integrity and check for missing/corrupted files? (Y/n)"
    if ($scanChoice -and $scanChoice.Trim() -match '^(n|no)$') {
        Write-Host ""
        Write-Host "  No changes made. Exiting."
        Write-Host ""
        Start-Sleep -Seconds 1
        exit 0
    }
    Write-Host ""
} else {
    if ($installedVersion) {
        Write-Host "  [ . . . ] " -NoNewline -ForegroundColor Cyan
        Write-Host "Upgrading mod from $installedVersion to $latestTag..."
        Write-Host ""
    } else {
        Write-Host "  [ . . . ] " -NoNewline -ForegroundColor Cyan
        Write-Host "Installing mod for version $latestTag..."
        Write-Host ""
    }
}

# ============================================================================
#  STEP 5: Get file tree at the release tag / ref
# ============================================================================

Write-Host "  [ . . . ] " -NoNewline -ForegroundColor DarkGray
Write-Host "Fetching mod tree from repository..."

$treeData = $null
try {
    $treeData = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/git/trees/$ref`?recursive=1" -Headers @{'User-Agent'=$userAgent} -ErrorAction Stop
} catch {
    Write-Host "  [ ERROR ] " -NoNewline -ForegroundColor Red
    Write-Host "Failed to fetch repository file tree from GitHub: $($_.Exception.Message)"
    Write-Host ""
    Read-Host "  Press Enter to exit..."
    exit 1
}

$treeFiles = @($treeData.tree | Where-Object { $_.path -like 'GTFOAirfieldLighting/*' -and $_.type -eq 'blob' })
$fileCount = $treeFiles.Count

Write-Host "  [  OK   ] " -NoNewline -ForegroundColor Green
Write-Host "Found $fileCount mod files in repository."
Write-Host ""

# ============================================================================
#  STEP 6: Smart Verify & Download (Hash and Size comparison)
# ============================================================================

Write-Host "  Scanning and verifying local files against GitHub..." -ForegroundColor Cyan
Write-Host ""

$current = 0
$skipped = 0
$downloaded = 0
$downloadedBytes = [double]0
$failedFiles = @()
$manifestList = @()

foreach ($item in $treeFiles) {
    $current++
    $relPath = $item.path -replace '^GTFOAirfieldLighting/', ''
    $localRel = $relPath -replace '/', '\'
    $manifestList += $localRel
    $localPath = Join-Path $dcsPath $localRel
    
    $sizeBytes = [double]$item.size
    $sizeStr = if ($sizeBytes -ge 1MB) { "{0:N2} MB" -f ($sizeBytes / 1MB) } elseif ($sizeBytes -ge 1KB) { "{0:N1} KB" -f ($sizeBytes / 1KB) } else { "$sizeBytes B" }
    $pct = [math]::Round(($current / $fileCount) * 100)
    $progStr = "[{0,3}%] ({1}/{2})" -f $pct, $current, $fileCount

    # Fast Hash Check (Git blob SHA1 calculation)
    $isIdentical = $false
    if (Test-Path $localPath) {
        $localItem = Get-Item $localPath
        if ($localItem.Length -eq $sizeBytes) {
            try {
                $sha1 = [System.Security.Cryptography.SHA1]::Create()
                $fs = [System.IO.File]::OpenRead((Resolve-Path $localPath))
                $header = [System.Text.Encoding]::ASCII.GetBytes("blob $($localItem.Length)`0")
                $sha1.TransformBlock($header, 0, $header.Length, $header, 0) | Out-Null
                $buf = New-Object byte[] 65536
                while (($r = $fs.Read($buf, 0, $buf.Length)) -gt 0) {
                    $sha1.TransformBlock($buf, 0, $r, $buf, 0) | Out-Null
                }
                $sha1.TransformFinalBlock($buf, 0, 0) | Out-Null
                $fs.Close()
                $localHash = -join ($sha1.Hash | ForEach-Object { '{0:x2}' -f $_ })
                if ($localHash -eq $item.sha) {
                    $isIdentical = $true
                }
            } catch {
                $isIdentical = $false
            }
        }
    }

    if ($isIdentical) {
        $skipped++
        Write-Host "  $progStr " -NoNewline -ForegroundColor DarkGray
        Write-Host "[ UP-TO-DATE ] " -NoNewline -ForegroundColor DarkGreen
        Write-Host "$localRel " -NoNewline -ForegroundColor Gray
        Write-Host "($sizeStr)" -ForegroundColor DarkGray
    } else {
        Write-Host "  $progStr " -NoNewline -ForegroundColor Cyan
        Write-Host "[DOWNLOADING ] " -NoNewline -ForegroundColor Yellow
        Write-Host "$localRel " -NoNewline -ForegroundColor White
        Write-Host "($sizeStr)..." -ForegroundColor DarkGray

        $destDir = Split-Path -Parent $localPath
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
        $downloadUrl = "https://raw.githubusercontent.com/$repo/$ref/$($item.path)"
        try {
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $downloadUrl -OutFile $localPath -Headers @{'User-Agent'=$userAgent} -ErrorAction Stop
            $downloaded++
            $downloadedBytes += $sizeBytes
        } catch {
            Write-Host "    [FAILED] $($_.Exception.Message)" -ForegroundColor Red
            $failedFiles += $localRel
        }
    }
}

if ($failedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "  [ WARN  ] " -NoNewline -ForegroundColor Yellow
    Write-Host "$($failedFiles.Count) file(s) failed to download:"
    $failedFiles | ForEach-Object { Write-Host ("    * " + $_) -ForegroundColor Red }
}

# ============================================================================
#  STEP 7: Clean up removed mod files (manifest comparison)
# ============================================================================

$removedCount = 0

if (Test-Path $manifestFile) {
    $oldFiles = @(Get-Content -Path $manifestFile | Where-Object { $_.Trim() -ne '' })
    $newSet = @{}
    foreach ($f in $manifestList) { $newSet[$f.Trim()] = $true }

    foreach ($f in $oldFiles) {
        $fClean = $f.Trim()
        if ($fClean -ne '' -and -not $newSet.ContainsKey($fClean)) {
            $fullPath = Join-Path $dcsPath $fClean
            if (Test-Path $fullPath) {
                Remove-Item -Path $fullPath -Force -ErrorAction SilentlyContinue
                Write-Host "  [ REMOVED ] $fClean" -ForegroundColor DarkYellow
                $removedCount++
            }
        }
    }

    # Clean up empty directories within the mod folder
    $dirsToCheck = $oldFiles | ForEach-Object { Split-Path -Parent $_.Trim() } | Sort-Object -Unique -Descending
    foreach ($d in $dirsToCheck) {
        if ($d -ne '') {
            $fullDir = Join-Path $dcsPath $d
            if ((Test-Path $fullDir) -and ((Get-ChildItem -Path $fullDir -Force -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0)) {
                Remove-Item -Path $fullDir -Force -ErrorAction SilentlyContinue
                Write-Host "  [ REMOVED ] $d\ (empty folder)" -ForegroundColor DarkYellow
            }
        }
    }
}

# ============================================================================
#  STEP 8: Save version and manifest
# ============================================================================

$latestTag | Out-File -FilePath $versionFile -Encoding UTF8
$manifestList | Out-File -FilePath $manifestFile -Encoding UTF8

# ============================================================================
#  STEP 9: Summary
# ============================================================================

$dStr = if ($downloadedBytes -ge 1MB) { "{0:N2} MB" -f ($downloadedBytes / 1MB) } elseif ($downloadedBytes -ge 1KB) { "{0:N1} KB" -f ($downloadedBytes / 1KB) } else { "$downloadedBytes B" }

Write-Host ""
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host "                     INSTALLATION COMPLETE                    " -ForegroundColor Green
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host "    Version:          " -NoNewline -ForegroundColor DarkCyan; Write-Host "$latestTag" -ForegroundColor White
Write-Host "    Mod Folder:       " -NoNewline -ForegroundColor DarkCyan; Write-Host "$dcsPath" -ForegroundColor Gray
Write-Host "    Files Scanned:    " -NoNewline -ForegroundColor DarkCyan; Write-Host "$fileCount total" -ForegroundColor White
Write-Host "    Already Current:  " -NoNewline -ForegroundColor DarkCyan; Write-Host "$skipped up-to-date (skipped)" -ForegroundColor Green
Write-Host "    Downloaded/Fixed: " -NoNewline -ForegroundColor DarkCyan; Write-Host "$downloaded files ($dStr)" -ForegroundColor Yellow
if ($failedFiles.Count -gt 0) {
    Write-Host "    Download Errors:  " -NoNewline -ForegroundColor DarkCyan; Write-Host "$($failedFiles.Count) failed" -ForegroundColor Red
}
if ($removedCount -gt 0) {
    Write-Host "    Obsolete Removed: " -NoNewline -ForegroundColor DarkCyan; Write-Host "$removedCount cleaned" -ForegroundColor DarkYellow
}
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host "    GTFO Airfield Lighting is ready in DCS World!" -ForegroundColor Green
Write-Host "  ============================================================" -ForegroundColor Cyan
Write-Host ""

Read-Host "  Press Enter to exit..."
