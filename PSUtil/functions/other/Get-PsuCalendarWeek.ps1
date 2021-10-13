function Get-PSUCalendarWeek {
<#
	.SYNOPSIS
		Calculates the calendar week of the specified date.
	
	.DESCRIPTION
		Calculates the calendar week of the specified date.
		Can be customized to fit the calendar rules of a given culture.
	
	.PARAMETER Date
		The date for which to process the calendar week.
		Defaults to the current time and date.
	
	.PARAMETER FirstDay
		Which day is considered the first day of the week.
		Defaults to the current or selected culture.
	
	.PARAMETER WeekRule
		The rule by which the first week of the year is determined.
		Defaults to the current or selected culture.
	
	.PARAMETER Culture
		The culture to use when determining the calendarweek of the specified date.
		Defaults to the current culture.
	
	.EXAMPLE
		PS C:\> Get-PSUCalendarWeek
		
		Gets the current calendar week
#>
	[CmdletBinding()]
	param (
		[PSFDateTime]
		$Date = (Get-Date),
		
		[DayOfWeek]
		$FirstDay,
		
		[System.Globalization.CalendarWeekRule]
		$WeekRule,
		
		[System.Globalization.CultureInfo]
		$Culture = (Get-Culture)
	)
	
	process {
		$first = $FirstDay
		if (Test-PSFParameterBinding -ParameterName FirstDay -Not -BoundParameters $PSBoundParameters) {
			$first = $Culture.DateTimeFormat.FirstDayOfWeek
		}
		$wRule = $WeekRule
		if (Test-PSFParameterBinding -ParameterName WeekRule -Not -BoundParameters $PSBoundParameters) {
			$wRule = $Culture.DateTimeFormat.CalendarWeekRule
		}
		$Culture.Calendar.GetWeekOfYear($Date, $wRule, $first)
	}
}