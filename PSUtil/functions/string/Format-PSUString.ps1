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
	
	.PARAMETER Property
		Property name(s) from the input object to use for formatting.
		If omitted, the base object will be used.
	
	.EXAMPLE
		1..5 | format "foo {0:D2}"
	
		returns "foo 01" through "foo 05"
	
	.EXAMPLE
		1..6 | format "foo {0:D3}-{1:D3}" -LotSize 2
	
		returns "foo 001-002","foo 003-004","foo 005-006"
	
	.EXAMPLE
		Get-ChildItem | Format-PSUString '{0} : {1}' -Property Name, Length
	
		Returns a list of strings, using the Name and Length property of the items in the current folder.
#>
	[OutputType([System.String])]
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline = $true)]
		$InputObject,
		
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$Format,
		
		[int]
		$LotSize = 1,
		
		[string[]]
		$Property
	)
	
	begin
	{
		$values = @()
	}
	process
	{
		foreach ($item in $InputObject)
		{
			$values += $item
			if ($values.Count -ge $LotSize)
			{
				if ($Property)
				{
					$propertyValues = @()
					foreach ($value in $values)
					{
						foreach ($propertyName in $Property)
						{
							$propertyValues += $value.$propertyName
						}
					}
					$Format -f $propertyValues
				}
				else
				{
					$Format -f $values
				}
				$values = @()
			}
		}
	}
	end
	{
		if ($values.Count -gt 0)
		{
			if ($Property)
			{
				$propertyValues = @()
				foreach ($value in $values)
				{
					foreach ($propertyName in $Property)
					{
						$propertyValues += $value.$propertyName
					}
				}
				$Format -f $propertyValues
			}
			else
			{
				$Format -f $values
			}
		}
	}
}
Import-PSUAlias -Name format -Command Format-PSUString