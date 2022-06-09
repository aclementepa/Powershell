# Author: Anthony Clemente
# Purpose: Deactivate iSIGNS Computer AD infrastructure
# Date: 6/8/2022

function New-RandomPassword {
    $min = 8
    $max = 16
    $nonAlpha = 5
    $length = Get-Random -Minimum $min -Maximum $max
    Add-Type -AssemblyName 'System.Web'
    $newPassword = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlpha)

    return $newPassword
}
function UserDeactivation([string]$Identity ) {

    $user = Get-ADUser -Identity $Identity
    $newPassword = New-RandomPassword
    Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
    Disable-ADAccount -Identity $user

    return $newPassword
}

function ComputerDeactivation([string]$Computer) {
    # Stop-Computer -ComputerName $Computer
    Invoke-CimMethod -ClassName Win32_Operatingsystem -ComputerName $Computer -MethodName Win32Shutdown -Arguments @{ Flags = 4 }
    $comp = Get-ADComputer -Identity $Computer
    Disable-ADAccount -Identity $comp

    # Write-Output($comp)
    # Write-Output($Computer)
}

$Passwords = @()
# $Identities = "mark.bosta", "bill.burrows", "robin.fahey"
# $Computers = "isigns-markb", "isigns-bill", "ISIGNS-ROBINnnn"
$Computers = "DESKTOP-51PNR1L"
# $Identities = "bob.clemente", "blob.clemente", "blobby.clemente"

try {
    foreach ($Computer in $Computers){ComputerDeactivation($Computer)}
    # foreach ($Identity in $Identities){$Passwords += UserDeactivation($Identity)}
}
catch [System.Management.Automation.RuntimeException]{
    Write-Output("Error: $_")
}
# Write-Output($Passwords)

Write-Output("Done")