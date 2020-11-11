$ID=get-content c:\Windows\id
$GITPath="https://github.com/penpiter/wds/blob/main/"+$ID
echo $GITPath
$sessionID = ((quser | Where-Object { $_ -match 'wds' }) -split ' +')[2]

 $statusCode = Invoke-WebRequest -Uri $GITPath | % {$_.StatusCode}
 echo $statusCode
 
 if($statusCode -ne 200) {
    wdsutil /Stop-Server
    echo "WDS stopped"
    #logoff $sessionID
    Net user wds /active:no
    echo "user WDS disabled"
 }else {
    wdsutil /start-Server
    echo "WDS started"
    Net user wds /active:yes
    echo "user WDS enabled"
 }
echo $ID


rasdial.exe "VPN Connection" vpnrstrictwsrv Psw2020VpnWsrv
$checkvpn = $?

echo $checkvpn

 if(($checkvpn) -ne $true) {
    wdsutil /Stop-Server
    echo "WDS stopped"
    #logoff $sessionID
    Net user wds /active:no
    echo "user WDS disabled"
 }else {
    wdsutil /start-Server
    echo "WDS started"
    Net user wds /active:yes
    echo "user WDS enabled"
 }

powershell.exe -executionpolicy bypass -file c:\Windows\runidps.ps1

sleep 10