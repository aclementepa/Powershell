# $channel  = Get-ADUser -Filter 'Name -like "*channel*"'
$lastlogon = Get-ADUser -Filter 'Name -like "*anthony*"' -Properties LastLogon
Write-Output($lastlogon)

$lastlogon = Get-ADUser -Identity anthony.clemente -Properties LastLogon
Write-Output($lastlogon)

Write-Output($lastlogon)