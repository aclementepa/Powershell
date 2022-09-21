# MySql Backup Script - Website database
# Creates a backup (.sql) file, stores it locally, then creates a
# compressed, encrypted (.7z) file and uploads it to our offsite FTP server.

# CMD Author: Ryan Barninger (04-08-2010)
# PS Author: Anthony Clemente (anthonyc@howardindustries.com)
# Created: 2-23-2022



# | Variable Creation             |
# ---------------------------------

# Name and password of the database user
$DbUser = "howardindustries"
$DbPass = "39n5hs83n58d"

$DMSUser = "root"
$DMSPass = "h!si9ns*dms"

$DMSDb="dms"



# Server and name of the database to backup
$DbHost="173.248.148.26"
$DbName="howardindustries"

# Directory where nightly database backup files are stored
$BkupDir="C:\Backup\MySql\Website\Night\ThisWeek"

# Directory where temporary backup files are stored
$TempBkupDir="C:\Backup\MySql\Website\Temp"


# On-site backup drive
$OnsiteBkupShareltr="y:"
$OnsiteBkupShare="\\GALATHILION\Database-Backups\Websites\Howard"
$OnsiteBkupUser="Galathilion\Admin"
$OnsiteBkupPass="h!si9ns*Galathilion"


# FTP user and password
$FtpUser="howardindustries"
$FtpPassword="d83j57n29ch4"

# Remote FTP server
$FtpServer="ftp.howardindustries.com"


# Path of 7zip compression & encryption tool
$Zip="C:\Program Files\7-Zip\7z.exe"

# Passphrase used to encrypt the zipfile.
$Passphrase="h!si9ns"
 
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
$BackupFolder = "\\GALATHILION\Database-Backups\Websites\Howard\"
$dbuser = "root"
$dbpass = "h!si9ns*dms"
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


# Backup-SqlDatabase -ServerInstance "." -Database "dms" -BackupFile ("\\GALATHILION\Database-Backups\Websites\Howard\$DMSDbName-$CurrentDate") -Incremental