Import-Module ".\Psh.Utility\Read-IniFile.psm1" -Force

$iniContent = Read-IniFile -File ".\Sample.ini"

# Output the content of INI file.
$section = "drivers"
Write-Host "[$section]"
Write-Host "wave=$($iniContent["drivers"]["wave"])"
Write-Host "timer=$($iniContent["drivers"]["timer"])"

$section = "386Enh"
Write-Host "[$section]"
foreach ($key in $iniContent[$section].Keys)
{
	$value = $iniContent[$section][$key]
	Write-Host (($value.StartsWith(";") -or $value.StartsWith("#")) ? $value : ($key + "=" + $value))
}