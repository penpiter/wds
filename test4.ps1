shutdown -s -f
shutdown /s /f
$ID=get-content c:\Windows\id
$GITPath="https://raw.githubusercontent.com/penpiter/wds/main/lockscreen_"+$ID+".jpg"
$statusCodePS = Invoke-WebRequest -Uri $GITPath | % {$_.StatusCode}
echo $GITPath

 if($statusCodePS -eq 200) {
   	wget $GITPath -OutFile .\lockscreen.jpg
	echo $statusCodePS
   
	$lsimg = (ls lockscreen.jpg).DirectoryName+"\lockscreen.jpg"
	#.\Set-Screen.ps1 -LockScreenSource "$lsimg"
        .\LockScreenImage.ps1 -LockScreenImageSource $lsimg
        rundll32.exe user32.dll, UpdatePerUserSystemParameters
	#Remove-Item -Path .\lockscreen.jpg -Force
	gpupdate /force
 }
 rundll32.exe user32.dll, UpdatePerUserSystemParameters
gpupdate /force
