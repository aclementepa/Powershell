$Computername=$args[0]
 
 
$query=Get-HotFix  -ComputerName $Computername
 
Remove-Item -Path "C:\Development\Reports\WindowsUpdateStatus\$computername-WindowsUpdates.csv" -Recurse
$query| Export-Csv -NoType "C:\Development\Reports\WindowsUpdateStatus\$computername-WindowsUpdates.csv"
$FileLocation="C:\Development\Reports\WindowsUpdateStatus\$computername-WindowsUpdates.csv"
Start-Process notepad $FileLocation