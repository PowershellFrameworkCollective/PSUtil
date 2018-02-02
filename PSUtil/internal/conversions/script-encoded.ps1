Register-PSUObjectConversion -From script -To encoded -ScriptBlock {
	Param (
		$InputObject
	)
	
	$bytes = [System.Text.Encoding]::Unicode.GetBytes($InputObject)
	[Convert]::ToBase64String($bytes)
}

Register-PSUObjectConversion -From encoded -To script -ScriptBlock {
	Param (
		$InputObject
	)
	
	$bytes = [System.Convert]::FromBase64String($InputObject)
	[System.Text.Encoding]::Unicode.GetString($bytes)
}
