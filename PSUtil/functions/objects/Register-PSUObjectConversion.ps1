function Register-PSUObjectConversion
{
<#
	.SYNOPSIS
		Registers an object conversion for Convert-PSUObject.
	
	.DESCRIPTION
		This command can be used to register an object conversion for Convert-PSUObject, allowing the user to extend the conversion utility as desired.
	
	.PARAMETER From
		The input type. Using a suitable shorthand is recommended ("int" rather than "System.Int32", etc.).
	
	.PARAMETER To
		The conversion target type. Using a suitable shorthand is recommended ("int" rather than "System.Int32", etc.).
	
	.PARAMETER ScriptBlock
		The scriptblock that will be invoked to convert.
		Receives a single argument: The input object to convert.
	
	.EXAMPLE
		PS C:\> Register-PSUObjectConversion -From 'dec' -To 'oct' -ScriptBlock $ScriptBlock
	
		Registers a conversion that is supposed to convert a decimal into an octal number.
#>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[string]
		$From,
		
		[Parameter(Mandatory = $true)]
		[string]
		$To,
		
		[Parameter(Mandatory = $true)]
		[System.Management.Automation.ScriptBlock]
		$ScriptBlock
	)
	
	process
	{
		$conversion = New-Object PSUtil.Object.ObjectConversionMapping -Property @{
			From   = $From.ToLower()
			To     = $To.ToLower()
			Script = $ScriptBlock
		}
		
		[PSUtil.Object.ObjectHost]::Conversions["$($From):$($To)".ToLower()] = $conversion
	}
}