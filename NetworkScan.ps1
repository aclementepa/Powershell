$leases = Get-DhcpServerv4Lease -ComputerName "telperion.howardindustries.local" -ScopeId 192.168.100.0 -AllLeases | Format-Table  HostName,IPAddress,AddressState

Write-Output($leases)
# Write-Output(Get-DnsServerResourceRecord -ZoneName "howardindustries.local" -ComputerName "telperion.howardindustries.local" -RRType "A")


# Remove-DnsServerResourceRecord -ComputerName 'telperion.howardindustries.local' -ZoneName 'howardindustries.local' -Name "" -RRType "A" -RecordData "192.168.100.128"
# Remove-DhcpServerv4Lease -ComputerName 'telperion.howardindustries.local' -IPAddress ""