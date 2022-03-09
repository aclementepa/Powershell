# Author: Anthony Clemente
# Purpose: Deactivate user & change their password. Include a delete parameter
# Comments: Username must be entered as 'user.name'
# Date: 3/3/2022

Param
    (
        [Parameter(Mandatory=$true)][string]$Username,
        [Parameter(Mandatory=$false)][string]$Password,
        [Parameter(Mandatory=$true)][string]$OU,
        [Parameter(Mandatory=$false)][string]$Group
    )

function New-RandomPassword {
    $min = 8
    $max = 16
    $nonAlpha = 5    
    $length = Get-Random -Minimum $min -Maximum $max
    
    Add-Type -AssemblyName 'System.Web'
    $password = [System.Web.Security.Membership]::GeneratePassword($length,$nonAlpha)
    return $password
}

$name = $username.Split(".")
$fullName = $name[0] + " " + $name[1]

if([string]::IsNullOrWhiteSpace($password)) {
    $password = New-RandomPassword
    Write-Output("A random password has been generated for $username ($password).")
}
$password = ConvertTo-SecureString -String $password -AsPlainText -Force
try {
    New-ADUser -Name $fullName -GivenName $firstname  -UserPrincipalName "$username@howardindustries.local" -Organization "Howard Industries" -DisplayName $fullName -SamAccountName $username -Surname $name[1] -AccountPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -Enabled $true -CannotChangePassword $true -PasswordNeverExpires $true -PasswordNotRequired $False -ScriptPath "$logon_script.vbs"
    Set-ADOrganizationalUnit -Identity $OU $Username -
    Write-Output("User account for $username has been successfully created.")

    if([string]::IsNullOrWhiteSpace($Group)) {
        $groups = $Group.split(',')
        foreach ($g in $groups) {
            Add-ADGroupMember -Identity $group[$i] -Member $Username
            Add-ADOU
        }
    }
}
catch [System.Management.Automation.RuntimeException]{
    Write-Output("Error: $_")
}

# $AD_Object = Get-ADUser -Filter $searchParameters
# Write-Output $AD_Object

# $AD_Object = Get-ADUser -Filter 'Name -like "*Anthony*"'
# Write-Output $AD_Object