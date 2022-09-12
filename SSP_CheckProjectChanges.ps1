# Define Global Variables
$fullProjectPath = "\\SSPFIL1\Projektdaten\"
$daysToCheck = -30

$changedFiles = New-Object System.Collections.ArraysList

#SCRIPT START
Write-Host "Script gestartet - Projektaenderung werden geprueft..."

$projectFolders = Get-ChildItem -Path $fullProjectPath -filter "*S-*"

Write-Host -ForegroundColor Green "Folgende Projektordner wurden gefunden"
Write-Host $projectFolders

 foreach ($projectFolder in $projectFolders){
   Get-ChildItem -filter "*02_Kälte*" 
 }


pause