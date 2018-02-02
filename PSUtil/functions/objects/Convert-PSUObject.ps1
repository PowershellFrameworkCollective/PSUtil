function Convert-PSUObject
{
<#
	.SYNOPSIS
		Converts objects from one data-type/-format to another.
	
	.DESCRIPTION
		Converts objects from one data-type/-format to another.
		For example can this be used to convert numbers from binary to hex.
	
		This function can be dynamically extended by registering conversion paths.
		Use Register-PSUObjectConversion to set up such a type conversion.
	
	.PARAMETER InputObject
		The object(s) to convert.
	
	.PARAMETER From
		The type/format that is assumed to be the input type.
	
	.PARAMETER To
		The type/format that the input is attempted to convert to.
	
	.PARAMETER EnableException
        Replaces user friendly yellow warnings with bloody red exceptions of doom!
        Use this if you want the function to throw terminating errors you want to catch.
	
	.EXAMPLE
		PS C:\> 100..110 | convert IntDec IntHex
	
		Converts the numbers 100 through 110 from decimal to hexadecimal.
#>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		$InputObject,
		
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$From,
		
		[Parameter(Mandatory = $true, Position = 1)]
		[string]
		$To,
		
		[switch]
		$EnableException
	)
	
	begin
	{
		Write-PSFMessage -Level InternalComment -Message "Bound parameters: $($PSBoundParameters.Keys -join ", ")" -Tag 'debug','start','param'
		
		if (-not ([PSUtil.Object.ObjectHost]::Conversions.ContainsKey("$($From):$($To)".ToLower())))
		{
			Stop-PSFFunction -Message "No conversion path configured for $From --> $To" -EnableException $EnableException -Category NotImplemented -Tag 'fail', 'input', 'convert'
			return
		}
		
		$scriptBlock = [System.Management.Automation.ScriptBlock]::Create([PSUtil.Object.ObjectHost]::Conversions["$($From):$($To)".ToLower()].Script)
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		foreach ($item in $InputObject)
		{
			try { $scriptBlock.Invoke($item) }
			catch
			{
				Stop-PSFFunction -Message "Failed to convert $item from $From to $To" -EnableException $EnableException -ErrorRecord $_ -Target $item -Tag 'fail','convert','item' -Continue
			}
		}
	}
	end
	{
		if (Test-PSFFunctionInterrupt) { return }
	}
}
Import-PSUAlias -Name convert -Command Convert-PSUObject