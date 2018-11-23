function Get-PSUPathAlias {
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

    foreach ($ali in $aliases) {
        [pscustomobject]@{
            Alias = ($ali.fullname -replace 'psutil.pathalias.')
            Path  = $ali.value
        }
    }
}