##############################################################################
#                                                                            #
#                                README                                      #
#                                                                            #
#    You have to create a folder in the $basefolder.                         #
#    It has to be named after the mailbox you wish to import the PST's in    #
#    This script must be executed from the Exchange Management Shell!        #
#                                                                            #
##############################################################################

$mailbox = "j.doe"                        # Mailbox in which the pst files will be imported
$basefolder = "\\localhost\C`$\TEMP\"     # UNC Path to the folder where the mailbox folder lies
$archive = $true                          # Import into personal archive? False will import into the users Mailbox
$faileditems = 5                          # Set how many Errors can occur before the import will be aborted


$files = Get-ChildItem -Path ($basefolder + $mailbox) -Filter *.pst
$counter = 0

foreach ($pst in $files) {
    $import = "New-MailboxImportRequest -FilePath '$($pst.fullname)' -Mailbox '$mailbox' -TargetRootFolder '$($pst.Name)'"
    $import += " -Name '$($mailbox + $counter)' -BatchName MassImport -BadItemLimit $faileditems"
    if ($archive -eq $true) {
        $import += " -IsArchive"
    }
    Invoke-Expression $import
    $counter++
}