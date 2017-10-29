if ((Get-PSFConfigValue -FullName "PSUtil.Import.Keybindings" -Fallback $true) -and (Get-Module PSReadline))
{
	foreach ($file in (Get-ChildItem -Path "$script:PSModuleRoot\internal\keybindings\"))
	{
		. Import-PSUFile -Path $file.FullName
	}
}
