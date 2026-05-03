<#
.SYNOPSIS
    Lägger till Obsidian block-id:n (^xxxxxx) i slutet av varje substantiellt stycke.
    Kör ENBART på råfiler som saknar block-id:n (engångskörning).

.PARAMETER FilePath
    Sökväg till markdown-filen.
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

function New-BlockId {
    $chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    return -join ((1..6) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}

$content = Get-Content -Path $FilePath -Encoding UTF8 -Raw

# Splitta på rader men behåll radslut
$lines = $content -split '(\r?\n)'

$result = [System.Text.StringBuilder]::new()
$prevWasEmpty = $true
$prevWasHeading = $false

$i = 0
while ($i -lt $lines.Count) {
    $line = $lines[$i]
    
    # Hoppa över radsluts-tokens (de är tomma strängar eller bara \r\n)
    if ($line -match '^(\r?\n)$' -or $line -eq '') {
        $result.Append($line) | Out-Null
        $prevWasEmpty = ($line -match '^\r?\n$' -or $line -eq "`n" -or $line -eq "`r`n" -or $line -eq '')
        $i++
        continue
    }

    $trimmed = $line.TrimEnd("`r", "`n")
    
    # Kolla om raden redan har ett block-id
    $hasBlockId = $trimmed -match '\s\^[a-z0-9]{6}\s*$'
    
    # Kolla om nästa "content"-rad (hoppa radslut) är tom eller rubrik
    $nextContentLine = ''
    $j = $i + 1
    while ($j -lt $lines.Count -and ($lines[$j] -match '^(\r?\n)$' -or $lines[$j] -eq '')) {
        $j++
    }
    if ($j -lt $lines.Count) {
        $nextContentLine = $lines[$j].TrimEnd("`r", "`n")
    }
    
    $isHeading = $trimmed -match '^#{1,6}\s'
    $isBullet  = $trimmed -match '^[\*\-]\s'
    $isEmpty   = ($trimmed -eq '' -or $trimmed -eq '---')
    $nextIsEmpty = ($nextContentLine -eq '' -or $nextContentLine -eq '---' -or $nextContentLine -match '^#{1,6}\s')
    
    # Lägg till block-id på substantiella stycken:
    # - Rubriker (## och ###)
    # - Avslutande meningar i stycken (text följt av tom rad eller rubrik)
    # - Ej på: separatorer, tomma rader, rader som redan har block-id, innehållsförteckning
    $shouldAddId = (
        -not $hasBlockId -and
        -not $isEmpty -and
        ($isHeading -or ($nextIsEmpty -and -not $isBullet -and $trimmed.Length -gt 20))
    )
    
    if ($shouldAddId) {
        $blockId = New-BlockId
        # Lägg till block-id på raden (ta bort befintlig radslut, lägg till ^id, lägg till radslut)
        $eol = if ($line -match '\r\n$') { "`r`n" } elseif ($line -match '\n$') { "`n" } else { '' }
        $lineContent = $trimmed
        $result.Append("$lineContent ^$blockId$eol") | Out-Null
    } else {
        $result.Append($line) | Out-Null
    }
    
    $i++
}

Set-Content -Path $FilePath -Value $result.ToString() -Encoding UTF8 -NoNewline
Write-Host "Block-id:n tillagda i: $FilePath"
