param(
  [Parameter(Mandatory=$true)] [string] $Maps
)

foreach($map in Get-ChildItem($Maps)) {
  foreach($theme in Get-ChildItem($map) | where { $_.Extension -Eq '.json' }) {
    Write-Output "Processing ${theme}..."
    Get-Content $theme | node ./map-migrate-id.js ./match-mapping.json | Set-Content $theme
  }
}
