# Author: Anthony Clemente
# Purpose: Deactivate user & change their password. Include a delete parameter
# Date: 3/3/2022

Param
    (
        [Parameter(Mandatory=$true)][string]$Identity, # Positional parameter
        [switch]$Delete = $false
    )

# get user
$user = Get-ADUser -Identity $Identity # -Filter "username -like '*$deactivateUser*'"

# configurations for random password generator (length, nonalphachars)
# min/max length of password
$min = 8
$max = 16
$nonAlpha = 5
$length = Get-Random -Minimum $min -Maximum $max
Add-Type -AssemblyName 'System.Web'
$newPassword = [System.Web.Security.Membership]::GeneratePassword($length, $nonAlpha)

try {
    if($Delete) {
        Remove-ADUser -Identity $user -Confirm:$False
    }
    else {
        # Change Password then disable user
        Write-Output($newPassword)
        Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -Force)
        Disable-ADAccount -Identity $user
    }
}
catch [System.Management.Automation.RuntimeException]{
    Write-Output("Error: $_")
}

