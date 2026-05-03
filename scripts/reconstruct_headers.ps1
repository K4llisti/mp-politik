
Set-Location (Split-Path $PSScriptRoot)

$fileSourceMap = @{
    "Arbetsmarknad"                = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Demokrati"                    = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Ekonomi"                      = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Energi"                       = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Internationell solidaritet"   = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Jordbruk"                     = @("[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Kultur och civilsamhalle"     = @("[[Kulturpolitiskt program 2018]] (Rank 2)", "[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
    "Samhallsbygge och infrastruktur" = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Klimatfardplan 2021]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")
}

# Default for all others (only HP2026 + PP2025)
$defaultSources = @("[[Politiskt Handlingsprogram 2026-2030]] (Rank 2)", "[[Partiprogram 2025]] (Rank 1)")

$wikiSak = "references\wiki\sakområden"
$files = Get-ChildItem -Path $wikiSak -Filter "*.md"

foreach ($file in $files) {
    $lines = [System.IO.File]::ReadAllLines($file.FullName, [System.Text.Encoding]::UTF8)
    
    $hasEmpty = ($lines | Where-Object { $_ -match '^-\(Rank' }).Count -gt 0
    if (-not $hasEmpty) { continue }
    
    # Normalize basename for map lookup
    $baseName = $file.BaseName -replace '[åäÅÄ]','a' -replace '[öÖ]','o' -replace 'é','e'
    $sources = $fileSourceMap[$baseName]
    if (-not $sources) { $sources = $defaultSources }
    
    $newLines = [System.Collections.Generic.List[string]]::new()
    $i = 0
    $replacedHeader = $false
    
    while ($i -lt $lines.Count) {
        $line = $lines[$i]
        
        if (-not $replacedHeader -and $line -match '\*\*Huvud') {
            $newLines.Add($line)
            foreach ($src in $sources) {
                $newLines.Add("- $src")
            }
            $replacedHeader = $true
            $i++
            # Skip empty -(Rank X) lines and blank lines that separate them
            while ($i -lt $lines.Count -and $lines[$i] -match '^-\(Rank') {
                $i++
            }
            # Skip one trailing blank line if present
            if ($i -lt $lines.Count -and $lines[$i] -eq "") {
                $newLines.Add("")
                $i++
            }
            continue
        }
        
        $newLines.Add($line)
        $i++
    }
    
    [System.IO.File]::WriteAllLines($file.FullName, $newLines, [System.Text.Encoding]::UTF8)
    Write-Host "Restored: $($file.Name)"
}

Write-Host ""
Write-Host "Done!"
