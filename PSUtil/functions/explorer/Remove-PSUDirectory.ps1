function Remove-PSUDirectory {
	<#
	.SYNOPSIS
		Removes the current directory and moves the console to the parent folder.
	
	.DESCRIPTION
		Removes the current directory and moves the console to the parent folder.
	
	.PARAMETER Force
		Don't ask questions, just do it.
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.

	.PARAMETER WhatIf
		If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.
	
	.PARAMETER Confirm
		If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.
	
	.EXAMPLE
		PS C:\> rcd

		Tries to remove the directory and step back one level.
	#>
	[CmdletBinding(ConfirmImpact = 'High')]
	param (
		[switch]
		$Force,

		[switch]
		$EnableException
	)
	process {
		$location = Get-Location
		if ($location.Provider.Name -ne 'FileSystem') {
			Stop-PSFFunction -String 'Remove-PSUDirectory.Error.NotFileSystem' -StringValues $location -EnableException $EnableException -Cmdlet $PSCmdlet
			return
		}

		if ($location.Path -eq "$($location.Drive):\") {
			Stop-PSFFunction -String 'Remove-PSUDirectory.Error.IsRootPath' -StringValues $location -EnableException $EnableException -Cmdlet $PSCmdlet
			return
		}

		$children = Get-ChildItem -LiteralPath $location -Force -Recurse
		if ($children.Count -lt 1) {
			Set-Location -Path '..'
			Remove-Item -LiteralPath $location -Force -Confirm:$false
			return
		}

		if ($Force -or (Test-PSFShouldProcess -Target $location -ActionString 'PSUtil.Remove-PSUDirectory.RemoveItem' -ActionStringValues $children.Count, $location -PSCmdlet $PSCmdlet)) {
			Set-Location -Path '..'
			Remove-Item -LiteralPath $location -Force -Confirm:$false
		}
	}
}

Import-PSUAlias -Name "rcd" -Command "Remove-PSUDirectory"