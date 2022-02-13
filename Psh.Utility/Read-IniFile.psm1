function Read-IniFile
{
	<#
		.SYNOPSIS
		Reads the content of INI file.

		.DESCRIPTION
		Reads an INI file, then gets the content into a hashtable.

		.PARAMETER file
		The path to an INI file.

		.NOTES
		The section name of the global properties is the empty string.
		The line starting with the symbol "#" or ";" is regarded as a comment, but any inline comment will be ignored.
		This function is the modified version of the link below:

		.LINK
		https://gist.github.com/beruic/1be71ae570646bca40734280ea357e3c
	#>
	param
	(
		[parameter(Mandatory = $true)]
		[string] $file
	)

	$content = [Ordered]@{}
	$section = [string]::Empty
	$content[$section] = [Ordered]@{}
	$commentIndex = 0

	switch -regex -file $file
	{
		# Section
		"^\[(.+)\]"
		{
			$section = $matches[1]
			$content[$section] = [Ordered]@{}
			$commentIndex = 0
		}
		# Comment
		"^(?<SYMBOL>[;#]).*$"
		{
			$key = "$($matches.SYMBOL) $(([string]$commentIndex++).PadLeft(8, '0'))"
			$value = $matches[0]
			$content[$section][$key] = $value
		}
		# Property
		"(.+?)\s*=(.*)"
		{
			$key, $value = $matches[1..2]
			$content[$section][$key] = $value
		}
	}

	return $content
}

Export-ModuleMember Read-IniFile