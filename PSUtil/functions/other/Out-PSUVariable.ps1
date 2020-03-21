function Out-PSUVariable
{
<#
	.SYNOPSIS
		Writes the input to a variable.
	
	.DESCRIPTION
		Writes the input to a variable.
		This allows doing variable assignments at the end of a pipeline, rather than just at the beginning.
	
		Previous contents will be overwritten.
	
	.PARAMETER Name
		The name of the variable to write to.
	
	.PARAMETER InputObject
		The objects to write.
	
	.EXAMPLE
		PS C:\> Get-ChildItem | Out-PSUVariable -Name 'files'
	
		Writes the files & folders in the current path into the variable $files
	
	.EXAMPLE
		PS C:\> dir | ov files
	
		Does the same thing as the first example, only this time in a convenient interactive commandline usage
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$Name,
		
		[Parameter(ValueFromPipeline = $true)]
		$InputObject
	)
	
	begin
	{
		$list = New-Object System.Collections.Generic.List[Object]
	}
	process
	{
		foreach ($object in $InputObject)
		{
			$list.Add($object)
		}
	}
	end
	{
		# Write to caller scope
		$PSCmdlet.SessionState.PSVariable.Set($Name, ($list | Write-Output))
	}
}
Import-PSUAlias -Name ov -Command Out-PSUVariable