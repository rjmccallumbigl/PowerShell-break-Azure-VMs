$Script:StressJob = 1..$env:NUMBER_OF_PROCESSORS | foreach {Start-Job {[System.Threading.Thread]::CurrentThread.Priority = 'Highest';while ($true) {$i++};}}
