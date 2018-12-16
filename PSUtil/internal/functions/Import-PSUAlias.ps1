function Import-PSUAlias
{
	<#
		.SYNOPSIS
			Internal command to set aliases in a user-controlled fashion.
		
		.DESCRIPTION
			Internal command to set aliases in a user-controlled fashion.
			- Can be blocked by setting a config "PSUtil.Import.Aliases.$Name" to $false.
			- Will not overwrite existing aliases
		
		.PARAMETER Name
			Name of the alias to set.
		
		.PARAMETER Command
			Name of the command to alias.
		
		.EXAMPLE
			PS C:\> Import-PSUAlias -Name grep -Command Select-String
	
			Sets the alias grep for the command Select-String
	#>
	
	[CmdletBinding()]
	Param (
		$Name,
		
		$Command
	)
	
	if ((-not (Test-Path alias:$name)) -and (Get-PSFConfigValue -FullName PSUtil.Import.Aliases.$name -Fallback $true))
	{
		New-Alias -Name $Name -Value $Command -Force -Scope Global
	}
}