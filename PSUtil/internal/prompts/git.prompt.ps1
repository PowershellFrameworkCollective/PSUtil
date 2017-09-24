function Prompt {
	$origLastExitCode = $LASTEXITCODE
	Write-Host "[" -NoNewline
	Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Gray -NoNewline
	Write-Host "][" -NoNewline
	try {
		$history = Get-History -ErrorAction Ignore
		if ($history) {
			if (([System.Management.Automation.PSTypeName]'Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty').Type) {
				Write-Host ([Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty]($history[-1].EndExecutionTime - $history[-1].StartExecutionTime)) -ForegroundColor Gray -NoNewline
			}
			else {
				Write-Host ($history[-1].EndExecutionTime - $history[-1].StartExecutionTime) -ForegroundColor Gray -NoNewline
			}
		}
	}
	catch { }
	Write-Host "][" -NoNewline
	Write-Host "NP:$($NestedPromptLevel)" -ForegroundColor Gray -NoNewline
	Write-Host "]" -NoNewline
	Write-Host " $($executionContext.SessionState.Path.CurrentLocation.ProviderPath)" -NoNewline
	" > "
	if (Test-Path function:Write-VcsStatus) { Write-VcsStatus }
	$LASTEXITCODE = $origLastExitCode
}