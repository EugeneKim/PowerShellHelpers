Import-Module ".\Psh.Utility\Invoke-Process.psm1" -Force

$output = Invoke-Process -Exe "ping" -Arguments "localhost"

if ($null -ne $output)
{
	Write-Host -ForegroundColor Blue "Exit code: $($output.ExitCode)"
	Write-Host -ForegroundColor Green "Standard output:`n$($output.StandardOutput)"
	Write-Host -ForegroundColor Red "Standard error:`n$($output.StandardError)"
}
else
{
	Write-Host "Cannot run the executable."
}