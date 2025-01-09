# 需要以管理员权限运行的 PowerShell 脚本

# 检查是否以管理员权限运行
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "请以管理员权限运行此脚本！"
    Write-Warning "请右键点击 PowerShell，选择'以管理员身份运行'，然后重新运行此脚本。"
    exit 1
}

# 定义要设置的文件扩展名
$extensions = @(
    ".txt",
    ".md",
    ".vue"
    # 其他扩展名暂时注释掉进行测试
)

# 创建备份文件夹
$backupFolder = ".\registry_backups"
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

# 创建带时间戳的备份文件
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backupPath = Join-Path $backupFolder "registry_backup_$timestamp.reg"

# 查找 Cursor 安装路径
$cursorPath = Get-ChildItem "C:\Users\*\AppData\Local\Programs\Cursor\Cursor.exe" -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName

if (-not $cursorPath) {
    Write-Error "未找到 Cursor 安装路径！请确保 Cursor 已正确安装。"
    exit 1
}

Write-Host "找到 Cursor 安装路径：$cursorPath"

# 显示警告信息和确认提示
Write-Host "`n警告：此脚本将执行以下操作：" -ForegroundColor Yellow
Write-Host "1. 修改系统注册表"
Write-Host "2. 更改文件关联设置"
Write-Host "3. 可能需要重启资源管理器"
Write-Host "`n在继续之前，请确保："
Write-Host "- 已保存所有打开的文件"
Write-Host "- 已关闭所有编辑器"
Write-Host "- 了解可能的风险"

$confirm = Read-Host "`n是否继续？(Y/N)"
if ($confirm -ne 'Y' -and $confirm -ne 'y') {
    Write-Host "操作已取消"
    exit 0
}

# 创建注册表备份
Write-Host "`n正在创建注册表备份到: $backupPath" -ForegroundColor Cyan
foreach ($ext in $extensions) {
    $regPath = "HKLM:\SOFTWARE\Classes\$ext"
    if (Test-Path $regPath) {
        reg export "HKLM\SOFTWARE\Classes\$ext" "$backupPath" /y | Out-Null
    }
}

$successCount = 0
$failCount = 0

# 设置文件关联
foreach ($ext in $extensions) {
    Write-Host "正在设置 $ext 的默认打开方式..."
    
    try {
        # 为文件扩展名创建注册表项
        $regPath = "HKLM:\SOFTWARE\Classes\$ext"
        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }
        
        # 设置默认值
        Set-ItemProperty -Path $regPath -Name "(Default)" -Value "CursorEditor$ext" -Force

        # 创建应用程序注册表项
        $appRegPath = "HKLM:\SOFTWARE\Classes\CursorEditor$ext"
        if (-not (Test-Path $appRegPath)) {
            New-Item -Path $appRegPath -Force | Out-Null
        }
        
        # 设置文件类型描述
        Set-ItemProperty -Path $appRegPath -Name "(Default)" -Value "Cursor Editor File" -Force

        # 创建命令注册表项
        $commandPath = "$appRegPath\shell\open\command"
        if (-not (Test-Path $commandPath)) {
            New-Item -Path $commandPath -Force | Out-Null
        }
        
        # 设置打开命令
        Set-ItemProperty -Path $commandPath -Name "(Default)" -Value "`"$cursorPath`" `"%1`"" -Force

        $successCount++
        Write-Host "✓ 成功设置 $ext" -ForegroundColor Green
    }
    catch {
        $failCount++
        Write-Host "✗ 设置 $ext 失败: $_" -ForegroundColor Red
    }
}

# 刷新 Windows 文件关联缓存
cmd /c "assoc . > nul"

# 显示统计信息
Write-Host "`n操作完成！"
Write-Host "成功设置：$successCount"
Write-Host "失败：$failCount"
Write-Host "`n注意：某些失败可能是由于系统限制或权限问题导致"

# 显示恢复说明
Write-Host "`n如果需要恢复之前的设置，您可以：" -ForegroundColor Cyan
Write-Host "1. 双击运行备份文件：$backupPath"
Write-Host "2. 或在控制面板 > 默认程序中手动设置"
Write-Host "3. 或运行命令：reg import `"$backupPath`""

# 提示用户可能需要重启资源管理器
Write-Host "`n提示：您可能需要重启资源管理器才能看到更改"
$restart = Read-Host "是否要重启资源管理器？(Y/N)"
if ($restart -eq 'Y' -or $restart -eq 'y') {
    Write-Host "正在重启资源管理器..."
    Stop-Process -Name "explorer" -Force
    Start-Process "explorer"
    Write-Host "资源管理器已重启"
}

Write-Host "`n脚本执行完成。请测试文件关联是否正常工作。" -ForegroundColor Green 