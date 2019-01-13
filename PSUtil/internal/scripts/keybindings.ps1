if ((Get-Module psreadline).Version.Major -ge 2)
{
	Set-PSReadlineKeyHandler -Chord 'Shift+SpaceBar' -BriefDescription Whitespace -Description "Inserts a whitespace" -ScriptBlock {
		[Microsoft.Powershell.PSConsoleReadLine]::Insert(' ')
	}
}

if ((Get-PSFConfigValue -FullName "PSUtil.Import.Keybindings" -Fallback $true) -and (Get-Module PSReadline))
{
	foreach ($file in (Get-ChildItem -Path (Join-PSFPath $script:ModuleRoot 'internal' 'keybindings')))
	{
		. Import-ModuleFile -Path $file.FullName
	}
}
