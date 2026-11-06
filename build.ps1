<#
  Builds SpellCoach.html by embedding "Word List Name.txt" into the template.
  Run again whenever the word list file changes:  .\build.ps1
#>
param(
  [string]$Template = (Join-Path $PSScriptRoot 'src\SpellCoach.template.html'),
  [string]$WordList = (Join-Path $PSScriptRoot 'Word List Name.txt'),
  [string]$Out      = (Join-Path $PSScriptRoot 'SpellCoach.html')
)
$ErrorActionPreference = 'Stop'
$marker = '/*__WORD_LISTS__*/""'
$tpl = Get-Content -LiteralPath $Template -Raw -Encoding UTF8
if (-not $tpl.Contains($marker)) { throw "Marker $marker not found in $Template" }
$txt = Get-Content -LiteralPath $WordList -Raw -Encoding UTF8
$json = ConvertTo-Json -InputObject $txt -Compress
$html = $tpl.Replace($marker, $json)
[IO.File]::WriteAllText($Out, $html, [Text.UTF8Encoding]::new($false))
$count = ($txt -split "`r?`n" | Where-Object { $_.Trim() -and $_.Trim() -ne 'Word List Name' }).Count
Write-Host "Built $Out with $count word lists."
