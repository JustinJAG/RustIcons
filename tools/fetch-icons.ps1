param(
  [Parameter(Mandatory=$false)][string]$ShortnamesPath = "$(Join-Path (Split-Path $PSScriptRoot -Parent) 'IRM_Shortnames.txt')",
  [Parameter(Mandatory=$false)][string]$Pattern = "https://files.facepunch.com/garry/1/2021/ItemIcons/{id}.png",
  [Parameter(Mandatory=$false)][string]$OutputDir = "$(Join-Path (Split-Path $PSScriptRoot -Parent) 'icons')"
)
if (!(Test-Path $OutputDir)) { New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null }
if (!(Test-Path $ShortnamesPath)) { Write-Host "Shortnames file not found: $ShortnamesPath"; exit 1 }
$shorts = Get-Content $ShortnamesPath | Where-Object { $_ -and -not $_.StartsWith('#') } | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$downloaded = 0
foreach ($sn in $shorts) {
  $url = $Pattern.Replace('{id}', $sn)
  $out = Join-Path $OutputDir ("$sn.png")
  try {
    Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop
    $downloaded++
  } catch {
    # skip
  }
}
Write-Host "Downloaded $downloaded icons to $OutputDir"
