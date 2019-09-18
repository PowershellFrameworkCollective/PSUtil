function global:prompt {
	Write-Host "[" -NoNewline
	Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Gray -NoNewline
	try {
		$history = Get-History -ErrorAction Ignore
		if ($history) {
			Write-Host "][" -NoNewline
			Write-Host ([PSUtil.Utility.PsuTimeSpanPretty]($history[-1].EndExecutionTime - $history[-1].StartExecutionTime)) -ForegroundColor Gray -NoNewline
		}
	}
	catch { }
	Write-Host "] $($executionContext.SessionState.Path.CurrentLocation.ProviderPath)" -NoNewline
	"> "
}