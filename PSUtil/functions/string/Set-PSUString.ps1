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
		[string]
		$With,
		
		[Parameter(ParameterSetName = "Simple")]
		[Alias('s')]
		[switch]
		$Simple,
		
		[Parameter(ParameterSetName = "Regex")]
		[System.Text.RegularExpressions.RegexOptions]
		$Options = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
	)
	
	begin { }
	process
	{
		foreach ($line in $InputString)
		{
			if ($Simple) { $line.Replace($What, $With) }
			else { [regex]::Replace($line, $What, $With, $Options) }
		}
	}
	end { }
}
Import-PSUAlias -Name replace -Command Set-PSUString