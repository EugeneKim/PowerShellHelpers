Import-Module ".\Psh.Utility\Write-IniFile.psm1" -Force

# Create a new INI file with a hashtable.
$content = [Ordered]@{}

$content.Add(
	[String]::Empty,
	[Ordered]@{
		";Comment1" = "; sample ini file for *-IniFile module test.";
		";Comment2" = "; for 16-bit app support"
	}
)
$content.Add(
	"386Enh",
	[Ordered]@{
		";Comment1" = "; woafont setting";
		"woafont" = "dosapp.fon";
		"#Comment2" = "# *.FON settings";
		"EGA80WOA.FON" = "EGA80WOA.FON";
		"EGA40WOA.FON" = "EGA40WOA.FON";
		"CGA80WOA.FON" = "CGA80WOA.FON";
		"CGA40WOA.FON" = "CGA40WOA.FON"
	}
)
$content.Add(
	"drivers",
	[Ordered]@{
		"wave" = "mmdrv.dll";
		"timer" = "timer.drv"
	}
)

$iniFile = "$([Guid]::NewGuid()).ini"
Write-IniFile -File $iniFile -Content $content

# Create a new INI file with a raw string.
$contentAsRaw =
@"
; sample ini file for *-IniFile module test.
; for 16-bit app support

[386Enh]
; woafont setting
woafont = dosapp.fon
# *.FON settings
EGA80WOA.FON = EGA80WOA.FON
EGA40WOA.FON = EGA40WOA.FON
CGA80WOA.FON = CGA80WOA.FON
CGA40WOA.FON = CGA40WOA.FON

[drivers]
wave = mmdrv.dll
timer = timer.drv
"@

$iniFile = "$([Guid]::NewGuid()).ini"
Write-IniFile -File $iniFile -contentAsRaw $contentAsRaw