# Define Global Variables
# Name: SSP_CheckProjectProgress_V2.0.ps1
# Version: 2.0
# Autor: Thomas Lipp, Michel Barmasse | CSF AG

# GLOBAL VARIABLES
$rootDirectory = "\\SSPFIL1\Projektdaten\"
$date = Get-Date
$time = $date.AddDays(-30)
$reportOutput = "D:\Daten\Sekretariat\06 IT\_Rapports\Projektreport.csv"


#SCRIPT START
Write-Host "Script wurde gestartet"

# Löschen der vorhandenen Reportdatei
Write-Host "Veraltete Reportdatei wird gelöscht."
Remove-Item -Path $reportOutput

# Auslesen aller Ordner mit dem Namen 02_CAD zwei Hierarchiestufen vom Root Verzeichnis
Write-Host "Projektänderungen werden ausgelesen."
$projectFolders = Get-ChildItem -Path $rootDirectory -filter "*02_CAD*" -depth 2 | % { $_.FullName }



# Auslesen der Zielordner im Ordner 02_CAD
foreach ($projectFolder in $projectFolders) {
    $targetFolders = Get-ChildItem -Path $projectFolder -Recurse | Where-Object { $_.Name -Contains "Kälte" -or $_.Name -Like "03_Kühlraum" -or $_.name -Like "05_Schema" }
    
    # Zusammensetzen der Teilpfade zu einem vollstÃ¤ndigen Pfad
 foreach ($targetFolder in $targetFolders) {
        $fullPath = join-path -path $projectFolder -childpath $targetFolder

        # Auslesen aller PDF Files neuer als 30 Tage & Export in CSV-Datei
        foreach ($path in $fullPath) {
            $overdueFiles = Get-ChildItem -Path $fullPath -Recurse | Where-Object { ($_.LastWriteTime -gt $time) -and ($_.extension -like ".pdf") } | out-file -append $reportOutput 
        
        }

    }
}