@echo off
setlocal
cd /d "%~dp0"
set "PYTHON_EXE=C:\Users\Yash\AppData\Local\Programs\Python\Python314\python.exe"
if not exist "%PYTHON_EXE%" set "PYTHON_EXE=python"
set PYTHONPATH=%~dp0

echo ==========================================================
echo  Starting Indore Flood Intelligence (IFI) Backend Server
echo ==========================================================
echo Using Python: %PYTHON_EXE%
echo API Listening on: http://127.0.0.1:8000
echo ==========================================================

"%PYTHON_EXE%" backend/app/server.py 8000 0.0.0.0
