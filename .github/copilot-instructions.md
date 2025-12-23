# Copilot instructions for VPG 410 Desktop Fix

Quick guidance to help AI coding agents be productive in this repository.

## Big picture
- Purpose: Windows-only tooling that applies corporate desktop theming and resets the Recycle Bin name across machines.
- Primary components:
  - PowerShell scripts at repository root: `Apply-CorpTheme.ps1`, `Reset-RecycleBinName.ps1`, and task install/uninstall helpers.
  - `Trunk/` contains two product subfolders:
    - `VPG 410 Corp Theme/` — theme application scripts, Inno Setup script (`CorpTheme.iss`) and task installers.
    - `VPG 410 Rename Recycle Bin/` — scripts and Inno Setup (`RecycleBinReset.iss`) for the recycle bin rename task.
  - `*.iss` files are Inno Setup installer script sources; `Output/` directories hold build artifacts.

## What to change and why
- If modifying visual assets or theme settings, update `Corp.theme` and `Apply-CorpTheme.ps1` in the relevant folder.
- If changing scheduled task behavior, update the matching `Install-ScheduledTask.ps1` / `Uninstall-ScheduledTask.ps1` in the subfolder so installers stay consistent.
- Keep installer metadata and paths in the `.iss` files in sync with the corresponding `Install-*.ps1` scripts (they reference built artifacts and paths).

## Developer workflows (how to test/run)
- Run PowerShell scripts locally as Administrator for manual testing. Example:

  powershell -ExecutionPolicy Bypass -NoProfile -File .\Apply-CorpTheme.ps1

- Build using Inno Setup (not included). Typical command (installed Inno Setup):

  ISCC "Trunk\VPG 410 Corp Theme\CorpTheme.iss"

- Inspect `Output/` after builds to find generated installers and payloads.

## Project conventions & patterns
- Windows-first: scripts use PowerShell and expect elevated permissions for system changes.
- Installer-driven releases: primary distribution is via Inno Setup `.iss` files—these orchestrate copying `Output/` content and registering scheduled tasks.
- Paired install/uninstall scripts: each feature folder includes both `Install-*.ps1` and `Uninstall-*.ps1`. When adding a new feature, include both.
- Scheduled task pattern: `Install-ScheduledTask.ps1` creates a task that runs a shipped `.ps1` payload. Keep task name strings stable to avoid leaving orphaned tasks on update.

## Integration points & external dependencies
- Inno Setup compiler (ISCC) required to build `.iss` installers.
- Scripts assume Windows APIs and scheduled task subsystem — testing requires an elevated Windows environment.
- No unit tests or CI detected; treat manual testing steps above as the verification path.

## Code-editing heuristics for AI agents
- Preserve existing function/variable naming in PowerShell scripts; this repo is small and changes are often surgical.
- When editing an `.iss` file, only change installer metadata or file lists—avoid altering Inno Setup directives that control compression or digital signing unless explicit.
- When updating a scheduled task name or path, also update both installer and uninstall scripts to avoid leaving orphans.

## Useful files to inspect
- `Apply-CorpTheme.ps1` (root) — theme application entrypoint
- `Reset-RecycleBinName.ps1` (root) — recycle bin reset logic
- `Trunk\VPG 410 Corp Theme\CorpTheme.iss` — theme installer source
- `Trunk\VPG 410 Rename Recycle Bin\RecycleBinReset.iss` — recycle-bin installer source
- Any `Install-ScheduledTask.ps1` / `Uninstall-ScheduledTask.ps1` under `Trunk/` — scheduled task lifecycle

## When in doubt
- Ask the user to provide a sample target machine OS/build or to run a reproduced test; many changes require running scripts as Administrator on Windows.

---
Please review and tell me if you want more detail on any area (examples, exact lines to change, or adding CI steps).
