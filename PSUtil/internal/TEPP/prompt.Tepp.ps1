Register-PSFTeppScriptblock -Name 'psutil.prompt' -ScriptBlock {
	$module = Get-Module PSUtil
	& $module {
		foreach ($item in (Get-ChildItem "$script:ModuleRoot\internal\prompts"))
		{
			$item.BaseName -replace '\.prompt$'
		}
	}
}