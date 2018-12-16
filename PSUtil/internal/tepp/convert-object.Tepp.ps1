Register-PSFTeppScriptblock -Name psutil-convert-object-from -ScriptBlock {
	[PSUtil.Object.ObjectHost]::Conversions.Values.From | Select-Object -Unique
}

Register-PSFTeppScriptblock -Name psutil-convert-object-to -ScriptBlock {
	[PSUtil.Object.ObjectHost]::Conversions.Values | Where-Object From -EQ $fakeBoundParameter.From | Expand-PSUObject -Name To
}