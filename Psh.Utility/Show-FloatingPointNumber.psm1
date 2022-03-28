function Show-FloatingPointNumber
{
		<#
		.SYNOPSIS
		Show the structure of a floating point number in binary form.

		.DESCRIPTION
		Show the structure of a floating point number in binary form.

		.PARAMETER value
		Floating point number. A double or single data type is only accepted.
		.NOTES
		This checks the system's endian and shows as a big-endian.
	#>
	param
	(
		[Parameter(Mandatory=$true)]
		[object]$value
	)

	$type = $value.GetType()

	if ($type -ne [double] -and $type -ne [float])
	{
		throw [ArgumentException]"$type is not valid type." 
	}

	$totalBitsOfExponent = $type -eq [double] ? 11 : 8;
	$totalBitsOfMantissa = $type -eq [double] ? 52 : 23;

	$bytes = [BitConverter]::GetBytes($value)

	if ([BitConverter]::IsLittleEndian)
	{
		[Array]::Reverse($bytes)
	}

	$bitsAsString = $bytes | ForEach-Object { [Convert]::ToString($_, 2).PadLeft(8, "0") } | Join-String
	$sign = $bitsAsString[0]
	$exponent = $bitsAsString[1..($totalBitsOfExponent)] -Join ""
	$mantissa = $bitsAsString[($totalBitsOfExponent + 1)..($totalBitsOfExponent + 1 + $totalBitsOfMantissa)] -Join ""

	$lines = [System.Text.StringBuilder]::new()

	[void]$lines.AppendLine("Input:    $value (Type: $type)")
	[void]$lines.AppendLine("Sign:     $sign (1 bit, $($sign -eq "0" ? "Positive" : "Negative"))")
	[void]$lines.AppendLine("Exponent: $exponent ($totalBitsOfExponent bits)")
	[void]$lines.AppendLine("Mantissa: $mantissa ($totalBitsOfMantissa bits)")

	return $lines.ToString()
}

Export-ModuleMember Show-FloatingPointNumber