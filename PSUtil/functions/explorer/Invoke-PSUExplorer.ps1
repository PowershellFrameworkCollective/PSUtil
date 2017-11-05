function Invoke-PSUExplorer
{
<#
	.SYNOPSIS
		Opens the windows explorer at the specified position.
	
	.DESCRIPTION
		Opens the windows explorer at the specified position.
	
	.PARAMETER Path
		Alias:   FullName
		Default: (Get-Location).Path
		The folder to open in explorer. If a file was passed the containing folder will be opened instead.
	
	.PARAMETER Module
		The module, the base folder of which should be opened.
	
	.PARAMETER Duplicates
		Setting this switch will cause the function to open the same folder multiple times, if it was passed multiple times.
		By default, the function will not open the same folder multiple times (a dir of a directory with multiple files would otherwise cause multiple open windows).
	
	.EXAMPLE
		PS C:\> dir | Explorer
		
		Opens each folder in the current directory in a separate explorer Window.
#>
	[CmdletBinding()]
	Param (
		[Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('FullName')]
		[string[]]
		$Path = (Get-Location).ProviderPath,
		
		[System.Management.Automation.PSModuleInfo[]]
		$Module,
		
		[switch]
		$Duplicates
	)
	
	Begin {
		Write-PSFMessage -Level Debug -Message "Opening Windows Explorer at target path(s)" -Tag start
		
		# Contains previously opened folders
		$List = @()
	}
	Process {
		foreach ($Item in $Path) {
			$resolvedPath = Resolve-Path $Item
			
			if (-not (Test-Path $resolvedPath))
			{
				Stop-PSFFunction -Message "Path not found: $resolvedPath | $Item" -Continue -Category InvalidArgument -Tag input -Target $Item
			}
			
			$object = Get-Item $resolvedPath
			
			if ($object.PSIsContainer) { $finalPath = $object.FullName }
			else { $finalPath = $object.Directory.FullName }
			
			# If it was already opened once, skip it unless duplicates are enabled
			if ((-not $Duplicates) -and ($List -contains $finalPath))
			{
				Write-PSFMessage -Level Verbose -Message "Skipping folder since it already was opened once: $finalPath" -Target $Item -Tag skip
				continue
			}
			
			explorer.exe $finalPath
			$List += $finalPath
		}
		
		foreach ($Item in $Module)
		{
			if ((-not $Duplicates) -and ($List -contains $Item.ModuleBase))
			{
				Write-PSFMessage -Level Verbose -Message "Skipping folder since it already was opened once: $($Item.ModuleBase)" -Target $Item -Tag skip
				continue
			}
			explorer.exe $Item.ModuleBase
			$List += $Item.ModuleBase
		}
	}
	End {
		Write-PSFMessage -Level Debug -Message "Opening Windows Explorer at target path(s)" -Tag end
	}
}
Import-PSUAlias -Name "explorer" -Command "Invoke-PSUExplorer"