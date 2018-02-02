Register-PSFTeppScriptblock -Name psutil-userprofile -ScriptBlock {
	Get-ChildItem "$env:SystemDrive\Users" -Force | Where-Object PSIsContainer | Expand-PSUObject Name
}