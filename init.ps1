if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }; Add-Content -Path $PROFILE -Value 'Set-PSReadLineOption -EditMode Emacs'
# 1. 确保以管理员权限运行此脚本
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {     Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs     exit }
# 2. 定义要安装的应用 ID (Winget ID)
$apps = @(
    "Vivaldi.Vivaldi",
    "360.PalmInput",   # 建议检查 ID 是否准确，Winget 搜索: winget search Palminput
    "Ecopaste.Ecopaste",
    "LiErHeXun.Quicker",
    "chen08209.FlClash",
    "Tencent.WeChat"
)

# 3. 循环安装
foreach ($app in $apps) {
    Write-Host "正在安装: $app..." -ForegroundColor Cyan
    # --silent: 静默模式
    # --accept-package-agreements: 自动接受协议
    # --accept-source-agreements: 自动接受源协议
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}
