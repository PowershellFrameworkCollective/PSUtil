function Set-PSUPath {
    <#
	.SYNOPSIS
		Detects the alias that called it and sets the location to the corresponding path found in the configuration system.

	.DESCRIPTION
		Detects the alias that called it and sets the location to the corresponding path.
		This function will normally be called using an alias that gets set by using Set-PSUPathAlias.

	.PARAMETER Alias
		This is the name of the alias that called the command.
		Default Value is $MyInvocation.line and is detected automatically

	.EXAMPLE
		PS C:\> Software
		PS C:\Software>

		In this example 'Software' is an alias for Set-PSUPath that was created by using Set-PSUPathAlias.
		Set-PSUPath detected that 'Software' was the alias that called it and then sends it to the path.
		It receives the path from Get-PSUPathAlias 'software'
#>

    [CmdletBinding()]
    param (
        $Alias = $MyInvocation.line
    )

    Write-PSFMessage -Level InternalComment -Message "Bound parameters: $($PSBoundParameters.Keys -join ", ")" -Tag 'debug', 'start', 'param'
    try {
        $PSFConfigPath = Get-PSFConfigValue -FullName psutil.pathalias.$Alias
        # Turn Value into scriptblock to support Variables and $env:
        if ($PSFConfigPath -contains '$') {
            $ScriptBlock = [scriptblock]::Create($PSFConfigPath)
        }
    }

    catch {
        Stop-PSFFunction -Message "unable to find PSFConfig entry for psutil.pathalias.$Alias" -Category InvalidOperation -Tag fail -Exception $_
        return
    }
    try {
        if ($ScriptBlock) {
            Set-Location (& $ScriptBlock)
        }
        else {
            Set-Location $PSFConfigPath
        }
    }
    catch {
        Stop-PSFFunction -Message "Unable to set location to $PSFConfigPath" -Category InvalidOperation -Tag fail -Exception $_
        return
    }
}