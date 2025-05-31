function Backup-PSULocation
{
<#
	.SYNOPSIS
		Sets the location n number of levels up.
	
	.DESCRIPTION
		You no longer have to cd ..\..\..\..\ to move back four levels. You can now
		just type bu 4
	
	.PARAMETER Levels
		Number of levels to move back.
	
	.EXAMPLE
		PS C:\Users\dlbm3\source\pullrequests\somePR\vsteam> bu 4
		
		PS C:\Users\dlbm3>
	
	.NOTES
		Author: Donovan Brown
		Source: http://donovanbrown.com/post/Why-cd-when-you-can-just-backup
	
		Thank you for sharing and granting permission to use this convenience :)
#>
	[CmdletBinding()]
	param (
		[int]
		$Levels = (Get-PSFConfigValue -FullName 'PSUtil.Path.BackupStepsDefault' -Fallback 1)
	)
	
	Set-Location -Path (,".." * $Levels | Join-String -Separator ([System.IO.Path]::DirectorySeparatorChar))
}

Import-PSUAlias -Name "bu" -Command "Backup-PSULocation"