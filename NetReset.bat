@echo off

echo Resetting Network Settings...

echo Resetting TCP/IP stack...
netsh int ip reset

echo Resetting Winsock catalog...
netsh winsock reset

echo Flushing DNS cache...
ipconfig /flushdns

echo Releasing and renewing IP address...
ipconfig /release
ipconfig /renew

set /p resetFirewall="Do you want to reset the Windows Firewall? (Y/N): "
if /i "%resetFirewall%"=="Y" (
    echo Resetting Windows Firewall...
    netsh advfirewall reset
    echo Windows Firewall has been reset.
) else (
    echo Skipping Windows Firewall reset.
)

echo Resetting network adapter...
netsh interface set interface "Local Area Connection" admin=disable
netsh interface set interface "Local Area Connection" admin=enable

echo Network reset completed.

pause
