
# Reparerar filer korrupterade av det felaktiga scriptblock-skriptet.
# Tar bort de 4-radiga "scriptblock"-blocken och ersätter med tom rad.

$wikiDir = Join-Path $PSScriptRoot "..\references\wiki"
$wikiDir = [System.IO.Path]::GetFullPath($wikiDir)
$files = Get-ChildItem -Path $wikiDir -Filter "*.md" -Recurse

$repaired = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    if (-not ($content -match '\$args\[0\]\.Groups')) {
        continue
    }

    # Rensa korrupta block. Mönster (med valfri text före/efter):
    # [valfri text]
    #         $name = $args[0].Groups[1].Value
    #         $alias = $args[0].Groups[2].Value
    #         if ($alias) { "[[$name$alias]]" } else { "[[$name]]" }
    #      [valfri suffix som " (Rank 2)" osv]
    
    # Strategi: ta bort hela det korrupta blocket (rad 1 = listrad som nu är tom, plus de 3-4 raderna skriptkod)
    $lines = $content -split "\r?\n"
    $newLines = [System.Collections.Generic.List[string]]::new()
    
    $i = 0
    while ($i -lt $lines.Count) {
        $line = $lines[$i]
        
        # Kolla om nästa rad är skriptkod
        if (($i + 1) -lt $lines.Count -and $lines[$i+1] -match '^\s+\$name = \$args\[0\]\.Groups\[1\]\.Value') {
            # Hoppa över denna rad och de 3 påföljande skriptraderna
            # Eventuell suffix på rad i+4 (t.ex. " (Rank 2)") ska bevaras som en enkel kommentar
            $suffix = ""
            if (($i + 4) -lt $lines.Count) {
                $suffixLine = $lines[$i+4].Trim()
                # Behåll suffix-text om den inte är tom
                if ($suffixLine -ne "" -and $suffixLine -ne "     ") {
                    $suffix = $suffixLine
                }
            }
            # Beräkna om detta är en listrad (börjar med "- ")
            $prefix = if ($line.TrimStart() -eq "") { "- " } else { $line.TrimEnd() }
            if ($suffix -ne "") {
                $newLines.Add("$prefix$suffix")
            }
            # Hoppa förbi de 4 skriptraderna (+1 för suffix-raden)
            $i += 5
        } else {
            $newLines.Add($line)
            $i++
        }
    }
    
    $newContent = $newLines -join "`n"
    [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "Reparerad: $($file.Name)"
    $repaired++
}

Write-Host ""
Write-Host "Klar. $repaired filer reparerade."
