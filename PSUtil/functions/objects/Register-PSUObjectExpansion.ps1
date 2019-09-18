function Register-PSUObjectExpansion
{
<#
	.SYNOPSIS
		Registers a custom scriptblock for a type when processed by Expand-PSUObject.
	
	.DESCRIPTION
		Registers a custom scriptblock for a type when processed by Expand-PSUObject.
	
		Expand-PSUObject enables accelerated object expansion,
		by shortening the "Select-Object -ExpandProperty" call to "exp".
		It further has a list of default properties to expand,
		but it also allows implementing custom expansion rules, based on input type.
		
		This commands sets up these custom expansion rules.
		Define a scriptblock, it receives a single parameter - the input object to expand.
		The scriptblock is then responsible for expanding it and producing the desired output.
	
	.PARAMETER TypeName
		The name of the type to custom-expand.
	
	.PARAMETER ScriptBlock
		The scriptblock performing the expansion.
	
	.EXAMPLE
		PS C:\> Register-PSUObjectExpansion -TypeName 'MyModule.MyClass' -ScriptBlock $ScriptBlock
	
		Sets up a custom expansion rule for the 'MyModule.MyClass' class.
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$TypeName,
		
		[Parameter(Mandatory = $true, Position = 1)]
		[scriptblock]
		$ScriptBlock
	)
	
	process
	{
		[PSUtil.Object.ObjectHost]::ExpandedTypes[$TypeName] = $ScriptBlock
	}
}