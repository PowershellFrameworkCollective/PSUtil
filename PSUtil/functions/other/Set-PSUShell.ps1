function Set-PSUShell
{
	<#
		.SYNOPSIS
			Command that sets various console properties
		
		.DESCRIPTION
			Command that sets various console properties.
		
		.PARAMETER WindowWidth
			The width of the console window.
			Not much of a change on windows 10, more of a chore on older console hosts.
		
		.PARAMETER BackgroundColor
			The background color to use.
			Is PSReadline aware.
		
		.PARAMETER ForegroundColor
			The foreground color to use.
			Is PSReadline aware.
		
		.PARAMETER BufferLength
			How lengthy a memory the console screen keeps.
			The size of the stuff cls clears.
		
		.PARAMETER WindowTitle
			The title the window should have.
		
		.PARAMETER EnableException
            Replaces user friendly yellow warnings with bloody red exceptions of doom!
            Use this if you want the function to throw terminating errors you want to catch.
		
		.EXAMPLE
			PS C:\> Set-PSUShell -WindowWidth 140 -WindowTitle "The Foo Shell" -ForegroundColor DarkGreen -BackgroundColor Black
	
			Sets the current shell to ...
			- 140 pixel width
			- have a title of "The Foo Shell"
			- Use a foreground color of DarkGreen for all output, default prompt color and comment color (PSReadline syntax detection remains unaffected)
			- Use a background color of Black
	#>
	[CmdletBinding()]
	Param (
		[int]
		$WindowWidth,
		
		[System.ConsoleColor]
		$BackgroundColor,
		
		[System.ConsoleColor]
		$ForegroundColor,
		
		[int]
		$BufferLength,
		
		[string]
		$WindowTitle,
		
		[switch]
		$EnableException
	)
	
	# Test whether the PSReadline Module is loaded
	$PSReadline = (Get-Module PSReadline) -ne $null
	
	#region Utility Functions
	function Set-ShellWindowWidth
	{
		[CmdletBinding()]
		Param (
			$WindowWidth
		)
		
		$currentWindow = $host.ui.rawui.WindowSize
		$currentBuffer = $host.ui.rawui.Buffersize
		
		if ($currentBuffer.Width -gt $WindowWidth)
		{
			# Set Window
			$currentWindow.Width = $WindowWidth
			$host.ui.rawui.WindowSize = $currentWindow
			
			# Set Buffer
			$currentBuffer.Width = $WindowWidth
			$host.ui.rawui.Buffersize = $currentBuffer
		}
		else
		{
			# Set Buffer
			$currentBuffer.Width = $WindowWidth
			$host.ui.rawui.Buffersize = $currentBuffer
			
			# Set Window
			$currentWindow.Width = $WindowWidth
			$host.ui.rawui.WindowSize = $currentWindow
		}
	}
	#endregion Utility Functions
	
	#region Set Buffer
	if (Test-PSFParameterBinding -ParameterName "BufferLength")
	{
		$currentBuffer = $host.ui.rawui.Buffersize
		$currentBuffer.Height = $BufferLength
		$host.ui.rawui.Buffersize = $currentBuffer
	}
	#endregion Set Buffer
	
	#region Set Foreground Color
	if (Test-PSFParameterBinding -ParameterName "ForegroundColor")
	{
		$host.ui.rawui.ForegroundColor = $ForegroundColor
		
		if ($PSReadline)
		{
			Set-PSReadlineOption -ContinuationPromptForegroundColor $ForegroundColor
			Set-PSReadlineOption -ForegroundColor $ForegroundColor -TokenKind 'Comment'
			Set-PSReadlineOption -ForegroundColor $ForegroundColor -TokenKind None
		}
	}
	#endregion Set Foreground Color
	
	#region Set Background Color
	if (Test-PSFParameterBinding -ParameterName "BackgroundColor")
	{
		$host.ui.rawui.BackgroundColor = $BackgroundColor
		if ($PSReadline)
		{
			Set-PSReadlineOption -ContinuationPromptBackgroundColor $BackgroundColor
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'None'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Comment'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Keyword'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'String'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Operator'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Variable'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Command'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Type'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Number'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Member'
			Set-PSReadlineOption -BackgroundColor $BackgroundColor -TokenKind 'Parameter'
			Set-PSReadlineOption -EmphasisBackgroundColor $BackgroundColor
			Set-PSReadlineOption -ErrorBackgroundColor $BackgroundColor
		}
	}
	#endregion Set Background Color
	
	#region Set Window Title
	if (Test-PSFParameterBinding -ParameterName "WindowTitle")
	{
		$host.ui.rawui.Windowtitle = $WindowTitle
	}
	#endregion Set Window Title
	
	#region Set Window Width
	if (Test-PSFParameterBinding -ParameterName "WindowWidth")
	{
		try { Set-ShellWindowWidth -WindowWidth $WindowWidth -ErrorAction Stop }
		catch
		{
			Stop-PSFFunction -Message "Failed to set window width to $WindowWidth" -EnableException $EnableException -ErrorRecord $_ -Tag 'fail', 'width', 'console', 'window'
			return
		}
	}
	#endregion Set Window Width
}