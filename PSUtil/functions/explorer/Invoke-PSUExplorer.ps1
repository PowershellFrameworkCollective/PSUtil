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
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.
	
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
		$Duplicates,
		
		[switch]
		$EnableException
	)
	
	Begin {
		# Contains previously opened folders
		$List = @()
	}
	Process {
		foreach ($item in $Path)
		{
			try { $resolvedPaths = Resolve-PSFPath -Path $item -Provider FileSystem }
			catch { Stop-PSFFunction -Message "Path not found: $item" -EnableException $EnableException -ErrorRecord $_ -Continue -Tag input -Target $item }
			
			foreach ($resolvedPath in $resolvedPaths)
			{
				
				$object = Get-Item $resolvedPath
				
				if ($object.PSIsContainer) { $finalPath = $object.FullName }
				else { $finalPath = $object.Directory.FullName }
				
				# If it was already opened once, skip it unless duplicates are enabled
				if ((-not $Duplicates) -and ($List -contains $finalPath))
				{
					Write-PSFMessage -Level Verbose -Message "Skipping folder since it already was opened once: $finalPath" -Target $item -Tag skip
					continue
				}
				
				Write-PSFMessage -Level Verbose -Message "Opening explorer at: $finalPath"
				explorer.exe $finalPath
				$List += $finalPath
			}
		}
		
		foreach ($item in $Module)
		{
			if ((-not $Duplicates) -and ($List -contains $item.ModuleBase))
			{
				Write-PSFMessage -Level Verbose -Message "Skipping folder since it already was opened once: $($item.ModuleBase)" -Target $item -Tag skip
				continue
			}
			Write-PSFMessage -Level Verbose -Message "Opening explorer at: $($item.ModuleBase)"
			explorer.exe $item.ModuleBase
			$List += $item.ModuleBase
		}
	}
}
Import-PSUAlias -Name "explorer" -Command "Invoke-PSUExplorer"