# $Nodes = "HOWARD-01"

# Create a new log directory for current date
New-Item -Path "\\telperion\NETLOGON\Update-Logs\" -Name $(Get-Date -f yyyy-MM-dd) -ItemType "directory"

$Nodes = Get-ADComputer -Filter ' Name -like "HOWARD*"' -Properties IPv4Address | select-object -expandproperty name

# $type = Get-TypeData($Nodes)

# Write-Output($type)

# Write-Output($Nodes)

foreach ($node in $Nodes) {
    # Write-Output($node)
    Write-Output("Connecting to " + $node + "...")
    Invoke-WUJob -ComputerName $node.Name -Script {Import-Module PSWindowsUpdate; Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot} -RunNow -Confirm:$false -Force | Out-File "\\telperion\NETLOGON\Update-Logs\$(Get-Date -f yyyy-MM-dd)\$($node)-MSUpdates.log" 
}

# Install-Module PSWindowsUpdate
# Add-WUServiceManager -MicrosoftUpdate