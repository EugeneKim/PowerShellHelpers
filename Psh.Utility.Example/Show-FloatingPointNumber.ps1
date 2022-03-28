Import-Module "..\Psh.Utility\Show-FloatingPointNumber.psm1" -Force

[single]$single = 1.27E2
[double]$double = -1.27E2

Write-Host (Show-FloatingPointNumber $single)
Write-Host (Show-FloatingPointNumber $double)