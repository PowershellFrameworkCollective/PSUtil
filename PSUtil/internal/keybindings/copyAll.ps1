#region CTRL+SHIFT+C : Copy all lines of the current command to clipboard
Set-PSReadlineKeyHandler -Chord Ctrl+Shift+c -BriefDescription CopyAllLines -Description "Copies the all lines of the current command into the clipboard" -ScriptBlock {
	
	# Get current code
	$line = $null
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$null)
	
	# Paste it to clipboard
	Set-Clipboard $line
}
#endregion CTRL+SHIFT+C : Copy all lines of the current command to clipboard