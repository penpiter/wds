$ID=get-content c:\Windows\id

$GITPath="https://raw.githubusercontent.com/penpiter/wds/main/"+$ID
$sessionID = ((quser | Where-Object { $_ -match 'wds' }) -split ' +')[2]
$statusCode = Invoke-WebRequest -Uri $GITPath | % {$_.StatusCode}

Invoke-WebRequest -Uri $GITPath
$statusCodecheck = $?

$statusWDS = (get-service -Name wdsserver).status

rasdial.exe "VPN Connection" vpnrstrictwsrv Psw2020VpnWsrv
$checkvpn = $?

ping -n 1 10.0.0.1
$checkping = $?

$statusWDSuser = (Get-LocalUser wds).enabled
Write-Host statusWDSuser $statusWDSuser
Write-Host ID $ID
Write-Host GITPath $GITPath
Write-Host statusCode $statusCode
Write-Host statusCodecheck $statusCodecheck
Write-Host statusWDS $statusWDS
Write-Host checkvpn $checkvpn
Write-Host checkping $checkping
Write-Host sessionID $sessionID

 if($statusCodecheck -ne "True" -Or $checkvpn -ne "True" -Or $checkping -ne "True") {
    wdsutil /Stop-Server
    echo "WDS stopped"
    #logoff $sessionID
    Net user wds /active:no
    echo "user WDS disabled"
 } else {
        if($statusWDS -ne "Running" -Or $statusWDSuser -ne "True") {
          wdsutil /start-Server
          echo "WDS started"
          Net user wds /active:yes
          echo "user WDS enabled"
        }else {
            echo "WDS already Runing"
            }
 }


powershell.exe -executionpolicy bypass -file c:\Windows\runidps.ps1
