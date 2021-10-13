Register-PSUObjectConversion -From NT -To SID -ScriptBlock {
	param ($InputObject)
	([System.Security.Principal.NTAccount]$InputObject).Translate([System.Security.Principal.SecurityIdentifier])
}
Register-PSUObjectConversion -From SID -To NT -ScriptBlock {
	param ($InputObject)
	([System.Security.Principal.SecurityIdentifier]$InputObject).Translate([System.Security.Principal.NTAccount])
}