# Master Development Launcher for Indore Flood Intelligence (IFI)
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Indore Flood Intelligence (IFI) — Full-Stack Launcher     " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Run Backend Tests & Verify Seed Data
Write-Host "`n[1/3] Running Automated Validation Tests..." -ForegroundColor Yellow
$env:PYTHONPATH = "."
$pythonExe = "python"
if (Test-Path "C:\Users\Yash\AppData\Local\Programs\Python\Python314\python.exe") {
    $pythonExe = "C:\Users\Yash\AppData\Local\Programs\Python\Python314\python.exe"
}

& $pythonExe backend/tests/run_all_tests.py
if ($LASTEXITCODE -ne 0) {
    Write-Host "Warning: Some tests reported issues, check above." -ForegroundColor Red
} else {
    Write-Host "All backend and hydrological tests passed!" -ForegroundColor Green
}

# 2. Instructions for Running Frontend & Backend
Write-Host "`n[2/3] Local Architecture Verified." -ForegroundColor Yellow
Write-Host "To launch both services:"
Write-Host "  Terminal 1 (Backend):  .\start-backend.ps1" -ForegroundColor Cyan
Write-Host "  Terminal 2 (Frontend): .\start-frontend.ps1" -ForegroundColor Cyan
Write-Host "`nOr access directly via browser at: http://localhost:5173" -ForegroundColor Green

# 3. Open Frontend if requested
$choice = Read-Host "`nWould you like to start the frontend now? (Y/n)"
if ($choice -ne 'n' -and $choice -ne 'N') {
    npm run dev
}
