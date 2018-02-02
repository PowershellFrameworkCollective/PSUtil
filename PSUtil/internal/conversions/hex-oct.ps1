Register-PSUObjectConversion -From hex -To oct -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 16)
	[System.Convert]::ToString($temp, 8)
}

Register-PSUObjectConversion -From oct -To hex -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 8)
	[System.Convert]::ToString($temp, 16)
}
