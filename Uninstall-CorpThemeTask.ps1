$ErrorActionPreference = 'SilentlyContinue'

$taskName = "Apply Corporate Theme"

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
  Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}
