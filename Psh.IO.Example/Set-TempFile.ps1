Import-Module ".\Psh.IO\Set-TempFile.psm1" -Force

Write-Host (Set-TempFile -Prefix "pre_" -DoNotCreate)
Write-Host (Set-TempFile -Postfix "_postfix" -DoNotCreate)
Write-Host (Set-TempFile -Prefix "pre_" -Postfix "_postfix" -DoNotCreate)

$tempFilePath = Set-TempFile -Prefix "pre_"
Write-Host $tempFilePath
Remove-Item $tempFilePath