function Set-PSUPrompt
{
<#
	.SYNOPSIS
		Applies one of the pre-defined prompts.
	
	.DESCRIPTION
		Applies one of the pre-defined prompts.
	
	.PARAMETER Prompt
		The prompt to apply
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.
	
	.EXAMPLE
		PS C:\> Set-PSUPrompt -Prompt fred
	
		Applies the prompt fred uses.
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]
		$Prompt,
		
		[switch]
		$EnableException
	)
	
	process
	{
		if (-not (Test-Path "$script:ModuleRoot\internal\prompts\$Prompt.prompt.ps1"))
		{
			Stop-PSFFunction -Message "Failed to find prompt: $Prompt" -Target $Prompt -EnableException $EnableException -Category ObjectNotFound
			return
		}
		& "$script:ModuleRoot\internal\prompts\$Prompt.prompt.ps1"
	}
}