function prompt {
	Write-Host "[" -NoNewline
	Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Gray -NoNewline
	try {
		$history = Get-History -ErrorAction Ignore
		if ($history) {
			Write-Host "][" -NoNewline
			if (([System.Management.Automation.PSTypeName]'Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty').Type) {
				Write-Host ([Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty]($history[-1].EndExecutionTime - $history[-1].StartExecutionTime)) -ForegroundColor Gray -NoNewline
			}
			else {
				Write-Host ($history[-1].EndExecutionTime - $history[-1].StartExecutionTime) -ForegroundColor Gray -NoNewline
			}
		}
	}
	catch { }
	Write-Host "] $($executionContext.SessionState.Path.CurrentLocation.ProviderPath)" -NoNewline
	"> "
}