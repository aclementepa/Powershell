Set-DNSClientServerAddress "Ethernet" –ServerAddresses ("192.168.100.8", "192.168.100.2")
add-computer -domainname howard-industries.local -Credential HOWARD-IND\ADMINISTRATOR -restart –force