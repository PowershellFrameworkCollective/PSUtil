@{
	# Script module or binary module file associated with this manifest
	RootModule = 'PSUtil.psm1'
	
	# Version number of this module.

	ModuleVersion = '2.2.39'
	
	# ID used to uniquely identify this module
	GUID = '9ef51588-c40c-4064-910d-9b624b758cf6'
	
	# Author of this module
	Author = 'Friedrich Weinmann'
	
	# Company or vendor of this module
	CompanyName = ' '
	
	# Copyright statement for this module
	Copyright = 'Copyright (c) 2018 Friedrich Weinmann'
	
	# Description of the functionality provided by this module
	Description = 'Makes the daily PowerShell madness and toil easier to bear'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '3.0'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @(
		@{ ModuleName = 'PSFramework'; ModuleVersion = '1.12.346' }
		@{ ModuleName = 'string'; ModuleVersion = '1.1.5' }
	)
	
	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies = @('bin\PSUtil.dll')
	
	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\PSUtil.Types.ps1xml')
	
	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess = @('xml\PSUtil.Format.ps1xml')
	
	# Functions to export from this module
	FunctionsToExport  = @(
		'Backup-PSULocation'
		'Convert-PSUObject'
		'Expand-PSUObject'
		'Get-PSUCalendarWeek'
		'Get-PSUPathAlias'
		'Invoke-PSUDesktop'
		'Invoke-PSUExplorer'
		'Invoke-PSUTemp'
		'New-PSUDirectory'
		'Out-PSUVariable'
		'Register-PSUObjectConversion'
		'Register-PSUObjectExpansion'
		'Read-PSUKnowledge'
		'Remove-PSUDirectory'
		'Remove-PSUKnowledge'
		'Remove-PSUPathAlias'
		'Select-PSUFunctionCode'
		'Select-PSUObjectSample'
		'Set-PSUDrive'
		'Set-PSUObjectType'
		'Set-PSUPath'
		'Set-PSUPathAlias'
		'Set-PSUPrompt'
		'Set-PSUShell'
		'Start-PSUTimer'
		'Write-PSUKnowledge'
	)
	
	# Cmdlets to export from this module
	# CmdletsToExport = ''
	
	# Variables to export from this module
	# VariablesToExport = ''
	
	# Aliases to export from this module
	AliasesToExport    = @(
		'a'
		'add'
		'Add-PSUString'
		'bu'
		'c'
		'cast'
		'cfj'
		'cfx'
		'convert'
		'ctj'
		'ctx'
		'desktop'
		'ec'
		'ex'
		'exp'
		'explorer'
		'format'
		'Format-PSUString'
		'grep'
		'ic'
		'inspect'
		'ix'
		'join'
		'Join-PSUString'
		'learn'
		'm'
		'mcd'
		'new'
		'ocb'
		'ov'
		'page'
		'rcd'
		'rdk'
		'read'
		'Remove-PSUString'
		'replace'
		's'
		'Select-PSUObject'
		'set-as'
		'Set-PSUString'
		'split'
		'Split-PSUString'
		'spo'
		'teach'
		'temp'
		'timer'
		'trim'
		'v'
		'wrap'
	)
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('Utility')
			
			# A URL to the license for this module.
			LicenseUri = 'https://github.com/PowershellFrameworkCollective/PSUtil/blob/Development/LICENSE'
			
			# A URL to the main website for this project.
			ProjectUri = 'https://psframework.org'
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			ReleaseNotes = 'https://github.com/PowershellFrameworkCollective/PSUtil/blob/master/PSUtil/changelog.md'
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}
