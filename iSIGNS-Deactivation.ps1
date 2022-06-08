# Author: Anthony Clemente
# Purpose: Deactivate iSIGNS Computer AD infrastructure
# Date: 6/8/2022

Write-Output("Test")
function New-RandomPassword {
    $min = 8
    $max = 16
    $nonAlpha = 5
    $length = Get-Random -Minimum $min -Maximum $max
    Add-Type -AssemblyName 'System.Web'
    $newPassword = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlpha)

    return $newPassword
}
function Deactivation([var]$Identity ) {
    $user = Get-ADUser -Identity $Identity
    $newPassword = New-RandomPassword
    Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
    Disable-ADAccount -Identity $user

    return $newPassword
}

Write-Output("Starting")
$Passwords = @()
# $Identities = "mark.bosta", "bill.burrows", "robin.fahey"
# $Computers = "isigns-markb", "isigns-bill", "ISIGNS-ROBINnnn"
$Identities = "bob.clemente", "blob.clemente", "blobby.clemente"
try {
    # foreach ($Computer in $Computers){}
    foreach ($Identity in $Identities){$Passwords += Deactivation($Identity)}
}
catch [System.Management.Automation.RuntimeException]{
    Write-Output("Error: $_")
}
Write-Output("Ended")
Write-Output($Passwords)