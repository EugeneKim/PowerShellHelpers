function Set-TempFile
{
	<#
		.SYNOPSIS
		Create a temp file.

		.DESCRIPTION
		Creates a temp file in the system temp directory.

		.PARAMETER Prefix
		The prefix of the temp file.

		.PARAMETER Postfix
		The postfix of the temp file.

		.PARAMETER DoNotCreate
		Set if you only need the path of the temp file without creating it.
	#>
	param
	(
		[parameter(Mandatory = $false)]
		[string] $prefix,
		[parameter(Mandatory = $false)]
		[string] $postFix,
		[parameter(Mandatory = $false)]
		[switch] $doNotCreate
	)

	$tempPath = [System.IO.Path]::GetTempPath()
	$fileName = $([System.IO.Path]::GetRandomFileName())

	if ($true -eq $prefix)
	{
		$fileName = $prefix + $fileName
	}

	if ($true -eq $postFix)
	{
		$fileName = $fileName + $postFix
	}

	$tempFilePath = Join-Path -Path $tempPath -ChildPath $fileName

	if ($true -ne $doNotCreate)
	{
		New-Item -Path "$tempFilePath" -ItemType "File" | Out-Null
	}

	return $tempFilePath
}