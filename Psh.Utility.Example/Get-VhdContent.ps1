Import-Module ".\Psh.Utility\Get-VhdContent.psm1" -Force

# Replace the values of the parameters properly.
Get-VhdContent -VhdFile "C:\VHDFiles\Windows10.vhd" -Destination "C:\Temp\Windows10"