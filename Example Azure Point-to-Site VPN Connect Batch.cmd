@echo off

REM Set variables for VPN connection
set "VPNName=MyAzureVPN"
set "AzureVNetAddress=10.0.0.0/16"
set "AzureVPNServer=<YourAzureVPNServerAddress>"
set "AzureVPNRootCertThumbprint=<YourAzureVPNRootCertThumbprint>"

REM Add VPN connection
echo Adding VPN connection...
rasdial.exe %VPNName%
if %errorlevel% neq 0 (
    echo Error: Unable to add VPN connection.
    exit /b 1
)

REM Configure VPN connection settings
echo Configuring VPN connection settings...
powershell.exe Add-VpnConnection -Name "%VPNName%" -ServerAddress "%AzureVPNServer%" -TunnelType "SSTP" -EncryptionLevel "Required" -AuthenticationMethod "Eap" -EapConfigXmlStream ([System.IO.File]::ReadAllText("%~dp0VPNConnection.xml"))

if %errorlevel% neq 0 (
    echo Error: Unable to configure VPN connection settings.
    exit /b 1
)

REM Set VPN connection as the default route
echo Setting VPN connection as default route...
powershell.exe Set-VpnConnection -Name "%VPNName%" -SplitTunneling $false -AllUserConnection $true -UseWinlogonCredential $true

if %errorlevel% neq 0 (
    echo Error: Unable to set VPN connection as default route.
    exit /b 1
)

REM Import Azure VPN root certificate
echo Importing Azure VPN root certificate...
certutil.exe -addstore "Root" %~dp0AzureVPNRootCert.cer

if %errorlevel% neq 0 (
    echo Error: Unable to import Azure VPN root certificate.
    exit /b 1
)

echo VPN connection setup complete.
exit /b 0
