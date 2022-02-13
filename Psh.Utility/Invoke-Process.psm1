function Invoke-Process
{
	<#
		.SYNOPSIS
		Invokes a process.

		.DESCRIPTION
		Invokes a process by running the executable file.

		.PARAMETER exe
		The full path of the executable file.

		.PARAMETER workingDirectory
		The path of the working directory.

		.PARAMETER arguments
		The arguments will be passed into the executable.

		.NOTES
		This function is an alternative of Start-Process built-in function as it does not have the functionality redirecting output/error to variables.
	#>

	Param (
		[Parameter(Mandatory=$true)]
		[string] $exe,
		[Parameter(Mandatory=$false)]
		[string] $workingDirectory,
		[Parameter(Mandatory=$false)]
		[string] $arguments
	)

	$process = New-Object System.Diagnostics.Process
	$process.StartInfo.UseShellExecute = $false
	$process.StartInfo.RedirectStandardOutput = $true
	$process.StartInfo.RedirectStandardError = $true
	$process.StartInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
	$process.StartInfo.FileName = $exe

	if ($workingDirectory)
	{
		$process.StartInfo.WorkingDirectory = $workingDirectory
	}

	if ($arguments)
	{ 
		$process.StartInfo.Arguments = $arguments 
	}

	$isStarted = $process.Start()

	if ($isStarted)
	{
		$standardError = $process.StandardError.ReadToEnd()
		$standardOutput = $process.StandardOutput.ReadToEnd()

		$process.WaitForExit()

		$exitCode = $process.ExitCode

		$output = New-Object PSObject
		$output | Add-Member -Type "NoteProperty" -Name "ExitCode" -Value $exitCode
		$output | Add-Member -Type "NoteProperty" -Name "StandardOutput" -Value $standardOutput
		$output | Add-Member -Type "NoteProperty" -Name "StandardError" -Value $standardError

		return $output
	}
	else
	{
		return $null
	}
}