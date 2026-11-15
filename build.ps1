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

# Keep the current-year spelling lists at the top of the missions map.
$oldZone = "  {id:'hq2026', match:/^2026 spelling words$/, group:'missions', order:1, short:'2026 Spelling Words', names:{city:'City Hall',space:'Mission Control',castle:'Royal Court',chess:`" + "`" + "King's Court`" + "`" + ",diving:'Dive Base'}, icons:{city:'🏛️',space:'🛰️',castle:'👑',chess:'♔',diving:'⚓'}},"
$newZones = @"
  {id:'hq2027', match:/^2027 spelling words`$/, group:'missions', order:1, short:'2027 Spelling Words', names:{city:'2027 Spelling Words',space:'2027 Spelling Words',castle:'2027 Spelling Words',chess:'2027 Spelling Words',diving:'2027 Spelling Words'}, icons:{city:'🆕',space:'🆕',castle:'🆕',chess:'🆕',diving:'🆕'}},
  {id:'hq2026', match:/^2026 spelling words`$/, group:'missions', order:2, short:'2026 Spelling Words', names:{city:'City Hall',space:'Mission Control',castle:'Royal Court',chess:`" + "`" + "King's Court`" + "`" + ",diving:'Dive Base'}, icons:{city:'🏛️',space:'🛰️',castle:'👑',chess:'♔',diving:'⚓'}},
"@
$newZones = $newZones.TrimEnd("`r", "`n")
if ($tpl.Contains($oldZone)) {
  $tpl = $tpl.Replace($oldZone, $newZones)
  [IO.File]::WriteAllText($Template, $tpl, [Text.UTF8Encoding]::new($false))
} elseif (-not $tpl.Contains("id:'hq2027'")) {
  throw 'Could not find the 2026 spelling-words zone to update in the template.'
}

$txt = Get-Content -LiteralPath $WordList -Raw -Encoding UTF8
$escaped = $txt.Replace('\','\\').Replace('"','\"').Replace("`r",'\r').Replace("`n",'\n').Replace("`t",'\t')
$json = '"' + $escaped + '"'
$html = $tpl.Replace($marker, $json)
[IO.File]::WriteAllText($Out, $html, [Text.UTF8Encoding]::new($false))
$count = ($txt -split "`r?`n" | Where-Object { $_.Trim() -and $_.Trim() -notmatch '^word list name$' -and $_.Trim() -notmatch '^word list word list name$' }).Count
Write-Host "Built $Out with $count word lists."
