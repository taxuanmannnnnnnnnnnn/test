@echo off
setlocal

net start w32time
w32tm /resync


REM -- Create diskpart script --
>"%~dp0extend.txt" (
  echo select volume C
  echo extend
  echo exit
)

REM -- Run diskpart silently --
diskpart /s "%~dp0extend.txt" >nul 2>&1

REM -- Clean up --
del "%~dp0extend.txt"

echo ✅ O C: da duoc mo rong (neu chua duoc phan bo)
endlocal

echo Dang cai dat trinh dieu khien cho card do hoa NVIDIA Tesla T4...
cd "C:\NVIDIA\DisplayDriver\553.62\Win11_Win10-DCH_64\International\" 
setup.exe -s 
echo Dang cai dat Apollo Game Streaming...
cd "C:\Users\admin\Desktop\setup"
Apollo.exe /S
timeout /t 30 /nobreak
echo Dang lam cho Display Adapter hoat dong...
powershell -Command "Get-PnpDevice -FriendlyName 'Microsoft Hyper-V Video' | Disable-PnpDevice -Confirm:\$false"
DisplaySwitch.exe /internal

start diskmgmt.msc
start taskmgr
start chrome "https://google.com"


echo Tất cả đã xong!

del "%~f0"
