# ตรวจสอบสิทธิ์ Administrator ก่อนรันสคริปต์
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[ERROR] Please run PowerShell as Administrator." -ForegroundColor Red
    return
}

# กำหนดลิงก์ตรงจาก Microsoft และโฟลเดอร์ชั่วคราว
$msUrl = "https://download.microsoft.com/download/1f01d660-d821-49b3-b247-7bc2fe9f4561/wmic_dlc.zip"
$workDir = "$env:TEMP\WMIC_DLC_Setup"
$zipFile = "$workDir\wmic_dlc.zip"

try {
    # เคลียร์โฟลเดอร์ชั่วคราวเก่า (ถ้ามี) แล้วสร้างใหม่
    if (Test-Path $workDir) { Remove-Item -Path $workDir -Recurse -Force }
    New-Item -ItemType Directory -Path $workDir -Force | Out-Null

    # บังคับใช้ TLS 1.2 และดาวน์โหลดไฟล์ตรงจาก Microsoft
    Write-Host "[INFO] Downloading official WMIC DLC from Microsoft..." -ForegroundColor Cyan
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $msUrl -OutFile $zipFile -UseBasicParsing

    # แตกไฟล์ zip ลงในโฟลเดอร์ชั่วคราว
    Write-Host "[INFO] Extracting package..." -ForegroundColor Cyan
    Expand-Archive -Path $zipFile -DestinationPath $workDir -Force

    # ค้นหาไฟล์ install.ps1 ด้านใน (รองรับโครงสร้าง wmic_dlc\install.ps1)
    $installer = Get-ChildItem -Path $workDir -Filter "install.ps1" -Recurse | Select-Object -First 1
    if (-not $installer) {
        throw "install.ps1 not found inside the extracted package."
    }

    # ปลดล็อกไฟล์ที่โหลดมาจากอินเทอร์เน็ตเพื่อป้องกันติด Security Warning
    Get-ChildItem -Path $installer.DirectoryName -Recurse | Unblock-File -ErrorAction SilentlyContinue

    # ย้าย Working Directory เข้าไปที่โฟลเดอร์ของ install.ps1 แล้วสั่งรันแบบ Bypass
    Write-Host "[INFO] Running Microsoft WMIC installer..." -ForegroundColor Cyan
    Push-Location $installer.DirectoryName
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $installer.FullName
    Pop-Location

    # ตรวจสอบว่าสามารถเรียกใช้งาน wmic ได้แล้วหรือไม่
    Write-Host "[INFO] Verifying WMIC installation..." -ForegroundColor Yellow
    if (Get-Command wmic -ErrorAction SilentlyContinue) {
        Write-Host "[SUCCESS] WMIC installed successfully!" -ForegroundColor Green
        wmic os get caption
    } else {
        Write-Host "[WARNING] Installer finished, please reopen terminal to test 'wmic'." -ForegroundColor Yellow
    }
} catch {
    Write-Host "[ERROR] Installation failed: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    # ลบโฟลเดอร์ชั่วคราวและไฟล์ zip ทิ้งหลังทำงานเสร็จ
    if (Test-Path $workDir) {
        Remove-Item -Path $workDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}
