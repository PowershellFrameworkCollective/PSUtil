function Split-PSUString
{
<#
	.SYNOPSIS
		Splits a string. In a pipeline.
	
	.DESCRIPTION
		Splits a string. In a pipeline.
	
	.PARAMETER InputString
		The string(s) to split
	
	.PARAMETER With
		Default: "`n"
		What to split the string with
	
	.PARAMETER Simple
		Whether to disable regex when splitting.
	
	.PARAMETER Options
		Regex options to consider
	
	.EXAMPLE
		"abc,def" | split ","
	
		Returns "abc","def"
#>
	[OutputType([System.String[]])]
	[CmdletBinding(DefaultParameterSetName = "Regex")]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputString,
		
		[Parameter(Position = 0)]
		[string]
		$With = "`n",
		
		[Alias('r')]
		[Parameter(ParameterSetName = "Simple")]
		[switch]
		$Simple,
		
		[Parameter(ParameterSetName = "Regex")]
		[System.Text.RegularExpressions.RegexOptions]
		$Options = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
	)
	
	begin
	{
		$IsRegex = $PSCmdlet.ParameterSetName -eq "Regex"
	}
	process
	{
		foreach ($line in $InputString)
		{
			if ($IsRegex) { [regex]::Split($line, $With, $Options) }
			else { $line.Split($With) }
		}
	}
	end { }
}
Import-PSUAlias -Name split -Command Split-PSUString