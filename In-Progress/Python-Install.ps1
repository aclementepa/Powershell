Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

function Install-Chocolatey {
    # Install Chocolatey
    $script = New-Object Net.WebClient
    $script | Get-Member
    $script.DownloadString("https://chocolatey.org/install.ps1")
    
    Invoke-WebRequest "https://chocolatey.org/install.ps1" -UseBasicParsing | Invoke-Expression
    
    # Upgrade Chocolatey
    choco upgrade chocolatey
    return $true
}

function Install-Python {    
    # Install Python3 & modules for morning.py
    choco install -y python3
    pip3 install os
    pip3 install webbrowser
    return $true
}

function Install-SSH {
    $ssh = Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
    Add-WindowsCapability -Online $ssh
}
function Configure-SSH {
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'
    Get-NetFirewallRule -Name *ssh*
    FixHostFilePermissions.ps1 
    FixUserFilePermissions.ps1
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
}

$ChocoResult = Install-Chocolatey
$PythonResult = Install-Python
$HostName = $env:COMPUTERNAME
Write-Output("Results of Chocolatey Install on $HostName : $ChocoResult")
Write-Output("Results of Python Install on $HostName : $PythonResult")