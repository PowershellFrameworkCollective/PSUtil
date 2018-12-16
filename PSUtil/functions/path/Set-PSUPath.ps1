function Set-PSUPath
{
<#
	.SYNOPSIS
		Detects the alias that called it and sets the location to the corresponding path found in the configuration system.

	.DESCRIPTION
		Detects the alias that called it and sets the location to the corresponding path.
		This function will normally be called using an alias that gets set by using Set-PSUPathAlias.

	.PARAMETER Alias
		This is the name of the alias that called the command.
        	Default Value is $MyInvocation.line and is detected automatically

	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.

	.EXAMPLE
		PS C:\> Software
		PS C:\Software>

		In this example 'Software' is an alias for Set-PSUPath that was created by using Set-PSUPathAlias.
		Set-PSUPath detected that 'Software' was the alias that called it and then sends it to the path.
		It receives the path from Get-PSUPathAlias 'software'
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[CmdletBinding()]
	param (
		$Alias = $MyInvocation.line,
		
		[switch]
		$EnableException
	)
	
	Write-PSFMessage -Level InternalComment -Message "Bound parameters: $($PSBoundParameters.Keys -join ", ")" -Tag 'debug', 'start', 'param'
	try
	{
		$PSFConfigPath = Get-PSFConfigValue -FullName psutil.pathalias.$Alias -NotNull
	}
	
	catch
	{
		Stop-PSFFunction -Message "Unable to find a path setting for the alias" -Category InvalidOperation -Tag fail -Exception $_
		return
	}
	
	try
	{
		
		if ($PSFConfigPath -contains '$env:')
		{
			Write-PSFMessage "Environmental variable detected, resolving path" -Level internalcomment
			Set-Location (Resolve-Path $PSFConfigPath)
		}
		
		else
		{
			Set-Location $PSFConfigPath
		}
	}
	catch
	{
		
		$psfFuncParams = @{
			Message = "Unable to set location to $PSFConfigPath"
			Category = 'InvalidOperation'
			Tag	    = 'fail'
			ErrorRecord = $_
			EnableException = $EnableException
		}
		Stop-PSFFunction @psfFuncParams
		return
	}
}
