
function Invoke-AsAdmin
{
	<#
		.SYNOPSIS
		Invokes a PowerShell script as administrator.

		.DESCRIPTION
		Invokes a PowerShell script as administrator.

		.PARAMETER file
		The path to a PowerShell script file.
	#>

	param(
		[parameter(Mandatory=$true)]
		[string] $scriptArgument
	)

	if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
	{
		$powerShellExe = (Get-Process -Id $PID).Path
		Start-Process -FilePath $powerShellExe -ArgumentList "$scriptArgument" -Verb RunAs
	}
}