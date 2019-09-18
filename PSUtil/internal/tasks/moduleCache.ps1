Set-PSFTaskEngineCache -Module PSUtil -Name Module -Lifetime 5m -Collector {
	$paramRegisterPSFTaskEngineTask = @{
		Name	    = 'PSUtil.ModuleCache'
		Description = 'Refreshes the data on locally available modules and repositories'
		Once	    = $true
		ResetTask   = $true
		ScriptBlock = {
			$data = @{
				InstalledModules = ((Get-InstalledModule).Name | Select-Object -Unique)
				AvailableModules  = ((Get-Module -ListAvailable).Name | Select-Object -Unique)
				PackageProvider  = ((Get-PackageProvider).Name)
				Repositories = ((Get-PSRepository).Name)
			}
			Set-PSFTaskEngineCache -Module PSUtil -Name Module -Value $data
		}
	}
	
	Register-PSFTaskEngineTask @paramRegisterPSFTaskEngineTask
	
	while (-not [PSFramework.TaskEngine.TaskHost]::GetCacheItem('PSUtil', 'Module').Value)
	{
		Start-Sleep -Milliseconds 100
	}
	
	# Deliver expired data right away anyway
	[PSFramework.TaskEngine.TaskHost]::GetCacheItem('PSUtil', 'Module').Value
}