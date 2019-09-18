function Start-PSUTimer
{
<#
	.SYNOPSIS
		Creates a timer that will alarm the user after it has expired.
	
	.DESCRIPTION
		Creates a timer that will alarm the user after it has expired.
		Provides both visual and sound warnings.
		Also provides a progress bar with a time remaining display.
	
	.PARAMETER Duration
		The time to wait.
	
	.PARAMETER Message
		What to wait for.
	
	.PARAMETER AlarmCount
		How often to give warning.
	
	.PARAMETER NoProgress
		Disables progress bar.
	
	.PARAMETER AlarmInterval
		In what time interval to write warnings and send sound.
	
	.PARAMETER MinFrequency
		The minimum frequency of the beeps.
		Must be at least one lower than MaxFrequency.
		Increase delta to play random frequency sounds on each beep.
	
	.PARAMETER MaxFrequency
		The maximum frequency of the beeps.
		Must be at least one higher than MaxFrequency.
		Increase delta to play random frequency sounds on each beep.
	
	.EXAMPLE
		PS C:\> timer 170 Tea
		
		After 170 Duration give warning that the tea is ready.
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[CmdletBinding()]
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[Alias('Seconds')]
		[PSFDateTime]
		$Duration,
		
		[Parameter(Position = 1, Mandatory = $true)]
		$Message,
		
		[Parameter(Position = 2)]
		[int]
		$AlarmCount = 25,
		
		[switch]
		$NoProgress,
		
		[int]
		$AlarmInterval = 250,
		
		[int]
		$MinFrequency = 2999,
		
		[int]
		$MaxFrequency = 3000
	)
	
	begin
	{
		$start = Get-Date
		$end = $Duration.Value
		
		function Get-FriendlyTime
		{
			[CmdletBinding()]
			param (
				[int]
				$Seconds
			)
			
			$tempSeconds = $Seconds
			$strings = @()
			if ($tempSeconds -gt 3599)
			{
				[int]$count = [math]::Floor(($tempSeconds / 3600))
				$strings += "{0}h" -f $count
				$tempSeconds = $tempSeconds - ($count * 3600)
			}
			
			if ($tempSeconds -gt 59)
			{
				[int]$count = [math]::Floor(($tempSeconds / 60))
				$strings += "{0}m" -f $count
				$tempSeconds = $tempSeconds - ($count * 60)
			}
			
			$strings += "{0}s" -f $tempSeconds
			
			$strings -join " "
		}
	}
	process
	{
		if (-not $NoProgress)
		{
			Write-Progress -Activity "Waiting for $Message" -Status "Starting" -PercentComplete 0
		}
		
		while ($end -gt (Get-Date))
		{
			Start-Sleep -Milliseconds 500
			
			if (-not $NoProgress)
			{
				$friendlyTime = Get-FriendlyTime -Seconds ($end - (Get-Date)).TotalSeconds
				[int]$percent = ((Get-Date) - $start).TotalSeconds / ($end - $start).TotalSeconds * 100
				Write-Progress -Activity "Waiting for $Message" -Status "Time remaining: $($friendlyTime)" -PercentComplete ([System.Math]::Min($percent, 100))
			}
		}
		
		if (-not $NoProgress)
		{
			Write-Progress -Activity "Waiting for $Message" -Completed
		}
		
		$countAlarm = 0
		while ($countAlarm -lt $AlarmCount)
		{
			Write-PSFHostColor -String "(<c='sub'>$countAlarm</c>) ### <c='em'>$($Message)</c> ###"
			[System.Console]::Beep((Get-Random -Minimum $MinFrequency -Maximum $MaxFrequency), $AlarmInterval)
			Start-Sleep -Milliseconds $AlarmInterval
			$countAlarm++
		}
	}
}
Import-PSUAlias -Name "timer" -Command "Start-PSUTimer"