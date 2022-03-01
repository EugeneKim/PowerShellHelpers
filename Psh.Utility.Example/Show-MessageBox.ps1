Import-Module "..\Psh.Utility\Show-MessageBox.psm1" -Force

Show-MessageBox "message box (exclamation)" "caption" OK Exclamation | Out-Null

$messageboxResult = Show-MessageBox "message box (question)" "caption" YesNo Question

if ($messageboxResult -eq [MBResult]::Yes)
{
	Write-Host "Yes!"
}
else 
{
	Write-Host "No!"
}