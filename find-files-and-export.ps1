$directory ="E:\"
$searchfiles = "*.pst"
$exportpath = "C:\TEMP\export.csv"

####################################
#                                  #
#  Initialize Variables            #
#  Only change values above here   # 
#                                  #
####################################


$files = Get-ChildItem -Path $directory -Filter $searchfiles -Recurse

foreach ($file in $files) {
    $owner = $file | Get-Acl
    $sizeinGB = $file.Length / 1GB
    Add-Member -InputObject $file -NotePropertyName "Owner" -NotePropertyValue $owner.owner.ToString()
    Add-Member -InputObject $file -NotePropertyName "SizeinGB" -NotePropertyValue $sizeinGB
    $file | select Name, SizeinGB, Owner | Export-Csv -Path $exportpath -NoTypeInformation -Append
}