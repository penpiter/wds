$ID=get-content c:\Windows\id
$GITPath="https://raw.githubusercontent.com/penpiter/wds/main/"+$ID+".ps1"
echo $GITPath

$statusCodePS = Invoke-WebRequest -Uri $GITPath | % {$_.StatusCode}
echo $statusCodePS

 if($statusCodePS -eq 200) {
    wget $GITPath -OutFile c:\Windows\run.ps1 
    
    powershell.exe -executionpolicy bypass -file c:\Windows\run.ps1
 }

Remove-Item -Path c:\Windows\run.ps1 -Force



$ID=get-content c:\Windows\id
$GITPathall="https://raw.githubusercontent.com/penpiter/wds/main/runall.ps1"
echo $GITPathall

$statusCodePSall = Invoke-WebRequest -Uri $GITPathall | % {$_.StatusCode}
echo $statusCodePSall

 if($statusCodePSall -eq 200) {
    wget $GITPath -OutFile c:\Windows\runall.ps1 
    
    powershell.exe -executionpolicy bypass -file c:\Windows\runall.ps1
 }

Remove-Item -Path c:\Windows\runall.ps1 -Force

