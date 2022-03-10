Get-Service 'WindowsAzureGuestAgent' | Stop-Service -PassThru | Set-Service -StartupType Disabled;
Get-Service 'rdagent' | Stop-Service -PassThru | Set-Service -StartupType Disabled;
