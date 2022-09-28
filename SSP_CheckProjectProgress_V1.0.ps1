# Define Global Variables
# Name: SSP_CheckProjectProgress_V1.0.ps1
# Version: 1.0
# Autor: Thomas Lipp | CSF AG

# GLOBAL VARIABLES
$rootDirectory = "\\SSPFIL1\Projektdaten\"
$date = Get-Date
$time = $date.AddDays(-30)


#SCRIPT START
Write-Host "Script gestartet - Projektaenderung werden geprueft..."

# Auslesen aller Ordner mit dem Namen 02_CAD zwei Hierarchiestufen vom Root Verzeichnis
$projectFolders = Get-ChildItem -Path $rootDirectory -filter "*02_CAD*" -depth 2 | % { $_.FullName }

Write-Host -ForegroundColor Green "Zielordner wurden erfolgreich ausgelesen"

# Auslesen der Zielordner im Ordner 02_CAD
foreach ($projectFolder in $projectFolders) {
    $targetFolders = Get-ChildItem -Path $projectFolder | Where-Object { $_.Name -Like "*02_K*" -or $_.Name -Like "*03_K*" -or $_.name -Like "05_Schema" }
    # Zusammensetzen der Teilpfade zu einem vollständigen Pfad
    foreach ($targetFolder in $targetFolders) {
        $fullPath = join-path -path $projectFolder -childpath $targetFolder

        # Auslesen aller PDF Files neuer als 30 Tage & Export in CSV-Datei
        foreach ($path in $fullPath) {
            $overdueFiles = Get-ChildItem -Path $fullPath | Where-Object { ($_.LastWriteTime -gt $time) -and ($_.extension -like ".pdf") } | out-file -append C:\csfinstall\csf.csv | Export-Csv -Path  C:\csfinstall\output.csv -NoTypeInformation -Append -Verbose -Delimiter "," 
            Write-host $overdueFiles
        }

    }
}