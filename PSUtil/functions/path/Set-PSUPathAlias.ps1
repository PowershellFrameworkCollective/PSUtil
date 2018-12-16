function Set-PSUPathAlias {
    <#
	.SYNOPSIS
		Used to create an an alias that sets your location to the path you specify.

	.DESCRIPTION
		A detailed description of the Set-PSUPathAlias function.

	.PARAMETER Alias
		Name of the Alias that will be created for Set-PSUPath.
		Set-PSU Path detects the alias that called it and then finds the corresponding PSFConfig entry for it.

	.PARAMETER Path
		This is the path that you want your location to change to when the alias is called.

	.PARAMETER Register
        	Causes PSUtil to remember the alias across sessions.
        	For more advanced options, see Register-PSFConfig.
		
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
        	Use this if you want the function to throw terminating errors you want to catch.

	.EXAMPLE
        	PS C:\> Set-PSUPathAlias -Alias 'work' -Path 'C:\work'
        	Creates an alias to Set-PSUPath that will set the location to 'c:\work'

    	.EXAMPLE
        	PS C:\> Set-PSUPathAlias -Alias 'repos' -Path 'C:\repos' -Register
		
        	Creates an alias for repos and registers the setting so that it will persist between sessions.
#>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [CmdletBinding()]
    param
    (
        [Parameter(Position = 0, Mandatory)]
        [string]
        $Alias,

        [Parameter(Position = 1, Mandatory)]
        [string]
        $Path,

        [switch]
        $Register,
	
	[switch]
	$EnableException
    )

    try {
        Set-PSFConfig -FullName psutil.pathalias.$Alias -Value $Path -Description 'Sets an alias for Set-PSUPath that takes you to the path specified in the value.'
    }
    catch {
        $stopParams = @{
            Message         = 'Error encountered. Alias not set'
            Category        = 'InvalidOperation'
            Tag             = 'Fail'
            ErroRecord      = $_
            EnableException = $EnableException
        }
        Stop-PSFFunction @stopParams
        return
    }

    if ($Register) {
        Get-PSFConfig -FullName psutil.pathalias.$Alias | Register-PSFConfig
    }

    try {
        Import-PSUAlias -Name $Alias -Command Set-PSUPath
    }
    catch {
        $stopParams = @{
            Message         = 'Error. Alias not set'
            Category        = 'InvalidOperation'
            Tag             = 'Fail'
            ErroRecord      = $_
            EnableException = $EnableException
        }
        Stop-PSFFunction @stopParams
        return
    }
}
