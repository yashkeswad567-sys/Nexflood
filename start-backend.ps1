# Start Backend Server for Indore Flood Intelligence (IFI)
param(
    [int]$port = 8000,
    [string]$hostIp = "0.0.0.0"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Starting Indore Flood Intelligence (IFI) Backend Server  " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$env:PYTHONPATH = $scriptDir

# Locate Python 3.11+ executable
$pythonExe = "python"
if (Test-Path "C:\Users\Yash\AppData\Local\Programs\Python\Python314\python.exe") {
    $pythonExe = "C:\Users\Yash\AppData\Local\Programs\Python\Python314\python.exe"
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    $pythonExe = "py"
}

Write-Host "Working Directory : $scriptDir" -ForegroundColor Gray
Write-Host "Python Executable : $pythonExe" -ForegroundColor Gray
Write-Host "API Listening on  : http://localhost:$port (and http://127.0.0.1:$port)" -ForegroundColor Green
Write-Host "Health Endpoint   : http://127.0.0.1:$port/health" -ForegroundColor Green
Write-Host "API v1 Endpoint   : http://127.0.0.1:$port/api/v1" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

& $pythonExe backend/app/server.py $port $hostIp
