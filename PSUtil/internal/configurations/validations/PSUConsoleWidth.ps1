Register-PSFConfigValidation -Name "PSUConsoleWidth" -ScriptBlock {
	param (
		$Value
	)
	
	$result = New-Object PSObject -Property @{
		Message  = ""
		Value    = $null
		Success  = $false
	}
	
	try { [int]$option = $Value }
	catch
	{
		$result.Message = "Could not convert $Value into a valid integer | $_"
		return $result
	}
	
	if ($option -le 0)
	{
		$result.Message = "Cannot specify a window width of 0 or less"
		return $result
	}
	
	if ($option -gt $Host.UI.RawUI.MaxWindowSize.Width)
	{
		$result.Message = "Cannot specify a window width larger than the maximum width: $option / $($Host.UI.RawUI.MaxWindowSize.Width)"
		return $result
	}
	
	$result.Success = $true
	$result.Value = $option
	
	return $result
}