$files = Get-ChildItem -Path "references/wiki" -Recurse -Include "*.md"
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $newContent = $content -replace '\[\[mp-ai-wiki/references/raw/', '[[references/raw/'
    $newContent = $newContent -replace '\[\[references/raw/miljopartiets-partiprogram-2025\.md', '[[references/raw/program/miljopartiets-partiprogram-2025.md'
    if ($content -ne $newContent) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent)
        Write-Output "Modified: $($file.FullName)"
    }
}
