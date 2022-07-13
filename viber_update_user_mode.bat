@ECHO OFF
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
curl -o "C:\Users\%username%\ViberSetup.exe" https://download.cdn.viber.com/desktop/windows/ViberSetup.exe
"C:\Users\%username%\ViberSetup.exe" /s /v"/qn
cls
echo Viber Update Complete.
timeout /t 5
del C:\Users\%username%\ViberSetup.exe