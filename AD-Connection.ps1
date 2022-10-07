# $ID = Get-GPO -Name "Default Domain Controllers Policy"
# Enable the WinRM Service through GPO
# Write-Output($ID)
# Write-Output(Get-GPO -All -Domain ".local")
# Write-Output(Get-GPOReport -All -Domain ".local")


Get-GPOReport -Name "Default Domain Policy" -ReportType HTML -Path "C:\Users\anthony.clemente\Desktop\DefaultDomainPolicy.html"
Get-GPOReport -Name "Windows Defender Off" -ReportType HTML -Path "C:\Users\anthony.clemente\Desktop\Firewall.html"
Get-GPOReport -Name "Default Domain Controllers Policy" -ReportType HTML -Path "C:\Users\anthony.clemente\Desktop\Default Domain Controllers Policy.html"


<# #$Dir=""
$Dir = ""
$CertificateFingerprint = ""

$newFileName = Get-ChildItem -Path $dir -Filter *.bak | Sort-Object LastWriteTime -Descending |Select-Object -First 1

$Day = Get-Date
$UploadDay= $Day.DayOfWeek  


If($UploadDay -eq "Tuesday" ){ 

    Write-Output "The latest db backup file is $newFileName. Let's start uploading"


    Add-FTPItem -Path "" -LocalPath "" -Username "" -Password "" -FTPHost "" 
    Write-Output "Upload completed!"

  }else {
      "Upload failed!"    
  }


#$DiffBackupDir="\\"
$DiffBackupDir = ""

$DiffBackup = Get-ChildItem -Path $DiffBackupDir -Filter *.bak | Sort-Object LastWriteTime -Descending |Select-Object -First 1

Write-Output "The latest db backup file is $DiffBackup. Let's start uploading"

#Upload of a differential backup to FTP Folder
Add-FTPItem -Path "" -LocalPath "" -Username "" -Password "" -FTPHost ""  #>