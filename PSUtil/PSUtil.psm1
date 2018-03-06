$script:PSModuleRoot = $PSScriptRoot
$script:PSModuleVersion = "1.1.2.12"

$script:doDotSource = Get-PSFConfigValue -FullName PSUtil.Import.DoDotSource -Fallback $false

#region Helper function
function Import-PSUFile
{
	<#
		.SYNOPSIS
			Loads files into the module on module import.
		
		.DESCRIPTION
			This helper function is used during module initialization.
			It should always be dotsourced itself, in order to proper function.
		
		.PARAMETER Path
			The path to the file to load
		
		.EXAMPLE
			PS C:\> . Import-PSUFile -File $function.FullName
	
			Imports the file stored in $function according to import policy
	#>
	[CmdletBinding()]
	Param (
		[string]
		$Path
	)
	
	if ($script:doDotSource) { . $Path }
	else { $ExecutionContext.InvokeCommand.InvokeScript($false, ([scriptblock]::Create([io.file]::ReadAllText($Path))), $null, $null) }
}
#endregion Helper function


# Perform Actions before loading the rest of the content
. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\preload.ps1"

#region Load functions
foreach ($function in (Get-ChildItem "$PSModuleRoot\functions" -Recurse -File -Filter "*.ps1"))
{
	. Import-PSUFile -Path $function.FullName
}
#endregion Load functions

# Perform Actions after loading the module contents
. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\postload.ps1"