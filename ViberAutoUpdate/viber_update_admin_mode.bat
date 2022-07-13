@ECHO OFF
if "%~s0"=="%~s1" ( cd %~sp1 & shift ) else (
  echo CreateObject^("Shell.Application"^).ShellExecute "%~s0","%~0 %*","","runas",1 >"%tmp%%~n0.vbs" & "%tmp%%~n0.vbs" & del /q "%tmp%%~n0.vbs" & goto :eof
)
title Viber Auto Update [Coder : MR47M]
set "IPADDRESS=8.8.8.8"

:TestNetworkConnection
ping -n 1 %IPADDRESS% | find "TTL=" > nul
if errorlevel 1 (
    goto not_connected
) else (
    goto connected
)

:not_connected
echo Internet [Not Connected]
timeout /t 5
exit

:connected
echo Internet [Connected]
timeout /t 5
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
echo Viber Update Complete.
timeout /t 5
del %windir%\ViberSetup.exe