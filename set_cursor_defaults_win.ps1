# PowerShell script that requires administrator privileges

# Check if running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    exit 1
}

# Define file extensions to be set (can be modified as needed)
$extensions = @(
    ".txt",
    ".vue",
    ".ts",
    ".js"
)

# Create backup folder
$backupFolder = ".\registry_backups"
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

# Create timestamped backup file
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupPath = Join-Path $backupFolder "registry_backup_$timestamp.reg"

# Find Cursor installation path
$cursorPaths = @(
    "C:\Users\*\AppData\Local\Programs\Cursor\Cursor.exe",
    "${env:ProgramFiles}\Cursor\Cursor.exe",
    "${env:ProgramFiles(x86)}\Cursor\Cursor.exe"
)

$cursorPath = $null
foreach ($path in $cursorPaths) {
    $foundPath = Get-ChildItem $path -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
    if ($foundPath) {
        $cursorPath = $foundPath
        break
    }
}

if (-not $cursorPath) {
    Write-Error "Cursor installation path not found! Please ensure Cursor is properly installed."
    exit 1
}

Write-Host "Found Cursor installation path: $cursorPath"

# Display warning and confirmation prompt
Write-Host "`nWarning: This script will perform the following actions:" -ForegroundColor Yellow
Write-Host "1. Modify system registry"
Write-Host "2. Change file associations"
Write-Host "3. May require Explorer restart"
Write-Host "`nBefore continuing, please ensure:"
Write-Host "- All open files are saved"
Write-Host "- All editors are closed"
Write-Host "- You understand the potential risks"

$confirm = Read-Host "`nContinue? (Y/N)"
if ($confirm -ne 'Y' -and $confirm -ne 'y') {
    Write-Host "Operation cancelled"
    exit 0
}

# Create registry backup
Write-Host "`nCreating registry backup to: $backupPath" -ForegroundColor Cyan
reg export "HKLM\SOFTWARE\Classes" "$backupPath" /y | Out-Null

$successCount = 0
$failCount = 0

# Add progress bar
$progressPreference = 'Continue'
$i = 0

# Set file associations
foreach ($ext in $extensions) {
    $i++
    Write-Progress -Activity "Setting file associations" -Status "Processing $ext" -PercentComplete (($i / $extensions.Count) * 100)
    Write-Host "Setting default application for $ext..."
    
    try {
        # Create registry entry for file extension
        $regPath = "HKLM:\SOFTWARE\Classes\$ext"
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }
        
        # Set default value
        Set-ItemProperty -Path $regPath -Name "(Default)" -Value "CursorEditor$ext" -Force

        # Create application registry entry
        $appRegPath = "HKLM:\SOFTWARE\Classes\CursorEditor$ext"
        if (-not (Test-Path $appRegPath)) {
            New-Item -Path $appRegPath -Force | Out-Null
        }
        
        # Set file type description
        Set-ItemProperty -Path $appRegPath -Name "(Default)" -Value "Cursor Editor File" -Force

        # Create command registry entry
        $commandPath = "$appRegPath\shell\open\command"
        if (-not (Test-Path $commandPath)) {
            New-Item -Path $commandPath -Force | Out-Null
        }
        
        # Set open command
        Set-ItemProperty -Path $commandPath -Name "(Default)" -Value "`"$cursorPath`" `"%1`"" -Force

        $successCount++
        Write-Host "✓ Successfully set $ext" -ForegroundColor Green
    }
    catch {
        $failCount++
        Write-Host "✗ Failed to set $ext: $_" -ForegroundColor Red
    }
}

# Refresh Windows file association cache
try {
    cmd /c "assoc . > nul"
} catch {
    Write-Warning "Failed to refresh file association cache. New settings may not take effect immediately."
}

# Display statistics
Write-Host "`nOperation completed!"
Write-Host "Successfully set: $successCount"
Write-Host "Failed: $failCount"

# Display recovery instructions
Write-Host "`nTo restore previous settings, you can:" -ForegroundColor Cyan
Write-Host "1. Double-click the backup file: $backupPath"
Write-Host "2. Or manually set in Control Panel > Default Programs"
Write-Host "3. Or run command: reg import `"$backupPath`""

# Prompt for Explorer restart
Write-Host "`nNote: You may need to restart Explorer to see the changes"
$restart = Read-Host "Restart Explorer now? (Y/N)"
if ($restart -eq 'Y' -or $restart -eq 'y') {
    Write-Host "Restarting Explorer..."
    try {
        Stop-Process -Name "explorer" -Force
        Start-Process "explorer"
        Write-Host "Explorer has been restarted"
    }
    catch {
        Write-Host "Failed to restart Explorer: $_" -ForegroundColor Red
    }
}

Write-Host "`nScript execution completed. Please test if file associations work properly." -ForegroundColor Green