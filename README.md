# Corporate Branding Installer (Windows 11)

This project provides a **single Windows installer** that enforces corporate branding on Windows 11 machines by:

- Applying a **corporate theme**
- Forcing **dark mode** (Windows + apps)
- Setting a **corporate wallpaper**
- Resetting the **Recycle Bin name** to its default value
- Enforcing all of the above **at every user logon**
- Applying changes **immediately during installation** for the currently logged-on user

The solution works for **admin and standard users** and requires admin rights **only once** during installation.

---

## How it works (high level)

- The installer copies scripts and assets to `C:\ProgramData`
- Two **hidden Scheduled Tasks** are created:
  - **Apply Corporate Theme** → runs at every logon
  - **Reset Recycle Bin Name** → runs at every logon
- During installation, both scripts are executed **once immediately** for the active user
- All future logons are handled automatically by the scheduled tasks

No Group Policy or domain membership is required.

---

## Features

- ✔ Windows 11 compatible
- ✔ Silent execution (no PowerShell windows, no prompts)
- ✔ Works for all users
- ✔ Survives reboots and updates
- ✔ Supports silent installation
- ✔ Clean uninstall (removes scheduled tasks)

---

## Folder structure

```
CorpBrandingInstaller/
│
├─ CorpBranding.iss
├─ CorpWallpaper.jpg
├─ CorpTheme.ico            (optional)
│
├─ Corp.theme
├─ Apply-CorpTheme.ps1
├─ Install-CorpThemeTask.ps1
├─ Uninstall-CorpThemeTask.ps1
│
├─ Reset-RecycleBinName.ps1
├─ Install-RecycleBinTask.ps1
├─ Uninstall-RecycleBinTask.ps1
```

---

## What gets installed on the target machine

```
C:\ProgramData\
├─ CorpTheme\
│  ├─ CorpWallpaper.jpg
│  ├─ Corp.theme
│  ├─ Apply-CorpTheme.ps1
│
├─ RecycleBinReset\
│  ├─ Reset-RecycleBinName.ps1
```

Two scheduled tasks are created:

- **Apply Corporate Theme**
- **Reset Recycle Bin Name**

Both are:
- Triggered **At logon**
- Run for **all users**
- Run with **highest privileges**
- Hidden from the UI

---

## Requirements

- Windows 11
- Local administrator rights (for installation only)
- Inno Setup (to build the installer)

---

## Building the installer

1. Install **Inno Setup**  
   https://jrsoftware.org/isinfo.php

2. Open `CorpBranding.iss`

3. Click **Compile**

4. The output file will be:
   ```
   CorpBrandingInstaller.exe
   ```

---

## Installation

### Interactive install
```
Double-click CorpBrandingInstaller.exe
Approve UAC
Done
```

### Silent install
```bat
CorpBrandingInstaller.exe /VERYSILENT /NORESTART
```

Silent mode:
- Shows no UI
- Applies branding immediately
- Sets up future logon enforcement

---

## Uninstallation

Uninstall via:
- **Apps & Features** / **Programs and Features**
- Or silently:
```bat
unins000.exe /VERYSILENT
```

Uninstall will:
- Remove both scheduled tasks
- Leave user profiles untouched (no forced reversion)

---

## Customization

### Change wallpaper
Replace:
```
CorpWallpaper.jpg
```

### Change wallpaper style
Edit `Corp.theme`:
```
WallpaperStyle=10
```

Values:
- `10` = Fill
- `6`  = Fit
- `2`  = Stretch
- `0`  = Center

### Disable immediate apply
Remove the last two `[Run]` entries in `CorpBranding.iss`.

---

## Notes & limitations

- Settings are **per-user** and enforced at logon
- Other users receive branding on their next logon
- Explorer restart is intentionally avoided to prevent flicker
- Windows Spotlight / slideshow will be overridden by design

---

## License

Internal / private use.  
Adapt freely for your organization.

---

## Support

This repository is intended for internal deployment scenarios.
Review scripts before use in production environments.
