function Write-IniFile
{
	<#
		.SYNOPSIS
		Writes the content to INI file.

		.DESCRIPTION
		Creates a new INI file and writes the content into it.

		.PARAMETER file
		The path to an INI file that will be created.

		.PARAMETER content
		The hashtable that contains the content.

		.PARAMETER contentAsRaw
		The string that contains the content.

		.NOTES
		The section name of the global properties is the empty string.
		The line starting with the symbol "#" or ";" is regarded as a comment, but any inline comment will be ignored.
		The parameters (content and contentAsRaw) are mutual exclusive.
	#>
	param
	(
		[parameter(Mandatory = $true)]
		[string] $file,
		[Parameter(Mandatory = $true, ParameterSetName = 'Content')]
		[hashtable] $content,
		[Parameter(Mandatory = $true, ParameterSetName = 'ContentAsRaw')]
		[string] $contentAsRaw
	)

	if ($null -ne $content)
	{
		$lines = [System.Text.StringBuilder]::new()
		if ($content.ContainsKey([string]::Empty))
		{
			
			[void]$lines.AppendLine((Convert-ToString -Section "$([string]::Empty)" -Properties $content[[string]::Empty]))
			$content.Remove([string]::Empty)
		}

		foreach ($section in $content.GetEnumerator())
		{
			[void]$lines.AppendLine((Convert-ToString -Section $section.Name -Properties $section.Value))
		}

		$contentAsRaw = $lines.ToString()
	}

	Set-Content -Path $file $contentAsRaw
}

function Convert-ToString
{
	param
	(
		[parameter(Mandatory = $true)]
		[AllowEmptyString()]
		[string] $section,
		[parameter(Mandatory = $true)]
		[System.Collections.Specialized.OrderedDictionary] $properties
	)

	$lines = [System.Text.StringBuilder]::new()

	if (![string]::IsNullOrEmpty($section))
	{
		[void]$lines.AppendLine("[$section]")
	}

	foreach ($property in $properties.GetEnumerator())
	{
		$key = $property.Name
		$value = $property.Value

		if ($key -match "^[;#].*$")
		{
			[void]$lines.AppendLine($value)
		}
		else
		{
			[void]$lines.AppendLine("$key = $value")
		}
	}

	return $lines.ToString()
}

Export-ModuleMember Write-IniFile