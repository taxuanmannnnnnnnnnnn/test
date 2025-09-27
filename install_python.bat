
@echo off
setlocal

:: ----- Configuration -----
set PYTHON_VERSION=3.10.11
set PYTHON_INSTALLER=python-%PYTHON_VERSION%-amd64.exe
set PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/%PYTHON_INSTALLER%
set INSTALL_PATH=%ProgramFiles%\Python%PYTHON_VERSION:.=%

:: ----- Download Python Installer -----
echo Downloading Python %PYTHON_VERSION%...
curl -L -o %PYTHON_INSTALLER% %PYTHON_URL%

:: ----- Install Python Silently -----
echo Installing Python...
%PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 Include_launcher=1 Include_pip=1 Shortcuts=0

:: ----- Disable PATH Length Limit -----
echo Disabling PATH length limit...
powershell -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name 'Path' -Value (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name 'Path').Path"

:: ----- Create Startup Script -----
set STARTUP_BAT=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\jupyter_startup.bat

echo @echo off > "%STARTUP_BAT%"
echo python -m pip install --quiet jupyter >> "%STARTUP_BAT%"
echo start /min "" cmd /c "jupyter notebook --no-browser --port=80 --NotebookApp.token='' --NotebookApp.password='' >nul 2>&1" >> "%STARTUP_BAT%"

:: ----- Cleanup -----
echo Cleaning up installer and this script...
del /f /q %PYTHON_INSTALLER%
del /f /q "%~f0"

endlocal
exit
