Register-PSUObjectConversion -From dec -To hex -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToString($InputObject, 16)
}

Register-PSUObjectConversion -From hex -To dec -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToInt32($InputObject, 16)
}
