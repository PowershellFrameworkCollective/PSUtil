Register-PSUObjectConversion -From bin -To oct -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 2)
	[System.Convert]::ToString($temp, 8)
}

Register-PSUObjectConversion -From oct -To bin -ScriptBlock {
	Param (
		$InputObject
	)
	
	$temp = [System.Convert]::ToInt32($InputObject, 8)
	[System.Convert]::ToString($temp, 2)
}
