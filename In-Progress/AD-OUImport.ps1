New-ADGroup -Name "MIS" -SamAccountName MIS -GroupCategory Security -GroupScope Global -DisplayName "MIS" -Path "OU=MIS,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the MIS Department"

New-ADGroup -Name "Accounting" -SamAccountName Accounting -GroupCategory Security -GroupScope Global -DisplayName "Accounting" -Path "OU=Accounting,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Accounting Department"

New-ADGroup -Name "Graphics" -SamAccountName Graphics -GroupCategory Security -GroupScope Global -DisplayName "Graphics" -Path "OU=Graphics,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Graphics Department"

New-ADGroup -Name "Interior" -SamAccountName Interior -GroupCategory Security -GroupScope Global -DisplayName "Interior" -Path "OU=Interior,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Interior Department"

New-ADGroup -Name "Management" -SamAccountName Management -GroupCategory Security -GroupScope Global -DisplayName "Management" -Path "OU=Management,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of Management"

New-ADGroup -Name "Office" -SamAccountName Office -GroupCategory Security -GroupScope Global -DisplayName "Office" -Path "OU=Office,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Office"

New-ADGroup -Name "Sales" -SamAccountName Sales -GroupCategory Security -GroupScope Global -DisplayName "Sales" -Path "OU=Sales,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Sales Department"

New-ADGroup -Name "Shop" -SamAccountName Shop -GroupCategory Security -GroupScope Global -DisplayName "Shop" -Path "OU=Shop,DC=HOWARD-INDUSTRIES,DC=LOCAL" -Description "Members of this group are part of the Shop"

<#
New-ADOrganizationalUnit -Name "MIS" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Accounting" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Graphics" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Interior" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Management" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Marketing" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Office" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Sales" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
New-ADOrganizationalUnit -Name "Shop" -Path "DC=HOWARD-INDUSTRIES,DC=LOCAL" -ProtectedFromAccidentalDeletion $true
#>