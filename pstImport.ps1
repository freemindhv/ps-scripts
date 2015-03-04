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
$archive = True                           # Import into personal archive? False will import into the users Mailbox


$folderpath = $basefolder + $mailbox
$files = Get-ChildItem -Path $folderpath -Filter *.pst
$counter = 0

foreach ($pst in $files) {
    $params = "-FilePath " + $pst.fullname + " -Mailbox " + $mailbox+ " -TargetRootFolder " + $pst.Name + " -Name " + $mailbox + $counter + " -BatchName MassImport "
    if ($archive == True) {
        $params += "-IsArchive"
    }
    & New-MailboxImportRequest $params
    $counter++
}