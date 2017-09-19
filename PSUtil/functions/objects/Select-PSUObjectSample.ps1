function Select-PSUObjectSample
{
	<#
		.SYNOPSIS
			Used to only pick a sample from the objects passed to the function.
		
		.DESCRIPTION
			Used to only pick a sample from the objects passed to the function.
		
		.PARAMETER InputObject
			The objects to pick a sample from.
		
		.PARAMETER Skip
			How many objects to skip.
		
		.PARAMETER Number
			How many objects to pick
		
		.EXAMPLE
			PS C:\> Get-ChildItem | Select-PSUObjectSample -Skip 1 -Number 3
	
			Scans the current directory, skips the first returned object, then passes through the next three objects and skips the rest.
		
		.EXAMPLE
			PS C:\> dir | s 3 1
	
			Same as the previous example, only this time using aliases and positional binding.
			Scans the current directory, skips the first returned object, then passes through the next three objects and skips the rest.
	#>
	[CmdletBinding()]
	Param (
		[Parameter(ValueFromPipeline = $true, Mandatory = $true)]
		$InputObject,
		
		[Parameter(Position = 1)]
		[int]
		$Skip = 0,
		
		[Parameter(Position = 0)]
		[int]
		$Number = 1
	)
	
	Begin
	{
		# Counter for how many objects were skipped
		$skipped = 0
		
		# Counter for how many objects were sent onwards
		$sent = 0
	}
	
	Process
	{
		foreach ($o in $InputObject)
		{
			# If we have yet to skip objects, do so and continue with the next object
			if ($Skip -gt $skipped) { $skipped++; continue }
			
			# If we have yet to send on an object, do so, then continue with the next object
			if ($sent -lt $Number) { $sent++; $o; continue }
		}
	}
	
	End
	{
		
	}
}
Import-PSUAlias -Name "s" -Command "Select-PSUObjectSample"