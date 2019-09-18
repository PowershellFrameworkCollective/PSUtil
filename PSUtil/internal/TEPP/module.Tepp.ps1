Register-PSFTeppScriptBlock -Name 'PSUtil-Module-Installed' -ScriptBlock {
	(Get-PSFTaskEngineCache -Module PSUtil -Name Module).InstalledModules
}

Register-PSFTeppScriptBlock -Name 'PSUtil-Module-Total' -ScriptBlock {
	(Get-PSFTaskEngineCache -Module PSUtil -Name Module).AvailableModules
}

Register-PSFTeppScriptblock -Name 'PSUtil-Module-Repository' -ScriptBlock {
	(Get-PSFTaskEngineCache -Module PSUtil -Name Module).Repositories
}

Register-PSFTeppScriptblock -Name 'PSUtil-Module-PackageProvider' -ScriptBlock {
	(Get-PSFTaskEngineCache -Module PSUtil -Name Module).PackageProvider
}