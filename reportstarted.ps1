$ID=get-content c:\Windows\id

Send-MailMessage -From escheodinryukzak@gmail.com -Subject $ID" WDS started" -To penpite@gmail.com -Body $ID" WDS started" -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "escheodinryukzak@gmail.com", (ConvertTo-SecureString -String "esc123ryu" -AsPlainText -Force)) -UseSsl -Port 587 -SmtpServer smtp.gmail.com
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