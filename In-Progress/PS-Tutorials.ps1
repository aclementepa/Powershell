# Create a text file
# New-Item C:\Development\Powershell\test.txt
# Set-Content D:\temp\test\test.txt 'Welcome to TutorialsPoint'
# $content = get-Content D:\temp\test\test.txt
# Write-Output($content)

# Create a csv file
# New-Item D:\temp\test\test.csv -ItemType File
# Set-Content D:\temp\test\test.csv 'Mahesh,Suresh,Ramesh'
# $content = Get-Content D:\temp\test\test.csv
# Write-Output($content)

# Create an HTML file
# New-Item D:\temp\test\test.html -ItemType File
# Set-Content D:\temp\test\test.html '<html>Welcome to TutorialsPoint</html>'
# Get-Content D:\temp\test\test.html

# Append Data
# Add-Content D:\temp\test\test.txt 'World!'

# Erase file content
# Clear-Content D:\temp\test\test.txt

# List of Objects
# $list = "one","two","three","four","five"
# $list 
# Above outputs the entire contents of "$list"
# Sorts the list and then outputs unique values
# $list | sort | get-unique

# Properties of a text file
# get-content D:\temp\test\test.txt | measure-object -character -line -word

# Count # of items in a directory
# Get-ChildItem | Measure-Object

# Comparing files
# Compare-Object -ReferenceObject $(Get-Content D:\temp\test\test.txt) -DifferenceObject $(Get-Content D:\temp\test\test1.txt)
# Compare-Object -ReferenceObject $(Get-Content D:\temp\test\test.txt) -DifferenceObject $(Get-Content D:\temp\test\test1.txt) -IncludeEqual

# Formats a list object
# $A = Get-ChildItem D:\temp\test\*.txt

