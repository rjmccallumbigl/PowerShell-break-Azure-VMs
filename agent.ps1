$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration ([Timespan]::MaxValue);
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "& {cmd /c \"sc config rdagent start= disabled\"; cmd /c \"sc stop rdagent\"; cmd /c \"sc config WindowsAzureGuestAgent start= disabled\"; cmd /c \"sc stop WindowsAzureGuestAgent\"}"';
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest;
Register-ScheduledTask -TaskName 'BreakGA' -Trigger $trigger -Action $action -Principal $principal -Force;
Start-ScheduledTask 'BreakGA';
