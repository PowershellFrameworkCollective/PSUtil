Register-PSUObjectConversion -From dec -To bin -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToString($InputObject, 2)
}

Register-PSUObjectConversion -From bin -To dec -ScriptBlock {
	Param (
		$InputObject
	)
	
	[System.Convert]::ToInt32($InputObject, 2)
}