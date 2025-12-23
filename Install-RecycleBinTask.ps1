$ErrorActionPreference = 'SilentlyContinue'

$taskName  = "Reset Recycle Bin Name"
$script    = "C:\ProgramData\RecycleBinReset\Reset-RecycleBinName.ps1"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
  Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

$action = New-ScheduledTaskAction `
  -Execute "powershell.exe" `
  -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$script`""

$trigger = New-ScheduledTaskTrigger -AtLogOn

$principal = New-ScheduledTaskPrincipal `
  -GroupId "BUILTIN\Users" `
  -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet -Hidden

Register-ScheduledTask `
  -TaskName $taskName `
  -Action $action `
  -Trigger $trigger `
  -Principal $principal `
  -Settings $settings
