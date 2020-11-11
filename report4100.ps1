$ID=get-content c:\Windows\id

$MailBody = out-string -inputobject (get-winevent -ProviderName Microsoft-Windows-Deployment-Services-Diagnostics | Where-Object {$_.Message -like "*piterpen*" -and $_.Id -eq 4100} | Select-Object -First 1 | fl)

$Chek = get-winevent -ProviderName Microsoft-Windows-Deployment-Services-Diagnostics | Where-Object -Property Id -eq 4100  | Select-Object -First 1 | foreach-object {$_.properties[1].value -like "*piterpen*"}

if($Chek) {Send-MailMessage -From escheodinryukzak@gmail.com -Subject $ID" boot Windows PE x64 SOS PiterPen" -To penpite@gmail.com -Body $MailBody -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "escheodinryukzak@gmail.com", (ConvertTo-SecureString -String "esc123ryu" -AsPlainText -Force)) -UseSsl -Port 587 -SmtpServer smtp.gmail.com}

$checkmail = $?
echo $checkmail
 if(($checkmail) -ne $true) {
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
