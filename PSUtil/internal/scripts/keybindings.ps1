if ((Get-PSFConfigValue -FullName "PSUtil.Import.Keybindings" -Fallback $true) -and (Get-Module PSReadline))
{
	foreach ($file in (Get-ChildItem -Path (Join-PSFPath $script:PSModuleRoot 'internal' 'keybindings')))
	{
		. Import-ModuleFile -Path $file.FullName
	}
}
