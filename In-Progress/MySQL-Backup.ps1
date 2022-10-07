# MySql Backup Script - Website database
# Creates a backup (.sql) file, stores it locally, then creates a
# compressed, encrypted (.7z) file and uploads it to our offsite FTP server.

# PS Author: Anthony Clemente (anthonyc@howardindustries.com)
# Created: 2-23-2022



# | Variable Creation             |
# ---------------------------------

# Name and password of the database user
$DbUser = "user"
$DbPass = "odsiuafldsohflaksfjd"

$DMSUser = "root"
$DMSPass = "odsiuafldsohflaksfjd"

$DMSDb="database"



# Server and name of the database to backup
$DbHost="293.239.281.30"
$DbName="database"

# Directory where nightly database backup files are stored
$BkupDir="C:\Backup\MySql\Website\Night\ThisWeek"

# Directory where temporary backup files are stored
$TempBkupDir="C:\Backup\MySql\Website\Temp"


# On-site backup drive
$OnsiteBkupShareltr="y:"
$OnsiteBkupShare="\\tester\Database-Backups\Websites"
$OnsiteBkupUser="tester\Admin"
$OnsiteBkupPass="dafsdfadfasdf"


# FTP user and password
$FtpUser="user"
$FtpPassword="odsiuafldsohflaksfjd"

# Remote FTP server
$FtpServer="ftp.website.com"


# Path of 7zip compression & encryption tool
$Zip="C:\Program Files\7-Zip\7z.exe"

# Passphrase used to encrypt the zipfile.
$Passphrase="passphrase"
 
# Get Current Date
$CurrentDate = Get-Date -Format "yyyymmdd HH:mm"
$BackupFileName = 

# | Script Operations             |
# ---------------------------------



#|  MYSQL BACKUP & COMPRESSION    |
# ---------------------------------
Write-Host "[INFO] Start Backup-SQL-Database"
Write-Host "[INFO] Server: $SqlServer"
Write-Host "[INFO] Database: $SqlDatabase"

# MySql Binaries Directory
$MySqlDir="C:\Program Files\MySQL\MySQL Server 8.0"
$BackupFolder = "\\tester\Database-Backups\Websites\"
$dbuser = "root"
$dbpass = "odsiuafldsohflaksfjd"
$BackupDate = Get-Date -Format "yyyymmdd HH:mm"

# Query and backup MySQL Databases
try {
    Set-Location "$MySqlDir\bin"
        &amp; .\mysql.exe -N -s -r -u $dbuser -p$dbpass -e 'show databases' | % {
        &amp; .\mysqldump.exe -u $dbuser -p$dbpass --single-transaction $_ |
        Out-File "$BackupFolder\${_}$BackupDate.sql" -Encoding Ascii
    }
    Write-Host("Backup successful")
}catch{
    Write-Host("Backup failed")
}