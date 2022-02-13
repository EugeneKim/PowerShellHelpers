<#
$process = Start-Process -FilePath "diskpart" -Verb runAs -ArgumentList “/s Z:\Projects\PowerShell\PowerShellHelpers\vdiskscript.txt” -PassThru -Wait

$aaa = 100

$process = Start-Process -FilePath "diskpart" -Verb runAs -ArgumentList “/s Z:\Projects\PowerShell\PowerShellHelpers\vdiskdetachscript.txt” -PassThru -Wait

$aaa = 200
#>

#$process = Start-Process -FilePath "ping" -Verb runAs -ArgumentList "localhost" -PassThru -Wait

#$aaa = 100

function Extract-VhdContent
{
	
}