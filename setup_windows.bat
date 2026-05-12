@echo off
setlocal

:: Get the directory of the script
cd /d %~dp0

echo ==========================================
echo       ReClip Setup ^& Runner (Windows)
echo ==========================================
echo.

:: Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Python is not installed or not in PATH.
    echo Please install Python 3 and try again.
    pause
    exit /b 1
)

:: Check for FFmpeg
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Warning: FFmpeg not found. Video to MP3 conversion might not work.
    echo Please install FFmpeg for full functionality.
    echo.
)

:: Setup venv and install Python deps
if not exist venv (
    echo [+] Creating virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [!] Failed to create venv.
        pause
        exit /b 1
    )
    echo [+] Activating environment and installing dependencies...
    call venv\Scripts\activate
    pip install -q -r requirements.txt
) else (
    echo [+] Activating virtual environment...
    call venv\Scripts\activate
)

:: Set default port if not set
if "%PORT%"=="" set PORT=8899

echo.
echo ==========================================
echo   ReClip is running at http://localhost:%PORT%
echo   Press Ctrl+C to stop the application.
echo ==========================================
echo.

python app.py

echo.
echo [+] Application stopped.
echo [*] To exit the virtual environment, type: deactivate
echo.
pause
