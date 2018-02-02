Register-PSUObjectConversion -From dec -To oct -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToString($InputObject, 8)
}

Register-PSUObjectConversion -From oct -To dec -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToInt32($InputObject, 8)
}
