function Invoke-PSUDesktop
{
	<#
		.SYNOPSIS
			Function that sets the current console path to the user desktop.
		
		.DESCRIPTION
			Function that sets the current console path to the user desktop.
			Uses the current user's desktop by default, but can be set to the desktop of any locally available profile.
		
		.PARAMETER User
			Alias: u
			Choose which user's desktop path to move to. Must be available as a local profile for things to work out.
	
		.PARAMETER Get
			Alias: g
			Returns the path, rather than changing the location
		
		.EXAMPLE
			PS C:\> Desktop
	
			Sets the current location to the desktop path of the current user.
	#>
	[CmdletBinding()]
	Param (
		[Parameter(Position = 0)]
		[Alias('u')]
		[string]
		$User = $env:USERNAME,
		
		[Alias('g')]
		[switch]
		$Get
	)
	
	# Default Path for current user
	$Path = "$env:SystemDrive\Users\$User\Desktop"
	
	if (-not (Test-Path $Path))
	{
		Stop-PSFFunction -Message "Path to Desktop not found: $Path" -Tag fail -Target $User -Category InvalidArgument
		return
	}
	
	if ($Get) { return $Path }
	else { Push-Location $Path }
}
Import-PSUAlias -Name "desktop" -Command "Invoke-PSUDesktop"