$trigger = New-ScheduledTaskTrigger -AtStartup;
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "& {cmd /c \"sc config rdagent start= disabled\"; cmd /c \"sc stop rdagent\"; cmd /c \"sc config WindowsAzureGuestAgent start= disabled\"; cmd /c \"sc stop WindowsAzureGuestAgent\"}"';
Register-ScheduledTask -TaskName 'BreakGA' -Trigger $trigger -Action $action -User "brokenGA\AzureAdmin" -RunLevel Highest -Force;
Start-ScheduledTask 'BreakGA';
