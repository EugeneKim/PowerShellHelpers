function Set-TempFile
{
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
		New-Item -Path "$tempFilePath" -ItemType "Directory"
	}

	return $tempFilePath
}