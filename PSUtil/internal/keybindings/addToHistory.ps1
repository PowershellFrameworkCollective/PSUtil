#region ALT+W : Save current line(s) in history but don't execute
Set-PSReadlineKeyHandler -Chord (Get-PSFConfigValue -FullName psutil.keybinding.sendtohistory -Fallback 'Alt+w') -BriefDescription SaveInHistory -Description "Save current line in history but do not execute" -ScriptBlock {
	
	$line = $null
	
	# Get current line(s) of input
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$null)
	
	# Add them to the command history
	[Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
	
	# Clear input line
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}
#endregion ALT+W : Save current line(s) in history but don't execute