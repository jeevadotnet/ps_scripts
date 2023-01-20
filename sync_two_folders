$Trigger = New-ScheduledTaskTrigger -Daily -At 3am
$ScriptBlock = {
    $Source = Get-ChildItem \\server1\folder
    $Destination = Get-ChildItem \\server2\folder

    $Changes = Compare-Object -ReferenceObject $Source -DifferenceObject $Destination -Property Name, LastWriteTime

    $Changes | Where-Object {$_.SideIndicator -eq '<='} | ForEach-Object {
        Copy-Item -Path $_.InputObject.FullName -Destination "\\server2\folder" -Force
    }
    Sync-Item -Path "\\server1\folder" -Destination "\\server2\folder"
}
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-Command `"& $ScriptBlock`""
$Task = Register-ScheduledTask -TaskName "Sync Folders" -Trigger $Trigger -Action $Action -User "UserName" -Password "Password" -RunLevel Highest
