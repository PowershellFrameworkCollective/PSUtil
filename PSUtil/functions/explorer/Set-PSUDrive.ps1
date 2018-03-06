function Set-PSUDrive
{
<#
	.SYNOPSIS
		Creates a new psdrive, and moves location to it.
	
	.DESCRIPTION
		Will create a PSDrive, by default in the current path.
		This allows swiftly reducing path length.
		Then it will immediately change location to the new drive.
	
	.PARAMETER Name
		What to name the new PSDrive?
	
	.PARAMETER Root
		Default: .
		The root of the new drive.
	
	.EXAMPLE
		PS C:\> set-as pr
	
		Sets the current path as drive "pr" and sets it as the current location.
	
	.NOTES
		Author: Donovan Brown
		Source: http://donovanbrown.com/post/Shorten-your-PowerShell-directory-path
	
		Thank you for sharing and granting permission to use this convenience :)
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$Name,
		
		[string]
		$Root = "."
	)
	
	$path = Resolve-Path $Root
	$null = New-PSDrive -PSProvider $path.Provider -Name $Name -Root $Root -Scope Global
	Set-Location -LiteralPath "$($Name):"
}

Import-PSUAlias -Name "set-as" -Command "Set-PSUDrive"