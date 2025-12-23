$ErrorActionPreference = 'SilentlyContinue'

$taskName = "Reset Recycle Bin Name"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
  Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}
