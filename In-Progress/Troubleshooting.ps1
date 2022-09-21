# Author: Anthony Clemente
# Purpose: Troubleshooter for users
# Comments: Make solving common issues much simpler
#           Uses multithreading to accomplish multiple tasks at the same time
# Date: 7/25/2022

function Download-Updates {
    Write-Output("Starting Download Updates")
    $AdminCredentials = "anthony.clemente"
    $computer = "howard-01.howardindustries.local"

    try {
        # Scan for needed updates
        if(Test-Connection -ComputerName "howard-01.howardindustries.local") {
            Write-Output("Connection Succesful")
            # Get-Command -Module WindowsUpdateProvider
            $Updates = Start-WUScan -SearchCriteria "Type='Software' AND IsInstalled=0"
            Install-WUUpdates -Updates $Updates
            
            # Scan remote computers for needed updates
            # $u = Invoke-Command -ComputerName $computer  -ScriptBlock {Start-WUScan -SearchCriteria "UpdateId='<GUID-of-Update>' AND IsInstalled=1"} -Credential $AdminCredentials
            # Install pending updates
            # $cs = New-CimSession -ComputerName $computer -Credential $AdminCredentials
            # Install-WUUpdates -Updates $u -DownloadOnly -CimSession $cs
        }
        else {
            Write-Output("Connection Failed")
        }
    }
    catch [System.Management.Automation.RuntimeException]{
        Write-Output("Error: $_")
    }
}

function Reset-Wifi {
    ipconfig /release
    ipconfig /renew
    arp -d *
    nbtstat -R
    nbtstat -RR
    ipconfig /flushdns
    ipconfig /registerdns
}

function SFC {
    sfc /scannow
}

function Restart-Explorer {
    $proc = Get-Process | Where {$_.Name -eq "Explorer"}
    Stop-Process $proc
}

Write-Output("Starting Program")
# Download-Updates
Reset-Wifi
Restart-Explorer
SFC