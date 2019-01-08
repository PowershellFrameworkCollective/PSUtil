function Get-PSUPathAlias
{
<#
	.SYNOPSIS
		Gets the PSUPathAlias configuration values.

	.DESCRIPTION
		Gets the PSUPathAlias configuration values from the PSFConfig system.

	.PARAMETER Alias
		This is the name of the alias that you want for Set-PSUPath. Wildcards accepted

		Default Value: *

	.EXAMPLE
		PS C:\> Get-PSUPathAlias
	
		Returns all aliases
#>
	[CmdletBinding()]
	param (
		[string]
		$Alias = '*'
	)
	
	$aliases = Get-PSFConfig -FullName psutil.pathalias.$Alias
	
	foreach ($currentAlias in $aliases)
	{
		[pscustomobject]@{
			Alias = ($currentAlias.fullname -replace '^psutil.pathalias.')
			Path  = $currentAlias.value
		}
	}
}
