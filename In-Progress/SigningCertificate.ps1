$ProgramName=$args[0]
# Generate a self-signed Authenticode certificate in the local computer's personal certificate store.
$authenticode = New-SelfSignedCertificate -Subject $ProgramName -CertStoreLocation Cert:\LocalMachine\My -Type CodeSigningCert

# Add the self-signed Authenticode certificate to the computer's root certificate store.
## Create an object to represent the LocalMachine\Root certificate store.
$rootStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root","LocalMachine")
## Open the root certificate store for reading and writing.
 $rootStore.Open("ReadWrite")
## Add the certificate stored in the $authenticode variable.
 $rootStore.Add($authenticode)
## Close the root certificate store.
 $rootStore.Close()
 
# Add the self-signed Authenticode certificate to the computer's trusted publishers certificate store.
## Create an object to represent the LocalMachine\TrustedPublisher certificate store.
 $publisherStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("TrustedPublisher","LocalMachine")
## Open the TrustedPublisher certificate store for reading and writing.
 $publisherStore.Open("ReadWrite")
## Add the certificate stored in the $authenticode variable.
 $publisherStore.Add($authenticode)
## Close the TrustedPublisher certificate store.
 $publisherStore.Close()

 # Confirm if the self-signed Authenticode certificate exists in the computer's Personal certificate store
 Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq $ProgramName}
# Confirm if the self-signed Authenticode certificate exists in the computer's Root certificate store
 Get-ChildItem Cert:\LocalMachine\Root | Where-Object {$_.Subject -eq $ProgramName}
# Confirm if the self-signed Authenticode certificate exists in the computer's Trusted Publishers certificate store
 Get-ChildItem Cert:\LocalMachine\TrustedPublisher | Where-Object {$_.Subject -eq $ProgramName}

 # Get the code-signing certificate from the local computer's certificate store with the name *ATA Authenticode* and store it to the $codeCertificate variable.
$codeCertificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq $ProgramName}

