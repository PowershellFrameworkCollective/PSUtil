#region F7 : Browse command history
<#
	This command searches the current history and provides you with a list of available options, to directly insert into your console.
	Selecting multiple lines is possible, but the order is fairly arbitrary, due to Out-Gridview.
	Note:
	There are other sources of history. My code uses Get-History, however, if you like using the PSReadline feature of a command logfile,
	you may find it useful to parse that instead. Incidentally, that's exactly what the original PSReadline example from which this snippet
	has been inspired was doing, so if that's your preference, feel free to check it out and 'pilfer' the original ;)
#>

Set-PSReadlineKeyHandler -Chord F7 -BriefDescription History -Description 'Show command history' -ScriptBlock {
	
	# Search the current history, ignore entries we don't like
	$history = [System.Collections.ArrayList]@(
		foreach ($line in (Get-History).CommandLine)
		{
			# I skip stuff that starts with regions, since that's mostly chunky stuff I copied from somewhere anyway
			# It clobbers the list and quite frankly hasn't once been something I wanted.
			if ($line -like "#region*") { continue }
			$line
		}
	)
	
	# Reverse order: The latest is the first entry
	$history.Reverse()
	
	# Show result in a gridview and accept results
	$command = $history | Out-GridView -Title "History" -PassThru
	
	# Insert selection if any
	if ($command)
	{
		# Replace current input with selection
		[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
	}
}
#endregion F7 : Browse command history