Param(

   [Parameter(Mandatory=$true)] #Full folder path where all the files exist
   [string]$FolderPath,

   [Parameter(Mandatory=$true)] #part of the file name that needs to be replaced
   [string]$ReplaceFrom,

   [Parameter(Mandatory=$true)] #replace ReplaceFrom to the value specified here
   [string]$ReplaceTo,

   [Parameter(Mandatory=$false)] #Should all the files be renumberd
   [boolean]$RenumberAll = $false

) #end param

$files = Get-ChildItem -Path $FolderPath 

foreach ($file in $files) {
    $filename = $file.BaseName
    if($filename -like ("*" + $ReplaceFrom + "*")) {
        $newFileName = $filename -replace $ReplaceFrom, $ReplaceTo
        $newFileName = $newFileName + $file.Extension
    
        "Renaming $filename to $newFilename"


        Rename-Item -Path $file.PSPath -NewName $newFileName
    }
}

if($RenumberAll = $true){
    $totalFiles = $files.Count
    "Renumbering all $totalFiles files"
    
    foreach ($file in $files) {
        $filename = $file.BaseName
        $newFilename = $filename
        #TODO: add Numbering (remove existing if any)
        $underscoreIndex = $newFilename.IndexOf("_")
        $underscoreIndex
        if($underscoreIndex > 0) {
            $newFilename = $newFilename.Substring(0, $underscoreIndex + 1);
        } 
        #$newFilename
    }
    
}