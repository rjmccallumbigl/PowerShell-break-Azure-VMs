@REM https://docs.microsoft.com/en-us/archive/blogs/vijaysk/tools-to-simulate-cpu-memory-disk-load

@REM Download files
powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/rjmccallumbigl/PowerShell-break-Azure-VMs/raw/main/Consume.exe', 'C:\Program Files\Common Files\consume.exe')
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/Azure/repair-script-library/raw/master/src/windows/common/tools/kdbgctrl.exe', 'C:\Program Files\Common Files\kdbgctrl.exe')

@REM trigger dump config
powershell "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' -Name 'DedicatedDumpFile' -Value 'D:\dd.sys'"
powershell "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl' -Name 'DumpFile' -Value '%SystemRoot%\Memory.dmp'"
powershell "& 'C:\Program Files\Common Files\kdbgctrl.exe' -sd full"

@REM asynchronously start Consume
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\Consume.exe' -kernel-pool }"
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\Consume.exe' -physical-memory }"
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\Consume.exe' -cpu-time }"
powershell "Start-Process powershell -Verb runAs -ArgumentList {& 'C:\Program Files\Common Files\Consume.exe' -page-file }"

