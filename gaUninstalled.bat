sc config rdagent start= disabled && sc stop rdagent && sc config WindowsAzureGuestAgent start= disabled && sc stop WindowsAzureGuestAgent && sc delete rdagent && sc delete WindowsAzureGuestAgent && ren c:\WindowsAzure c:\WindowsAzureOld
