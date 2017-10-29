#region F1 : Get Help
Set-PSReadlineKeyHandler -Chord F1 -BriefDescription CommandHelp -Description "Open the help window for the current command" -ScriptBlock {
	
	# Get current line(s) of input
	$ast = $null
	$cursor = $null
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$null, [ref]$null, [ref]$cursor)
	
	# Find the current command, use Ast to find the currently processed command, even if we are currently typing parameters for it.
	$commandAst = $ast.FindAll({
			$node = $args[0]
			$node -is [System.Management.Automation.Language.CommandAst] -and
			$node.Extent.StartOffset -le $cursor -and
			$node.Extent.EndOffset -ge $cursor
		}, $true) | Select-Object -Last 1
	
	# If we are in the process of typing a command ...
	if ($commandAst -ne $null)
	{
		# Get its name
		$commandName = $commandAst.GetCommandName()
		if ($commandName -ne $null)
		{
			# Ensure it really is its name
			$command = $ExecutionContext.InvokeCommand.GetCommand($commandName, 'All')
			if ($command -is [System.Management.Automation.AliasInfo])
			{
				$commandName = $command.ResolvedCommandName
			}
			
			# Get Help
			if ($commandName -ne $null)
			{
				# Call help based on preference
				switch (Get-PSFConfigValue -FullName 'PSUtil.Help.Preference' -Fallback ([PSUtil.Configuration.HelpOption]::Window))
				{
					"short" { Start-Process powershell.exe -ArgumentList "-NoExit -Command Get-Help $commandName" }
					"detailed" { Start-Process powershell.exe -ArgumentList "-NoExit -Command Get-Help $commandName -Detailed" }
					"examples" { Start-Process powershell.exe -ArgumentList "-NoExit -Command Get-Help $commandName -Examples" }
					"full" { Start-Process powershell.exe -ArgumentList "-NoExit -Command Get-Help $commandName -Full" }
					"online" { Get-Help $commandName -Online }
					"window" { Get-Help $commandName -ShowWindow }
					default { Get-Help $commandName -ShowWindow }
				}
			}
		}
	}
}
#endregion F1 : Get Help