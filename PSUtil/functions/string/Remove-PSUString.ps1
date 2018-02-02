function Remove-PSUString
{
<#
	.SYNOPSIS
		Trims a string.
	
	.DESCRIPTION
		Trims a string.
	
	.PARAMETER InputString
		The string that will be trimmed
	
	.PARAMETER What
		What should be trimmed?
	
	.PARAMETER Start
		Should only the start be trimmed?
	
	.PARAMETER End
		Should only the end be trimmed?
	
	.EXAMPLE
		Get-Content file.txt | trim
	
		Retrieves all content from file.txt, then trims each line.
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[OutputType([System.String])]
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		[string[]]
		$InputString,
		
		[Parameter(Position = 0)]
		[string]
		$What = "",
		
		[switch]
		$Start,
		
		[switch]
		$End
	)
	
	begin { }
	process
	{
		foreach ($line in $InputString)
		{
			if ($Start -and (-not $End)) { $line.TrimStart($What) }
			elseif ((-not $Start) -and $End) { $line.TrimEnd($What) }
			else { $line.Trim($What) }
		}
	}
	end { }
}
Import-PSUAlias -Name trim -Command Remove-PSUString