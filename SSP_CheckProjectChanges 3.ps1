# Define Global Variables
$rootDirectory = "\\SSPFIL1\Projektdaten\"
$time = Get-Date


#SCRIPT START
Write-Host "Script gestartet - Projektaenderung werden geprueft..."

$projectFolders = Get-ChildItem -Path $rootDirectory -filter "*02_CAD*" -depth 2 | % {$_.FullName}

Write-Host -ForegroundColor Green "Folgende Projektordner wurden gefunden"
Write-Host $projectFolders

Write-Host "Bitte Teste drücken um fortzufahren"
pause

foreach ($projectFolder in $projectFolders) {
   $targetFolders = Get-ChildItem -Path $projectFolder | Where-Object {$_.Name -Like "*02_K*" -or $_.Name -Like "*03_K*" -or $_.name -Like "05_Schema"}
foreach ($targetFolder in $targetFolders) {
    
    $fullPath = join-path -path $projectFolder -childpath $targetFolder
    $overdueFiles = Get-ChildItem -Path $fullPath | Where-Object {($_.LastWriteTime -lt $time) -and ($_.extension -like ".pdf")} | out-file -append C:\csfinstall\csf.csv | Export-Csv -Path C:\csfinstall\csv.csf -NoTypeInformation -Delimiter ","
    Write-host $overdueFiles
}
}

pause
