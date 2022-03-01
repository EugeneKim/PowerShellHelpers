Add-Type -AssemblyName PresentationCore, PresentationFramework

enum MBButton 
{
	OK =          [System.Windows.MessageBoxButton]::OK
	OKCancel =    [System.Windows.MessageBoxButton]::OKCancel
	YesNoCancel = [System.Windows.MessageBoxButton]::YesNoCancel
	YesNo =       [System.Windows.MessageBoxButton]::YesNo
}

enum MBImage 
{
	None        = [System.Windows.MessageBoxImage]::None
	Hand        = [System.Windows.MessageBoxImage]::Hand
	Error       = [System.Windows.MessageBoxImage]::Error
	Stop        = [System.Windows.MessageBoxImage]::Stop
	Question    = [System.Windows.MessageBoxImage]::Question
	Exclamation = [System.Windows.MessageBoxImage]::Exclamation
	Warning     = [System.Windows.MessageBoxImage]::Warning
	Asterisk    = [System.Windows.MessageBoxImage]::Asterisk
	Information = [System.Windows.MessageBoxImage]::Information
}

enum MBResult
{
	Cancel = [System.Windows.MessageBoxResult]::Cancel
	No     = [System.Windows.MessageBoxResult]::No
	None   = [System.Windows.MessageBoxResult]::None
	OK     = [System.Windows.MessageBoxResult]::OK
	Yes    = [System.Windows.MessageBoxResult]::Yes
}

function Show-MessageBox
{
	param
	(
		[parameter(Mandatory=$true)]
		[string]$messageBoxText,
		[parameter(Mandatory=$true)]
		[string]$caption,
		[parameter(Mandatory=$false)]
		[MBButton]$button=[MBButton]::YesNo,
		[parameter(Mandatory=$false)]
		[MBImage]$image=[MBImage]::None
	)

	$result = [System.Windows.MessageBox]::Show($messageBoxText, $caption, $button, $image)

	return [MBResult]$result
}

Export-ModuleMember Show-MessageBox