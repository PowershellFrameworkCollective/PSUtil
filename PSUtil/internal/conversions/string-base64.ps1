Register-PSUObjectConversion -From Base64 -To String -ScriptBlock {
	param ($InputObject)
	$bytes = [convert]::FromBase64String(([string]$InputObject))
	[System.Text.Encoding]::UTF8.GetString($bytes)
}
Register-PSUObjectConversion -From String -To Base64 -ScriptBlock {
	param ($InputObject)
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($InputObject)
	[Convert]::ToBase64String($bytes)
}