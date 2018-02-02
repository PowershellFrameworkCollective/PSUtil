function Add-PSUString
{
<#
	.SYNOPSIS
		Makes it easy to add content to a string at pipeline.
	
	.DESCRIPTION
		Makes it easy to add content to a string at pipeline.
	
	.PARAMETER InputString
		The string(s) to add content to
	
	.PARAMETER Before
		What is prepended to the input string.
	
	.PARAMETER After
		What is appended to the input string
	
	.EXAMPLE
		1..10 | Add-PSUString "srv-ctx" "-dev"
	
		Returns a set of strings from 'srv-ctx1-dev' through 'srv-ctx10-dev'
#>
	[OutputType([System.String])]
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputString,
		
		[Parameter(Position = 0)]
		[string]
		$Before = "",
		
		[Parameter(Position = 1)]
		[string]
		$After = ""
	)
	
	begin { }
	process
	{
		foreach ($line in $InputString)
		{
			"$($Before)$($line)$($After)"
		}
	}
	end { }
}
Import-PSUAlias -Name add -Command Add-PSUString
Import-PSUAlias -Name wrap -Command Add-PSUString