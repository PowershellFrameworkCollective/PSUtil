Register-PSFConfigValidation -Name "PSUGetHelpOptions" -ScriptBlock {
	param (
		$Value
	)
	
	$result = New-Object PSObject -Property @{
		Message = ""
		Value = $null
		Success = $false
	}
	
	try { [PSUtil.Configuration.HelpOption]$option = $Value }
	catch
	{
		$result.Message = "Could not convert $Value into a valid help option. Please specify either of these: Short | Detailed | Examples | Full | Window | Online"
		return $result
	}
	
	$result.Success = $true
	$result.Value = $option
	
	return $result
}