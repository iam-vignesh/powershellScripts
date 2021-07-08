<#
The script will take an input file path and start deleting the files and folders recursively WITHOUT ASKING ANY CONFIRMATION.
Please use it with CAUTION and this is for educational purpose only.
#>

$fileNames =@()

$date = Get-date
$localUser =     $localUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name       

function Remove-Temp($filePath)
{
    Set-Location -Path $filePath
    $fileNames = Get-ChildItem | ForEach-Object Name
    foreach($file in $fileNames)
    {
        Write-Host "`nDeleting $file`n"
        #Remove-Item $file -Recurse -Force                                                                                       #uncomment to delete files
        Add-Content -Path C:\Users\$userName\Desktop\DeletionLog.txt -Value "$file deleted on $date by user: $localUser"         #update the file path here
    }

    return "Files Deleted!"

}

Write-Warning "HANDLE with CAUTION. FILES WILL BE DELETED WITHOUT CONFIRMATION."
$deletionLocation = Read-Host "Enter complete FILE PATH to delete temp. files"
Remove-Temp($deletionLocation)
