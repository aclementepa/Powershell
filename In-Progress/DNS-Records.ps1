$a = Import-Csv -Delimiter "t" -Path "C:\Users\anthony.clemente\Desktop\temp.txt"

Write-Output($a.count)