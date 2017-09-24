function Invoke-PSUTemp
{
	<#
		.SYNOPSIS
			Moves the current location to a temp directory.
		
		.DESCRIPTION
			Moves the current location to a temp directory.
	
			The path returned can be set by configuring the 'psutil.path.temp' configuration. E.g.:
			Set-PSFConfig "psutil.path.temp" "D:\temp\_Dump"
	
			If this configuration is not set, it will check the following locations and return the first one found:
			C:\Temp
			D:\Temp
			E:\Temp
			C:\Service
			$env:temp
		
		.PARAMETER Get
			Alias: g
			Rather than move to the directory, return its path.
		
		.EXAMPLE
			PS C:\> Invoke-PSUTemp
	
			Moves to the temporary directory.
	#>
	[CmdletBinding()]
	Param (
		[Alias('g')]
		[switch]
		$Get
	)
	
	if ($Get) { Get-PSFConfigValue -FullName 'PSUtil.Path.Temp' -Fallback $env:TEMP }
	else { Push-Location -Path (Get-PSFConfigValue -FullName 'PSUtil.Path.Temp' -Fallback $env:TEMP) }
}
Import-PSUAlias -Name "temp" -Command "Invoke-PSUTemp"