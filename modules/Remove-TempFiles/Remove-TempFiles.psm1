function Remove-TempFiles {
    <#
    .SYNOPSIS
    Deletes all temporary Files (IE, WebCache, WER) on every user profile found locally
    
    .DESCRIPTION
    The Remove-TempFiles function searches for local user profiles and deletes the temp files in evrey User Profile.
    This is intended to clean up Terminal Server fast and efficiently
    
    
    .PARAMETER
    
    .EXAMPLE
    
    .NOTES
    
    
    #>
    
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
        Write-Host "Lösche " ($x + "\AppData\Local\Microsoft\Windows\WebCache\")
        try {
            Get-Childitem ($x + "\AppData\Local\Microsoft\Windows\WebCache\") -Force | Remove-Item -Recurse -Force
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
}