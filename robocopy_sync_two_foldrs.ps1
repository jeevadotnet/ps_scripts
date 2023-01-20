# Define the trigger for the scheduled task
$Trigger = New-ScheduledTaskTrigger -Daily -At 3am

# Define the script block that contains the Robocopy command
$ScriptBlock = {
    robocopy "\\server1\folder" "\\server2\folder" /XO /W:5 /R:1 /NP /LOG+:"C:\folder\logs.txt" /MT:8
}

# Define the action for the scheduled task
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-Command `"& $ScriptBlock`""

# Register the scheduled task
$Task = Register-ScheduledTask -TaskName "Sync Folders" -Trigger $Trigger -Action $Action -User "UserName" -Password "Password" -RunLevel Highest
