Register-PSFConfigValidation -Name "PSUBrowseHistoryOptions" -ScriptBlock {
	param (
		$Value
	)
	
	$result = New-Object PSObject -Property @{
		Message  = ""
		Value    = $null
		Success  = $false
	}
	
	try { [PSUtil.Configuration.HistoryOption]$option = $Value }
	catch
	{
		$result.Message = "Could not convert $Value into a valid help option. Please specify either of these: Session | Global"
		return $result
	}
	
	$result.Success = $true
	$result.Value = $option
	
	return $result
}