# Sign the PowerShell script
# PARAMETERS:
# FilePath - Specifies the file path of the PowerShell script to sign, eg. C:\Development\Powershell\SigningCertificate.ps1
# Certificate - Specifies the certificate to use when signing the script.
# TimeStampServer - Specifies the trusted timestamp server that adds a timestamp to your script's digital signature. Adding a timestamp ensures that your code will not expire when the signing certificate expires.
Set-AuthenticodeSignature -FilePath C:\Development\Powershell\$ProgramName -Certificate $codeCertificate -TimeStampServer http://timestamp.digicert.com
# SIG # Begin signature block
# MIIR5AYJKoZIhvcNAQcCoIIR1TCCEdECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUPYf3ZN7/dlh86CSttcjt63Nx
# UGGggg1HMIIDDDCCAfSgAwIBAgIQGLtLpYJGI4BIErFp7bugHzANBgkqhkiG9w0B
# AQsFADAeMRwwGgYDVQQDDBNTaWduaW5nX0NlcnRpZmljYXRlMB4XDTIxMDYyOTE1
# Mjg0NFoXDTIyMDYyOTE1NDg0NFowHjEcMBoGA1UEAwwTU2lnbmluZ19DZXJ0aWZp
# Y2F0ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMoGrDqHoiFBX3Jn
# kiM3QeGisQm1XXZXBIPhuLRqkjDvE1dhg8kLl5Q/Ks8t0S3hIg0g7CGCyNjg1S19
# bSXKOyGcR4PAAfBXDeE+NPA4hV+LwI5tVAC87IwGBSIRmjXgJIfL3kSeX2ixx0qe
# iLlsrGST2VTiF0I7nbJv9NJoPzXGBVWqZ+DGUMwCZPRL7skaeFWRdVtqQbxBeOgn
# C3hVm1OCXWnaxtBru/Ve9ihOgm+yo7zokJjT/AQc//APd98c3QWbJGqUStVv2vCr
# 6oCYmcG9X+jRnQ6NzlWb8tlX1bihOySHKmbuU3iF2asXhHOt2YAjt44IyFrESYBY
# RYYSckkCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBSdcOyfYJvs/2wEc3RN70hLMfcESzANBgkqhkiG9w0BAQsF
# AAOCAQEAvY5vN2QT+05X3l3KoDzqxDN1aFndUrmIu96EYBkqgZmL9va/Be4f2O61
# Xo38yeZOC+WTbQCOERJ4ODDjvfKyRIc+1xHfJ/dHCQtIyCffIfeCYVh70BYUMCsA
# 3ElvMJqSz9Uf773qUA87ybq+e0IjIuyi6dpap4RSbFXD4K+0YSeq/1lS8SNCSREy
# YATKXd/TDdrZE+PJY66zRkc3RV72kCdRoJc8mfn9/WSEcBHDPz/PkvIXLXTgXnfc
# WVVfdijat3p9L8vt5lEWsA4J1ZiqjkwRfpDbjwzRJPgY78pBEGVf4wstB73I8VoK
# v/LD53lblwhPCq9bLf/xXBW9R16NmTCCBP4wggPmoAMCAQICEA1CSuC+Ooj/YEAh
# zhQA8N0wDQYJKoZIhvcNAQELBQAwcjELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERp
# Z2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8GA1UEAxMo
# RGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIFRpbWVzdGFtcGluZyBDQTAeFw0yMTAx
# MDEwMDAwMDBaFw0zMTAxMDYwMDAwMDBaMEgxCzAJBgNVBAYTAlVTMRcwFQYDVQQK
# Ew5EaWdpQ2VydCwgSW5jLjEgMB4GA1UEAxMXRGlnaUNlcnQgVGltZXN0YW1wIDIw
# MjEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDC5mGEZ8WK9Q0IpEXK
# Y2tR1zoRQr0KdXVNlLQMULUmEP4dyG+RawyW5xpcSO9E5b+bYc0VkWJauP9nC5xj
# /TZqgfop+N0rcIXeAhjzeG28ffnHbQk9vmp2h+mKvfiEXR52yeTGdnY6U9HR01o2
# j8aj4S8bOrdh1nPsTm0zinxdRS1LsVDmQTo3VobckyON91Al6GTm3dOPL1e1hyDr
# Do4s1SPa9E14RuMDgzEpSlwMMYpKjIjF9zBa+RSvFV9sQ0kJ/SYjU/aNY+gaq1ux
# HTDCm2mCtNv8VlS8H6GHq756WwogL0sJyZWnjbL61mOLTqVyHO6fegFz+BnW/g1J
# hL0BAgMBAAGjggG4MIIBtDAOBgNVHQ8BAf8EBAMCB4AwDAYDVR0TAQH/BAIwADAW
# BgNVHSUBAf8EDDAKBggrBgEFBQcDCDBBBgNVHSAEOjA4MDYGCWCGSAGG/WwHATAp
# MCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwHwYDVR0j
# BBgwFoAU9LbhIB3+Ka7S5GGlsqIlssgXNW4wHQYDVR0OBBYEFDZEho6kurBmvrwo
# LR1ENt3janq8MHEGA1UdHwRqMGgwMqAwoC6GLGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
# LmNvbS9zaGEyLWFzc3VyZWQtdHMuY3JsMDKgMKAuhixodHRwOi8vY3JsNC5kaWdp
# Y2VydC5jb20vc2hhMi1hc3N1cmVkLXRzLmNybDCBhQYIKwYBBQUHAQEEeTB3MCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTwYIKwYBBQUHMAKG
# Q2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVk
# SURUaW1lc3RhbXBpbmdDQS5jcnQwDQYJKoZIhvcNAQELBQADggEBAEgc3LXpmiO8
# 5xrnIA6OZ0b9QnJRdAojR6OrktIlxHBZvhSg5SeBpU0UFRkHefDRBMOG2Tu9/kQC
# Zk3taaQP9rhwz2Lo9VFKeHk2eie38+dSn5On7UOee+e03UEiifuHokYDTvz0/rdk
# d2NfI1Jpg4L6GlPtkMyNoRdzDfTzZTlwS/Oc1np72gy8PTLQG8v1Yfx1CAB2vIEO
# +MDhXM/EEXLnG2RJ2CKadRVC9S0yOIHa9GCiurRS+1zgYSQlT7LfySmoc0NR2r1j
# 1h9bm/cuG08THfdKDXF+l7f0P4TrweOjSaH6zqe/Vs+6WXZhiV9+p7SOZ3j5Npjh
# yyjaW4emii8wggUxMIIEGaADAgECAhAKoSXW1jIbfkHkBdo2l8IVMA0GCSqGSIb3
# DQEBCwUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAX
# BgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3Vy
# ZWQgSUQgUm9vdCBDQTAeFw0xNjAxMDcxMjAwMDBaFw0zMTAxMDcxMjAwMDBaMHIx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJ
# RCBUaW1lc3RhbXBpbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQC90DLuS82Pf92puoKZxTlUKFe2I0rEDgdFM1EQfdD5fU1ofue2oPSNs4jkl79j
# IZCYvxO8V9PD4X4I1moUADj3Lh477sym9jJZ/l9lP+Cb6+NGRwYaVX4LJ37AovWg
# 4N4iPw7/fpX786O6Ij4YrBHk8JkDbTuFfAnT7l3ImgtU46gJcWvgzyIQD3XPcXJO
# Cq3fQDpct1HhoXkUxk0kIzBdvOw8YGqsLwfM/fDqR9mIUF79Zm5WYScpiYRR5oLn
# RlD9lCosp+R1PrqYD4R/nzEU1q3V8mTLex4F0IQZchfxFwbvPc3WTe8GQv2iUypP
# hR3EHTyvz9qsEPXdrKzpVv+TAgMBAAGjggHOMIIByjAdBgNVHQ4EFgQU9LbhIB3+
# Ka7S5GGlsqIlssgXNW4wHwYDVR0jBBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8w
# EgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYI
# KwYBBQUHAwgweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
# cC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2lj
# ZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwgYEGA1UdHwR6MHgw
# OqA4oDaGNGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJ
# RFJvb3RDQS5jcmwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwUAYDVR0gBEkwRzA4BgpghkgBhv1sAAIE
# MCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwCwYJ
# YIZIAYb9bAcBMA0GCSqGSIb3DQEBCwUAA4IBAQBxlRLpUYdWac3v3dp8qmN6s3jP
# BjdAhO9LhL/KzwMC/cWnww4gQiyvd/MrHwwhWiq3BTQdaq6Z+CeiZr8JqmDfdqQ6
# kw/4stHYfBli6F6CJR7Euhx7LCHi1lssFDVDBGiy23UC4HLHmNY8ZOUfSBAYX4k4
# YU1iRiSHY4yRUiyvKYnleB/WCxSlgNcSR3CzddWThZN+tpJn+1Nhiaj1a5bA9Fhp
# DXzIAbG5KHW3mWOFIoxhynmUfln8jA/jb7UBJrZspe6HUSHkWGCbugwtK22ixH67
# xCUrRwIIfEmuE7bhfEJCKMYYVs9BNLZmXbZ0e/VWMyIvIjayS6JKldj1po5SMYIE
# BzCCBAMCAQEwMjAeMRwwGgYDVQQDDBNTaWduaW5nX0NlcnRpZmljYXRlAhAYu0ul
# gkYjgEgSsWntu6AfMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgACh
# AoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAM
# BgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBTbMvNClcFhzJHGhORff4z7C50c
# STANBgkqhkiG9w0BAQEFAASCAQABtgviN8oxqkKKFEpI2/xgUbs2thouulweOaFo
# 31MjtFfsOHmdebEiy+paBVIJiQjrgkb2z4zKgcIHeXRXkEyfE7iNtcJfMHdPjwej
# ZThYur67K3uZddKnfXsqSMO3YI+DQOeUkvKidEHgtmFcKQbdDCbBMx2gZ/Wawd7i
# NnnHog4K5D+fgin/MZ7h+tjWOVgw171ASwx3qbiDNTFrRN60CqY6NT+1LwYBIX43
# OYEgPKGpuuQR014etNY7xf40C633p1dfU+9gfrVE3x25M5A3MRDRj2UnjI/lhxVd
# LDixepGLilCu+qESfnSzcowd8RPg+MeQn+Qcd1TaWHst5bW4oYICMDCCAiwGCSqG
# SIb3DQEJBjGCAh0wggIZAgEBMIGGMHIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
# aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xMTAvBgNVBAMT
# KERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBUaW1lc3RhbXBpbmcgQ0ECEA1CSuC+
# Ooj/YEAhzhQA8N0wDQYJYIZIAWUDBAIBBQCgaTAYBgkqhkiG9w0BCQMxCwYJKoZI
# hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA2MjkxNTQxMTlaMC8GCSqGSIb3DQEJ
# BDEiBCDN7OtTrcf9I7WY9S+O8T2VtttMUTFeyWv/KPsfYyhcTzANBgkqhkiG9w0B
# AQEFAASCAQBqZPkP82cNh/ArxhgMvU1seEFnKwNAMDVHGqMgeqgbH6Houfye9Zc8
# SGGTqH2xJgwrYWkGu2VQyO0Orc20SWWPzPmuToC3Ocgk/8Y8+sn3g0aeKk94xiFt
# 6nqPvK5c/j6b9Mj2/Kz5yjBGFxIw66ExMzXQPp1lt57TGKbh7dYAz20BeMvsVcJ4
# 60xyU13u0IPURR24/LwR+owRo867EXwlltFtYc5WUEb9FKPRbzfLiyhjDxF8xkML
# hgaNBUfeWFPgB94vyvj3+NkDWI7JhFPuPzHoUVAfrjH9VWy61Pk2SmAEYoopCUiz
# IZX0qz79Jjpmslec16/wGgyPztpasbMe
# SIG # End signature block
