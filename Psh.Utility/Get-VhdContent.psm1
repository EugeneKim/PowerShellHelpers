function Get-VhdContent
{
	<#
		.SYNOPSIS
		Extracts all contents from the VHD image file.

		.DESCRIPTION
		Extracts all contents from the VHD image file.

		.PARAMETER vhdFile
		The path to a VHD image file.

		.PARAMETER destination
		The destination directory where the contents will be copied into.

		.PARAMETER contentAsRaw
		The string that contains the content.

		.NOTES
		This might be required to run as administrator.
	#>
	param
	(
		[Parameter(Mandatory=$true)]
		[string] $vhdFile,
		[Parameter(Mandatory=$true)]
		[string] $destination
	)

	$devicePath = (Mount-DiskImage -ImagePath $vhdFile -StorageType VHD -Access ReadOnly -ErrorAction Stop).DevicePath

	try
	{
		$driveLetter = Get-DiskImage -DevicePath $devicePath | Get-Disk | Get-Partition | Get-Volume | Select-Object -ExpandProperty DriveLetter
		$driveLetter += ":"

		Copy-Item -Path $driveLetter -Destination $destination -Recurse -ErrorAction SilentlyContinue
	}
	finally
	{
		Dismount-DiskImage -DevicePath $devicePath
	}
}