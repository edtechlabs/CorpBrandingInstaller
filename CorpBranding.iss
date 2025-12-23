[Setup]
AppName=Corporate Branding Pack
DefaultDirName={commonappdata}\CorpTheme
AppVersion=1.0
PrivilegesRequired=admin
DisableProgramGroupPage=yes
OutputBaseFilename=CorpBrandingInstaller
Compression=lzma
SolidCompression=yes

; Optional installer icon (remove these two lines if you don't use an .ico)
SetupIconFile=CorpTheme.ico
UninstallDisplayIcon={commonappdata}\CorpTheme\CorpTheme.ico

[Files]
; --- Corporate theme assets ---
Source: "CorpWallpaper.jpg"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion
Source: "Corp.theme"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion
Source: "Apply-CorpTheme.ps1"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion
Source: "Install-CorpThemeTask.ps1"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion
Source: "Uninstall-CorpThemeTask.ps1"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion

; Optional icon installed for uninstall display
Source: "CorpTheme.ico"; DestDir: "{commonappdata}\CorpTheme"; Flags: ignoreversion

; --- Recycle Bin assets ---
Source: "Reset-RecycleBinName.ps1"; DestDir: "{commonappdata}\RecycleBinReset"; Flags: ignoreversion
Source: "Install-RecycleBinTask.ps1"; DestDir: "{commonappdata}\RecycleBinReset"; Flags: ignoreversion
Source: "Uninstall-RecycleBinTask.ps1"; DestDir: "{commonappdata}\RecycleBinReset"; Flags: ignoreversion

[Run]
; 1) Create/refresh BOTH scheduled tasks (for all future logons)
Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\CorpTheme\Install-CorpThemeTask.ps1"""; \
  Flags: runhidden waituntilterminated

Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\RecycleBinReset\Install-RecycleBinTask.ps1"""; \
  Flags: runhidden waituntilterminated

; 2) Apply BOTH immediately for the currently logged-on user (HKCU)
Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\CorpTheme\Apply-CorpTheme.ps1"""; \
  Flags: runhidden waituntilterminated

Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\RecycleBinReset\Reset-RecycleBinName.ps1"""; \
  Flags: runhidden waituntilterminated

[UninstallRun]
; Remove BOTH scheduled tasks during uninstall
Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\CorpTheme\Uninstall-CorpThemeTask.ps1"""; \
  Flags: runhidden waituntilterminated

Filename: "powershell.exe"; \
  Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{commonappdata}\RecycleBinReset\Uninstall-RecycleBinTask.ps1"""; \
  Flags: runhidden waituntilterminated
