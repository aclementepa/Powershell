$elu  = Get-ADUser -Filter 'Name -like "*elu graphics*"'
# Write-Output($elu)
$eluPassword = "Rivendell5#"
Remove-ADGroupMember -Identity Users -Members $elu
Remove-ADGroupMember -Identity Graphics -Members $elu
Remove-ADGroupMember -Identity Office -Members $elu
Set-ADAccountPassword -Identity $elu -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $eluPassword -Force)
Disable-ADAccount -Identity $elu