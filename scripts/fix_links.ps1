
$wikiDir = Join-Path $PSScriptRoot "..\references\wiki"
$wikiDir = [System.IO.Path]::GetFullPath($wikiDir)
$files = Get-ChildItem -Path $wikiDir -Filter "*.md" -Recurse

foreach ($file in $files) {
    $lines = [System.IO.File]::ReadAllLines($file.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false
    $newLines = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        $newLine = $line

        # 1. Raw-lank: [[references/raw/ -> [[mp-ai-wiki/references/raw/
        if ($newLine -match '\[\[references/raw/') {
            $newLine = $newLine -replace '\[\[references/raw/', '[[mp-ai-wiki/references/raw/'
            $changed = $true
        }

        # 2. Wiki->wiki med alias: [[references/wiki/FOLDER/NAMN|ALIAS]] -> [[NAMN|ALIAS]]
        $pattern2 = '\[\[references/wiki/[^/]+/([^\]|]+)\|([^\]]+)\]\]'
        while ($newLine -match $pattern2) {
            $full = $Matches[0]
            $namn = $Matches[1]
            $alias = $Matches[2]
            $newLine = $newLine.Replace($full, "[[$namn|$alias]]")
            $changed = $true
        }

        # 3. Wiki->wiki utan alias: [[references/wiki/FOLDER/NAMN]] -> [[NAMN]]
        $pattern3 = '\[\[references/wiki/[^/]+/([^\]|]+)\]\]'
        while ($newLine -match $pattern3) {
            $full = $Matches[0]
            $namn = $Matches[1]
            $newLine = $newLine.Replace($full, "[[$namn]]")
            $changed = $true
        }

        $newLines.Add($newLine)
    }

    if ($changed) {
        [System.IO.File]::WriteAllLines($file.FullName, $newLines, [System.Text.Encoding]::UTF8)
        Write-Host "Fixad: $($file.Name)"
    }
}

Write-Host ""
Write-Host "Klar!"
