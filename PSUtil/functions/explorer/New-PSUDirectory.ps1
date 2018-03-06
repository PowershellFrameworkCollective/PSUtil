function New-PSUDirectory
{
<#
	.SYNOPSIS
		Creates a folder and moves the current path to it.
	
	.DESCRIPTION
		Creates a folder and moves the current path to it.
	
	.PARAMETER Path
		Name of the folder to create and move to.
	
	.EXAMPLE
		PS C:\> mcd Test
	
		creates folder C:\Test, then moves the current location to it.
	
	.NOTES
		Author: Donovan Brown
		Source: http://donovanbrown.com/post/How-to-create-and-navigate-a-directory-with-a-single-command
	
		Thank you for sharing and granting permission to use this convenience :)
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$Path
	)
	
	New-Item -Path $Path -ItemType Directory
	
	Set-Location -Path $Path
}

Import-PSUAlias -Name "mcd" -Command "New-PSUDirectory"