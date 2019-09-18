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
        Default Value is $MyInvocation.InvocationName and is detected automatically

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
		[string]
		$Alias = $MyInvocation.InvocationName,
		
		[switch]
		$EnableException
	)
	
	begin
	{
		function Resolve-PsuPath
		{
			[CmdletBinding()]
			param (
				[string]
				$Path
			)
			
			$environ = @{}
			foreach ($item in Get-ChildItem env:)
			{
				$environ[$item.Name] = $item.Value
			}
			$pattern = '%{0}%' -f ($environ.Keys -join '%|%')
			$replacement = {
				param (
					[string]
					$Match
				)
				$environ = @{ }
				foreach ($item in Get-ChildItem env:)
				{
					$environ[$item.Name] = $item.Value
				}
				$environ[$Match.Trim('%')]
			}
			[regex]::Replace($Path, $pattern, $replacement, 'IgnoreCase')
		}
	}
	process
	{
		try
		{
			$psfConfigPath = Get-PSFConfigValue -FullName psutil.pathalias.$Alias -NotNull
		}
		
		catch
		{
			$paramStopPSFFunction = @{
				Message		    = "Unable to find a path setting for the alias"
				Category	    = 'InvalidOperation'
				Tag			    = 'fail'
				ErrorRecord	    = $_
				EnableException = $EnableException
			}
			
			Stop-PSFFunction @paramStopPSFFunction
			return
		}
		
		try
		{
			Set-Location (Resolve-PsuPath -Path $psfConfigPath) -ErrorAction Stop
		}
		catch
		{
			$psfFuncParams = @{
				EnableException = $EnableException
				Message		    = "Unable to set location to $psfConfigPath"
				Category	    = 'InvalidOperation'
				Tag			    = 'fail'
				ErrorRecord	    = $_
			}
			Stop-PSFFunction @psfFuncParams
			return
		}
	}
}