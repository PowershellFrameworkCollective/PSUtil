Register-PSFTeppScriptBlock -Name 'PSUtil-Module-Installed' -ScriptBlock {
	(Get-InstalledModule).Name | Select-Object -Unique
}

Register-PSFTeppScriptBlock -Name 'PSUtil-Module-Total' -ScriptBlock {
	(Get-Module -ListAvailable).Name | Select-Object -Unique
}

Register-PSFTeppScriptblock -Name 'PSUtil-Module-Repository' -ScriptBlock {
	(Get-PSRepository).Name
}

Register-PSFTeppScriptblock -Name 'PSUtil-Module-PackageProvider' -ScriptBlock {
	(Get-PackageProvider).Name
}