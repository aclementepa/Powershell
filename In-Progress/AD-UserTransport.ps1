
Param
(
    [switch]$Import = $false,
    [switch]$Export = $false,
    [string]$Path
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

function Export-ADUsers {
    Get-ADUser -Filter "enabled -eq 'true'" -Properties * | Select-Object samaccountname, distinguishedname, name, givenname, surname, userPrincipalName | 
    Export-CSV -path $Path

}

function Import-ADUsers {
    
    # Generate Random Password
    $password = New-RandomPassword

    # Create User
    $users = Import-CSV -Path $Path | ForEach-Object {
        
        $UserPrincipalName = $_."SamAccountName" + "@domain.local"

        $user = New-ADUser -Name $_."Name" -UserPrincipalName $UserPrincipalName -DisplayName $_."Name" -SamAccountName $_."SamAccountName" -GivenName $_."GivenName" -Surname $_."Surname" -AccountPassword (ConvertTo-SecureString -String $password -AsPlainText -Force) -Enabled $true -CannotChangePassword $true -PasswordNeverExpires $true -PasswordNotRequired $False -ScriptPath "$_.'SamAccountName'.vbs"
        # Add User to corresponding group
        try {
            $OU = ($_."DistinguishedName" -split ",")[1]
            $ADGroup = $OU.Substring(($OU.IndexOf('=') + 1), ($OU.Length - ($OU.IndexOf('=')+1)))

        }
        catch [System.Management.Automation.RuntimeException]{
            Write-Output("Error: $_")
        }
        # $user = Get-ADUser -Filter "Name -like '*$_.Name*'"
        Add-ADGroupMember -Identity $ADGroup -Members $_."SamAccountName"
        
        # Format: CN,OU,OU,DN,DN
        # Output: OU=,DC=domain,DC=local
    }
}    

if($Export) {
    Export-ADUsers
}
elseif ($Import) {
    Import-ADUsers
}
