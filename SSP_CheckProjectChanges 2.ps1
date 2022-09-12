# Define Global Variables
$rootDirectory = "\\SSPFIL1\Projektdaten\"

$daysToCheck = -30

$changedFiles = New-Object System.Collections.ArraysList

#SCRIPT START
Write-Host "Script gestartet - Projektaenderung werden geprueft..."

$projectFolders = Get-ChildItem -Path $rootDirectory -filter "*02_CAD*" -depth 2 | % {$_.FullName}

Write-Host -ForegroundColor Green "Folgende Projektordner wurden gefunden"
Write-Host $projectFolders

Write-Host "Bitte Teste drücken um fortzufahren"
pause

foreach ($projectFolder in $projectFolders) {
    Get-ChildItem -Path $projectFolder | Where-Object {$_.Name -Like "*02_K*" -or $_.Name -Like "*03_K*" -or $_.name -Like "05_Schema"}
    
}

pause
