function Format-PSUString
{
<#
	.SYNOPSIS
		Allows formatting objects into strings.
	
	.DESCRIPTION
		Allows formatting objects into strings.
		This is equivalent to the '-f' operator, but supports input from pipeline.
	
	.PARAMETER InputObject
		The object to format
	
	.PARAMETER Format
		The format to apply to the object
	
	.PARAMETER LotSize
		Default: 1
		How many inputo bjects should be packed into the same format string.
	
	.EXAMPLE
		1..5 | format "foo {0:D2}"
	
		returns "foo 01" through "foo 05"
	
	.EXAMPLE
		1..6 | format "foo {0:D3}-{1:D3}" -LotSize 2
	
		returns "foo 001-002","foo 003-004","foo 005-006"
#>
	[OutputType([System.String])]
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputObject,
		
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$Format,
		
		[int]
		$LotSize = 1
	)
	
	begin
	{
		$values = @()
	}
	process
	{
		foreach ($line in $InputObject)
		{
			$values += $line
			if ($values.Count -ge $LotSize)
			{
				$Format -f $values
				$values = @()
			}
		}
	}
	end
	{
		if ($values.Count -gt 0)
		{
			$Format -f $values
		}
	}
}
Import-PSUAlias -Name format -Command Format-PSUString