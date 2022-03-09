install-module PsWindowsUpdate -AllowClobber -Force
Set-ExecutionPolicy -Scope LocalMachine Bypass
# import-module PSWindowsUpdate
Enable-PSRemoting
Set-Item wsman:\localhost\client\trustedhosts HOWARD-48 -orce
Restart-Service WinRM
Get-WindowsUpdate -install -acceptall -IgnoreReboot
Set-ExecutionPolicy -Scope LocalMachine Restricted