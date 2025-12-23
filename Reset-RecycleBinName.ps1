$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

$clsid = "{645FF040-5081-101B-9F08-00AA002F954E}"

$paths = @(
  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\$clsid",
  "HKCU:\Software\Classes\CLSID\$clsid"
)

foreach ($p in $paths) {
  if (Test-Path $p) {
    Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue
  }
}

# Optional Explorer refresh (commented out to avoid flicker)
# Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
# Start-Process explorer.exe
