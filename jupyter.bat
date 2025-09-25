@echo off
setlocal ENABLEDELAYEDEXPANSION

echo [🔧] Bắt đầu quá trình cài đặt Python Portable + Jupyter...

set PYTHON_DIR=C:\PythonPortable

if not exist "%PYTHON_DIR%" (
    mkdir "%PYTHON_DIR%"
)

set PYTHON_ZIP=python-3.11.6-embed-amd64.zip
set PYTHON_URL=https://www.python.org/ftp/python/3.11.6/%PYTHON_ZIP%
set DOWNLOAD_PATH=%TEMP%\%PYTHON_ZIP%

echo [🌐] Tải Python từ: %PYTHON_URL%
curl -L -o "%DOWNLOAD_PATH%" "%PYTHON_URL%"

if exist "%DOWNLOAD_PATH%" (
    echo [📦] Đang giải nén Python vào %PYTHON_DIR%...
    powershell -Command "Expand-Archive -Path '%DOWNLOAD_PATH%' -DestinationPath '%PYTHON_DIR%' -Force"
) else (
    echo [❌] Lỗi tải Python. Kiểm tra kết nối mạng.
    exit /b
)

set PATH=%PYTHON_DIR%;%PYTHON_DIR%\Scripts;%PATH%

if not exist "%PYTHON_DIR%\Scripts\pip.exe" (
    echo [⬇️] Đang cài pip...
    curl -o "%TEMP%\get-pip.py" https://bootstrap.pypa.io/get-pip.py
    "%PYTHON_DIR%\python.exe" "%TEMP%\get-pip.py"
)

echo [📥] Cài đặt Jupyter Notebook...
pip install --quiet jupyter

echo [🚀] Khởi động Jupyter Notebook trên port 80 (chạy nền)...
start "" /min cmd /c "jupyter notebook --ip=0.0.0.0 --port=80 --no-browser >nul 2>&1"

echo.
echo ✅ Hoàn tất! Jupyter đang chạy ở nền trên port 80.
echo 🌐 Truy cập: http://localhost:80

del "%DOWNLOAD_PATH%" >nul 2>&1

endlocal
pause
