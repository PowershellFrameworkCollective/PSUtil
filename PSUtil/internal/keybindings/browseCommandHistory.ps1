#region F7 : Browse command history
<#
	This command searches the current history and provides you with a list of available options, to directly insert into your console.
	Selecting multiple lines is possible, but the order is fairly arbitrary, due to Out-Gridview.
	Note:
	There are other sources of history. My code uses Get-History, however, if you like using the PSReadline feature of a command logfile,
	you may find it useful to parse that instead. Incidentally, that's exactly what the original PSReadline example from which this snippet
	has been inspired was doing, so if that's your preference, feel free to check it out and 'pilfer' the original ;)
#>

Set-PSReadlineKeyHandler -Chord (Get-PSFConfigValue -FullName psutil.keybinding.browsehistory -Fallback 'F7') -BriefDescription History -Description 'Show command history' -ScriptBlock {
	
	#region Helper function
	function Get-PSReadlineHistory
	{
		[CmdletBinding()]
		Param (
			
		)
		
		$stream = New-Object System.IO.FileStream((Get-PSReadlineOption).HistorySavePath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
		$reader = New-Object System.IO.StreamReader($stream)
		
		$currentLine = ""
		
		while (-not $reader.EndOfStream)
		{
			$line = $reader.ReadLine()
			if ($line -like '*`')
			{
				$currentLine += $line -replace '`$', "`n"
			}
			elseif ($currentLine -ne "")
			{
				$currentLine += $line
				$currentLine
				$currentLine = ""
			}
			else { $line }
		}
		$reader.Dispose()
		$stream.Dispose()
	}
	#endregion Helper function
	
	$option = Get-PSFConfigValue -FullName 'PSUtil.History.Preference' -Fallback ([PSUtil.Configuration.HistoryOption]::Global)
	$limit = Get-PSFConfigValue -FullName 'PSUtil.History.Limit' -Fallback -1
	
	if ($limit -eq 0) { return 0 }
	
	if ($option -like "Global")
	{
		$history = [System.Collections.ArrayList](Get-PSReadlineHistory)
	}
	else
	{
		# Search the current history, ignore entries we don't like
		$history = [System.Collections.ArrayList]@(
			foreach ($line in (Get-History).CommandLine)
			{
				$line
			}
		)
	}
	
	# Enforce limit, if present
	if (($limit -gt 0) -and ($history.Count -gt $limit))
	{
		$lower = $history.Count - $limit - 1
		$upper = $history.Count - 1
		[System.Collections.ArrayList]$history = $history[$lower..$upper]
	}
	
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