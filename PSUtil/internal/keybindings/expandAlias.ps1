#region Shift+Space : Expand Alias
Set-PSReadlineKeyHandler -Chord (Get-PSFConfigValue -FullName psutil.keybinding.expandalias -Fallback 'Shift+Spacebar') -BriefDescription ExpandAlias -Description "Converts aliases into the resolved command / parameter" -ScriptBlock {
	
	# Get current line(s) of input
	$tokens = $null
	$ast = $null
	$cursor = $null
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$null, [ref]$cursor)
	
	$changes = @()
	$currentCommand = $null
	foreach ($token in $tokens)
	{
		if (($token.TokenFlags -eq "CommandName") -and ($token.Kind -eq "Identifier"))
		{
			$currentCommand = Get-Command $token.Text -ErrorAction Ignore
			if ($alias = Get-Alias -Name $token.Text -ErrorAction Ignore)
			{
				$currentCommand = $alias.ResolvedCommand
				$changes += New-Object PSObject -Property @{
					Text   = $alias.ResolvedCommand.Name
					Start  = $token.Extent.StartOffset
					Length = $token.Extent.EndOffset - $token.Extent.StartOffset
				}
			}
		}
		
		if (($token.Kind -eq "Parameter") -and ($currentCommand -ne $null))
		{
			if ($currentCommand.Parameters.Keys -contains $token.ParameterName) { }
			else
			{
				$paramhash = @{ }
				foreach ($parameter in $currentCommand.Parameters.Values)
				{
					$paramhash[$parameter.Name] = $parameter.Name
					foreach ($a in $parameter.Aliases) { $paramhash[$a] = $parameter.Name }
				}
				
				
				$resolvedParameter = ""
				if ($paramhash.ContainsKey($token.ParameterName)) { $resolvedParameter = $paramhash[$token.ParameterName] }
				else
				{
					$results = $null
					$results = $paramhash.Keys | Where-Object { $_ -like "$($token.ParameterName)*" }
					if ($results)
					{
						if (($results | Measure-Object).Count -eq 1)
						{
							$resolvedParameter = $paramhash[$results]
						}
					}
				}
				
				if ($resolvedParameter -ne "")
				{
					$changes += New-Object PSObject -Property @{
						Text    = "-$resolvedParameter"
						Start   = $token.Extent.StartOffset
						Length  = $token.Extent.EndOffset - $token.Extent.StartOffset
					}
				}
			}
		}
	}
	
	$finishedString = ""
	
	if ($changes.Count -eq 0) { return }
	else
	{
		$source = $ast.Extent.Text
		$count = 0
		$index = 0
		
		while ($count -lt $changes.Count)
		{
			if ($changes[$count].Start -gt $index)
			{
				$finishedString += $source.SubString($index, ($changes[$count].Start - $index))
			}
			$finishedString += $changes[$count].Text
			$index = $changes[$count].Start + $changes[$count].Length
			
			$count++
		}
		
		if (($index + 1) -lt $source.Length)
		{
			$finishedString += $source.SubString($index)
		}
	}
	
	[Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $source.Length, $finishedString, $null, $null)
}
#endregion Shift+Space : Expand Alias