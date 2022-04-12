$Script:StressJob = 1..$env:NUMBER_OF_PROCESSORS | foreach {Start-Job {Start-Sleep -Seconds 120;[System.Threading.Thread]::CurrentThread.Priority = 'Highest';while ($true) {$i++};}}
