$leases = Get-DhcpServerv4Lease -ComputerName "computer.domain.local" -ScopeId 192.168.100.0 -AllLeases | Format-Table  HostName,IPAddress,AddressState

Write-Output($leases)