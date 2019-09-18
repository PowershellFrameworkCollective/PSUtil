function Set-PSUString
{
<#
	.SYNOPSIS
		Replaces a part of the input string with another.
	
	.DESCRIPTION
		Replaces a part of the input string with another.
		Supports both regex replace as well as regular .replace().
	
	.PARAMETER InputString
		The stringgs on which replacement will be performed.
	
	.PARAMETER What
		What should be replace?
	
	.PARAMETER With
		With what should it be replaced?
	
	.PARAMETER Simple
		By default, this function uses regex replace. Sometimes this may not be desirable.
		This switch enforces simple replacement, not considering any regular expression functionality.
	
	.PARAMETER Options
		Default: IgnoreCase
		When using regex replace, it may become desirable to specify options to the system.
	
	.PARAMETER EnableException
        Replaces user friendly yellow warnings with bloody red exceptions of doom!
        Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		"abc ABC" | replace b d
	
		Returns "adc AdC".
	
	.EXAMPLE
		"abc ABC" | replace b d -Options None
	
		Returns "adc ABC"
	
	.EXAMPLE
		"abc \def" | replace "\de" "&ed" -s
	
		Returns "abc &edf"
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[OutputType([System.String])]
	[CmdletBinding(DefaultParameterSetName = "regex")]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputString,
		
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$What,
		
		[Parameter(Position = 1, Mandatory = $true)]
		[AllowEmptyString()]
		[object]
		$With,
		
		[Parameter(ParameterSetName = "Simple")]
		[Alias('s')]
		[switch]
		$Simple,
		
		[Parameter(ParameterSetName = "Regex")]
		[System.Text.RegularExpressions.RegexOptions]
		$Options = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase,
		
		[switch]
		$EnableException
	)
	
	begin
	{
		if ($With -isnot [System.Management.Automation.ScriptBlock])
		{
			$With = "$With"
		}
		elseif ($Simple)
		{
			Stop-PSFFunction -Message "Cannot do a lambda replace with a simple string replacement. Please specify a string or remove the simple parameter." -EnableException $EnableException -Category InvalidArgument -Tag 'fail','validate'
			return
		}
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		foreach ($line in $InputString)
		{
			try
			{
				if ($Simple) { $line.Replace($What, $With) }
				else { [regex]::Replace($line, $What, $With, $Options) }
			}
			catch
			{
				Stop-PSFFunction -Message "Failed to replace line" -EnableException $EnableException -ErrorRecord $_ -Tag 'Fail', 'record' -Continue
			}
		}
	}
}
Import-PSUAlias -Name replace -Command Set-PSUString