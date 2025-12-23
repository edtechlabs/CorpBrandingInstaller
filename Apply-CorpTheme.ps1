$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

$themePath = "C:\ProgramData\CorpTheme\Corp.theme"
$wallpaper = "C:\ProgramData\CorpTheme\CorpWallpaper.jpg"

if (!(Test-Path $themePath) -or !(Test-Path $wallpaper)) { exit 0 }

# Force dark mode (per-user)
$personalize = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
New-Item -Path $personalize -Force | Out-Null
Set-ItemProperty -Path $personalize -Name "AppsUseLightTheme" -Type DWord -Value 0
Set-ItemProperty -Path $personalize -Name "SystemUsesLightTheme" -Type DWord -Value 0

# Clear common caches that can override theme/wallpaper
$keysToRemove = @(
  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\CachedFiles",
  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers"
)
foreach ($k in $keysToRemove) {
  if (Test-Path $k) { Remove-Item $k -Recurse -Force }
}

# Apply theme (silent)
Start-Process -FilePath $themePath -WindowStyle Hidden

# Force wallpaper immediately
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value "10"  # Fill
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name TileWallpaper -Value "0"

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class NativeMethods {
  [DllImport("user32.dll", SetLastError=true)]
  public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[NativeMethods]::SystemParametersInfo(20, 0, $wallpaper, 1 -bor 2) | Out-Null
