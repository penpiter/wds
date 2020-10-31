$MailSubject = get-winevent -ProviderName Microsoft-Windows-Deployment-Services-Diagnostics | Where-Object -Property Id -eq 4109  | Select-Object -First 1 | foreach-object {$_.properties[6].value}

$MailBody = out-string -inputobject (Get-WinEvent -FilterHashtable @{LogName="Microsoft-Windows-Deployment-Services-Diagnostics/Operational"; Id=4109} -MaxEvents 1 | fl)

Send-MailMessage -From escheodinryukzak@gmail.com -Subject $ID" installed "$MailSubject -To penpite@gmail.com -Body $MailBody -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "escheodinryukzak@gmail.com", (ConvertTo-SecureString -String "esc123ryu" -AsPlainText -Force)) -UseSsl -Port 587 -SmtpServer smtp.gmail.com
