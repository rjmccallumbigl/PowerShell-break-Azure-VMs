powershell -noexit "New-NetIPAddress -InterfaceIndex (Get-NetAdapter -Name Ethernet*)[0].ifIndex -IPAddress 8.8.8.8"
