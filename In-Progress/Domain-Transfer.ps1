Set-DNSClientServerAddress "Ethernet" –ServerAddresses ("192.168.100.8", "192.168.100.2")
add-computer -domainname domain.local -Credential DOMAIN\ADMINISTRATOR -restart –force