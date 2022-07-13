@ECHO OFF
if "%~s0"=="%~s1" ( cd %~sp1 & shift ) else (
  echo CreateObject^("Shell.Application"^).ShellExecute "%~s0","%~0 %*","","runas",1 >"%tmp%%~n0.vbs" & "%tmp%%~n0.vbs" & del /q "%tmp%%~n0.vbs" & goto :eof
)
title Viber Auto Update [Coder : MR47M]
set "IPADDRESS=8.8.8.8"

set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
set Log=viber_%YYYYMMDD%_logs

for /f "delims=[] tokens=2" %%X in ('ping -4 -n 1 %COMPUTERNAME% ^| findstr [') do set NetworkIP=%%X

:TestNetworkConnection
ping -n 1 %IPADDRESS% | find "TTL=" > nul
if errorlevel 1 (
    goto not_connected
) else (
    goto connected
)

:not_connected
echo Internet [Not Connected]
echo Viber Not Updated At [%TIME%] [%DATE%] On [%USERNAME%] [Domain : %ComputerName%] [IP Address : %NetworkIP%] >> Z:\"%Log%".txt
exit

:connected
echo Internet [Connected]
if exist "%windir%\ViberSetup.exe" (
	del %windir%\ViberSetup.exe
	goto download
) else (
	goto download
)

:download
curl -o %windir%\ViberSetup.exe https://download.cdn.viber.com/desktop/windows/ViberSetup.exe
%windir%\ViberSetup.exe /s /v"/qn
cls
echo Viber Updated Successfully At [%TIME%] [%DATE%] On [%USERNAME%] [Domain : %ComputerName%] [IP Address : %NetworkIP%] >> Z:\"%Log%".txt
del %windir%\ViberSetup.exe

REM net use Z: \\SHARE_FOLDER-NAME /U:USERNAME PASSWORD /Persistent:yes