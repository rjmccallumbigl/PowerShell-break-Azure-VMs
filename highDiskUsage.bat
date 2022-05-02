powershell -noexit "
# https://docs.microsoft.com/en-us/azure-stack/hci/manage/diskspd-overview
# https://docs.microsoft.com/en-us/azure/virtual-machines/disks-benchmarks
# https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/how-to-use-perfInsights

# Download files
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12;
(new-object System.Net.WebClient).DownloadFile('https://github.com/Microsoft/diskspd/releases/latest/download/DiskSpd.zip','C:\Program Files\Common Files\DiskSpd.zip');
(new-object System.Net.WebClient).DownloadFile('https://aka.ms/perfinsightslatest','C:\Program Files\Common Files\PerfInsights.zip');

# Expand zips
Expand-Archive -LiteralPath 'C:\Program Files\Common Files\DiskSpd.zip' -DestinationPath 'C:\Program Files\Common Files\DiskSpd';
Expand-Archive -LiteralPath 'C:\Program Files\Common Files\PerfInsights.zip' -DestinationPath 'C:\Program Files\Common Files\PerfInsights';

# Run tests
$vCPUS = $env:NUMBER_OF_PROCESSORS;
& 'C:\Program Files\Common Files\DiskSpd\DiskSpd.exe' -c1024M -d120 -w100 -t$($vCPUs) -o128 -b512k -r -Sh -L testfile1.dat;
# Maximum write IOPS
& 'C:\Program Files\Common Files\PerfInsights\diskspd.exe' -c200G -w100 -b8K -F4 -r -o128 -W30 -d120 -Sh testfile2.dat;
# Maximum read IOPS
& 'C:\Program Files\Common Files\PerfInsights\diskspd.exe' -c200G -b4K -F4 -r -o128 -W7200 -d120 -Sh testfile3.dat;
# Maximum throughput
& 'C:\Program Files\Common Files\PerfInsights\diskspd.exe' -c200G -b64K -F4 -r -o128 -W7200 -d120 -Sh testfile4.dat;
# PerfInsights benchmark
& 'C:\Program Files\Common Files\PerfInsights\PerfInsights.exe' /run advanced xp /d 900 /AcceptDisclaimerAndShareDiagnostics;
"
