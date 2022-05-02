@REM https://docs.microsoft.com/en-us/azure-stack/hci/manage/diskspd-overview
@REM https://docs.microsoft.com/en-us/azure/virtual-machines/disks-benchmarks
@REM https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/how-to-use-perfInsights

@REM Download files
powershell "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/Microsoft/diskspd/releases/latest/download/DiskSpd.zip', 'C:\Program Files\Common Files\DiskSpd.zip')" 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://aka.ms/perfinsightslatest', 'C:\Program Files\Common Files\PerfInsights.zip')" 

@REM Expand zips
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\DiskSpd.zip' -DestinationPath 'C:\Program Files\Common Files\DiskSpd'"
powershell "Expand-Archive -LiteralPath 'C:\Program Files\Common Files\PerfInsights.zip' -DestinationPath 'C:\Program Files\Common Files\PerfInsights'"

@REM Start PerfInsights for 900s
powershell "start-job {& 'C:\Program Files\Common Files\PerfInsights\PerfInsights.exe' /run advanced xpns /d 900 /AcceptDisclaimerAndShareDiagnostics /sau /outputfolder 'C:\Program Files\Common Files'}"

@REM Run disk benchmarks
powershell "& 'C:\Program Files\Common Files\DiskSpd\amd64\diskspd.exe' -c1024M -d120 -w100 -t"""$env:NUMBER_OF_PROCESSORS""" -o128 -b512k -r -Sh -L 'C:\Program Files\Common Files\testfile1.dat'"

@REM Maximum write IOPS
 powershell "& 'C:\Program Files\Common Files\PerfInsights\amd64\diskspd.exe' -c200G -w100 -b8K -F4 -r -o128 -W30 -d120 -Sh 'C:\Program Files\Common Files\testfile2.dat'"
 
@REM Maximum read IOPS
powershell "& 'C:\Program Files\Common Files\PerfInsights\amd64\diskspd.exe' -c200G -b4K -F4 -r -o128 -W7200 -d120 -Sh 'C:\Program Files\Common Files\testfile3.dat'"

@REM Maximum throughput
powershell "& 'C:\Program Files\Common Files\PerfInsights\amd64\diskspd.exe' -c200G -b64K -F4 -r -o128 -W7200 -d120 -Sh 'C:\Program Files\Common Files\testfile4.dat'"
