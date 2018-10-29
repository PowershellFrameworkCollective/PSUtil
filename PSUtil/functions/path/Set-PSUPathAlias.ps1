function Set-PSUPathAlias {
    <#
	.SYNOPSIS
		Used to create an an alias that sets your location to the path you specify.

	.DESCRIPTION
		A detailed description of the Set-PSUPathAlias function.

	.PARAMETER Alias
		Name of the Alias that will be created for Set-PSUPath.
		Set-PSU Path detects the alias that called it and then find the corresponding PSFConfig entry for it.

	.PARAMETER Path
		This is the path that you want your location to change to when the alias is called.

	.PARAMETER Register
		A description of the Register parameter.

	.EXAMPLE
        PS C:\> Set-PSUPathAlias
#>

    [CmdletBinding()]
    param
    (
        [Parameter(Position = 0)]
        [string]
        $Alias,

        [Parameter(Position = 1)]
        [string]
        $Path,

        [switch]
        $Register
    )

    try {
        Set-PSFConfig -FullName psutil.pathalias.$Alias -Value $Path -Description 'Sets an alias for Set-PSUPath that takes you to the path specified in the value.'
    }
    catch {
        Stop-PSFFunction -Message 'Error encountered. Alias not set.' -Category InvalidOperation -Tag fail -Exception $_
        return
    }

    if ($Register) {
        Get-PSFConfig -FullName psutil.pathalias.$Alias | Register-PSFConfig
    }

    try {
        Import-PSUAlias -Name $Alias -Command Set-PSUPath
    }
    catch {
        Stop-PSFFunction -Message 'Error encountered. Alias not set.' -Category InvalidOperation -Tag fail -Exception $_
        return
    }
}