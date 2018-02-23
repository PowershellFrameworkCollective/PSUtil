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
			Use a negative number to pick the last X items instead.
		
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
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Select-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
        $splat = @{ }
		if ($Skip -gt 0) { $splat["Skip"] = $Skip }
		if ($Number -ge 0) { $splat["First"] = $Number + 1 }
		else { $splat["Last"] = $Number * -1 }
		$scriptCmd = { & $wrappedCmd @splat }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline()
        $steppablePipeline.Begin($true)
	}
	
	Process
	{
		foreach ($o in $InputObject)
		{
			$steppablePipeline.Process($o)
		}
	}
	
	End
	{
		$steppablePipeline.End()
	}
}
Import-PSUAlias -Name "s" -Command "Select-PSUObjectSample"