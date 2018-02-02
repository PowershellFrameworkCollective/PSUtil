Register-PSUObjectConversion -From hex -To bin -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 16)
	[System.Convert]::ToString($temp, 2)
}

Register-PSUObjectConversion -From bin -To hex -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 2)
	[System.Convert]::ToString($temp, 16)
}
