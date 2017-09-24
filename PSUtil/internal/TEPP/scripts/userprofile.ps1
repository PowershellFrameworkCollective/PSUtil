$scriptBlock = {
	param (
		$commandName,
		
		$parameterName,
		
		$wordToComplete,
		
		$commandAst,
		
		$fakeBoundParameter
	)
	
	$names = Get-ChildItem "$env:SystemDrive\Users" -Force | Where-Object PSIsContainer | Expand-PSUObject Name | Where-Object { $_ -like "$wordToComplete*" } | Sort-Object
	
	foreach ($name in $names)
	{
		New-PSFTeppCompletionResult -CompletionText $name -ToolTip $name
	}
}
Register-PSFTeppScriptblock -ScriptBlock $scriptBlock -Name psutil-userprofile