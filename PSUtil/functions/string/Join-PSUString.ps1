function Join-PSUString
{
<#
	.SYNOPSIS
		Joins input strings together.
	
	.DESCRIPTION
		Joins input strings together.
	
	.PARAMETER InputString
		The strings to join
	
	.PARAMETER With
		What to join the strings with.
	
	.PARAMETER BatchSize
		Default: 0
		How many to join together at a time.
		If 0 or lower are specfied, all strings will be joined together.
		Otherwise, it will join [BatchSize] strigns together at a time.
	
	.EXAMPLE
		1..9 | join ","
	
		Returns "1,2,3,4,5,6,7,8,9"
	
	.EXAMPLE
		1..9 | join "," -BatchSize 5
	
		Returns "1,2,3,4,5", "6,7,8,9"
#>
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputString,
		
		[Parameter(Position = 0)]
		[string]
		$With = ([System.Environment]::NewLine),
		
		[int]
		$BatchSize
	)
	
	begin
	{
		$lines = @()
	}
	process
	{
		foreach ($line in $InputString)
		{
			$lines += $line
			
			if (($BatchSize -gt 0) -and ($lines.Count -ge $BatchSize))
			{
				$lines -join $With
				$lines = @()
			}
		}
	}
	end
	{
		$lines -join $With
	}
}
Import-PSUAlias -Name join -Command Join-PSUString