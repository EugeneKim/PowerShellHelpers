Import-Module "..\Psh.Utility\Invoke-AsAdmin.psm1" -Force

Add-Type -AssemblyName PresentationCore,PresentationFramework

Invoke-AsAdmin "$PSScriptRoot\Run-Notepad.ps1"