function prompt
{
	#region Helpers
	function frame
	{
		[CmdletBinding()]
		Param (
			$Text
		)
		
		Write-Host $Text @splatFrame
	}
	
	function cont
	{
		[CmdletBinding()]
		Param (
			$Text
		)
		
		Write-Host $Text @splatContent
	}
	#endregion Helpers
	
	$Arr = [char]9658
	#region Time Section
	$splatFrame = @{
		ForegroundColor	       = "DarkGray"
		BackgroundColor	       = "Gray"
		NoNewLine			   = $true
	}
	
	$splatContent = @{
		ForegroundColor	       = "Black"
		BackgroundColor	       = "Gray"
		NoNewLine			   = $true
	}
	
	frame "$Arr ["
	cont "$(Get-Date -Format "HH:mm:ss")"
	frame "] "
	
	$history = Get-History -ErrorAction Ignore | Select-Object -Last 1
	
	if ($history)
	{
		cont "$($history.StartExecutionTime.ToString("HH:mm:ss"))"
		frame " | "
		cont ($history.EndExecutionTime - $history.StartExecutionTime).ToString().Split(".")[0]
		frame " | "
		cont "$($history.EndExecutionTime.ToString("HH:mm:ss"))"
		
		frame " "
	}
	#endregion Time Section
	
	#region Path Section
	$splatFrame = @{
		ForegroundColor	       = "Cyan"
		BackgroundColor	       = "DarkGray"
		NoNewLine			   = $true
	}
	
	$splatContent = @{
		ForegroundColor		    = "Green"
		BackgroundColor		    = "DarkGray"
		NoNewLine			    = $true
	}
	
	frame "$Arr "
	cont $executionContext.SessionState.Path.CurrentLocation.Drive.Provider.Name
	frame " | "
	cont $executionContext.SessionState.Path.CurrentLocation.Drive.Name
	frame " | "
	cont $executionContext.SessionState.Path.CurrentLocation.ProviderPath
	frame " $("$Arr" * (1 + $NestedPromptLevel)) "
	#endregion Path Section	
	
	Write-Host ""
	" "
}