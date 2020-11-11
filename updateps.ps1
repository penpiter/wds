$ID=get-content c:\Windows\id
$GITPath="https://raw.githubusercontent.com/penpiter/wds/main/"
$statusCodePS = Invoke-WebRequest -Uri $GITPath | % {$_.StatusCode}

 if($statusCodePS -eq 200) {
    wget "$GITPath/reportstarted.ps1" -OutFile c:\Windows\reportstarted.ps1
    wget "$GITPath/report4100.ps1" -OutFile c:\Windows\report4100.ps1
    wget "$GITPath/cheklicence.ps1" -OutFile c:\Windows\cheklicence.ps1
    wget "$GITPath/report4109.ps1" -OutFile c:\Windows\report4109.ps1 
    
 }


