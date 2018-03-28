function Select-PSUFunctionCode
{
<#
	.SYNOPSIS
		Function that shows you the definition of a function and allows you to select lines to copy to your clipboard.
	
	.DESCRIPTION
		Function that shows you the definition of a function and allows you to select lines to copy to your clipboard.
		After running this command you will see a GridView pop up. Select as many lines of code as you would like and select
		ok to copy them to your clipboard.
	
	.PARAMETER Function
		A description of the Function parameter.
	
	.PARAMETER NoWait
		Shows function code in gridview and returns control without waiting for the window to close
	
	.PARAMETER PassThru
		Presents input command(s) in gridview, selected lines (if any) get returned as output
	
	.PARAMETER NoTrim
		If enabled, the white space will not be trimmed.
	
	.PARAMETER EnableException
		Replaces user friendly yellow warnings with bloody red exceptions of doom!
		Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		PS C:\> Select-PSUFunctionCode -function 'Start-PSUTimer'
		
		This will open up the code for the function Start-PSUTimer in a GridView window.
	
	.EXAMPLE
		PS C:\> Get-Command timer | Select-PSUFunctionCode
		
		You can also pipe functions in.
	
	.NOTES
		Additional information about the function.
#>
	
	[CmdletBinding(DefaultParameterSetName = 'Default')]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[string[]]
		$Function,
		
		[Alias('w')]
		[Parameter(ParameterSetName = 'NoWait')]
		[switch]
		$NoWait,
		
		[Alias('p')]
		[Parameter(ParameterSetName = 'PassThru')]
		[switch]
		$PassThru,
		
		[Alias('t')]
		[switch]
		$NoTrim,
		
		[switch]
		$EnableException
	)
	
	begin
	{
		Write-PSFMessage -Level InternalComment -Message "Bound parameters: $($PSBoundParameters.Keys -join ", ")" -Tag 'debug', 'start', 'param'
		
		if ($PSVersionTable.PSVersion.Major -ge 6)
		{
			Stop-PSFFunction -Message "This command is not supported on PowerShell v6 or later!" -Category NotEnabled -Tag fail, ps6
			return
		}
		
		$FinalArray = [System.Collections.Arraylist]@()
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		#region Process Items
		:main foreach ($item in $Function)
		{
			#region Resolve Command
			try { $command = Get-Command $item -ErrorAction Stop }
			catch { Stop-PSFFunction -Message "Failed to resolve command $item" -Tag fail -ErrorRecord $_ -Target $item -Continue -ContinueLabel main -EnableException $EnableException }
			
			switch ($command.CommandType)
			{
				'Alias'
				{
					if ($command.ResolvedCommand.CommandType -eq "Function")
					{
						$functionText = $command.ResolvedCommand | Expand-PSUObject | Split-PSUString "`n"
					}
					else
					{
						Stop-PSFFunction -Message "$($command.ResolvedCommand.CommandType) not supported: The alias $item resolves to $($command.ResolvedCommand). Please supply a function or an alias for a function." -Tag fail -Target $item -Continue -ContinueLabel main -EnableException $EnableException
					}
				}
				'Function'
				{
					$functionText = $command | Expand-PSUObject | Split-PSUString "`n"
				}
				default
				{
					Stop-PSFFunction -Message "$($command.CommandType) not supported: $item. Please supply a function or an alias for a function." -Tag fail -Target $item -Continue -ContinueLabel main -EnableException $EnableException
				}
			}
			#endregion Resolve Command
			
			#region Process Definition content
			$count = 1
			foreach ($line in $functionText)
			{
				$Object = [PSCustomObject]@{
					LineNumber	   = $Count
					Text		   = $line
					Function	   = $item
				}
				
				$count++
				
				if ($NoTrim)
				{
					$null = $FinalArray.add($Object)
				}
				else
				{
					if (-not ([string]::IsNullOrWhiteSpace($line)))
					{
						$null = $FinalArray.add($Object)
					}
				}
			}
			#endregion Process Definition content
		}
		#endregion Process Items
	}
	
	end
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		# This is the default behavior with no params
		if (-not ($NoWait -or $PassThru))
		{
			$data = $FinalArray | Out-GridView -PassThru -Title 'Select-PSFunctionCode' | Expand-PSUObject text
			if ($data) { $data | Set-Clipboard }
		}
		
		if ($NoWait)
		{
			$FinalArray | Out-GridView -Title 'Select-PSFunctionCode'
		}
		if ($PassThru)
		{
			$FinalArray | Out-GridView -PassThru -Title 'Select-PSFunctionCode'
		}
	}
}

Import-PSUAlias -Name "inspect" -Command "Select-PSUFunctionCode"