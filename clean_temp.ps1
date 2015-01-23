#$ErrorActionPreference = 'silentlycontinue'
#$ErrorActionPreference = 'Continue'
$ErrorActionPreference = 'stop'
#$DebugPreference = 'silentlycontinue'
$DebugPreference = 'Continue'
$path = @()

#get all local userprofiles
$users = Get-WmiObject -Class win32_userprofile
#get the physical paths of the local userprofiles
foreach ($user in $users) {
    if ($user.LocalPath.startsWith("C:\Users") -eq $True) {
        $path += $user.LocalPath
    }
}
#nuke the temporary internet files folder for each user
foreach ($x in $path) {
    Write-Host "Lösche " ($x + "\AppData\Local\Microsoft\Windows\Temporary Internet Files\")
    try {
        Get-Childitem ($x + "\AppData\Local\Microsoft\Windows\Temporary Internet Files\") -Force | Remove-Item -Recurse -Force
    }
    catch {
        Write-Debug $_.Exception.Message
    }
    try {
        Get-Childitem ($x + "\AppData\Local\Microsoft\Windows\WER\") -Force | Remove-Item -Recurse -Force
    }
    catch {
        Write-Debug $_.Exception.Message
    }
    try {
        Get-Childitem ($x + "\AppData\Local\Temp\") -Force | Remove-Item -Recurse -Force
    }
    catch {
        Write-Debug $_.Exception.Message
    }
}