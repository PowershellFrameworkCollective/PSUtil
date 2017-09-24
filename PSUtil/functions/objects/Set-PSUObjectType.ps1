function Set-PSUObjectType
{
	<#
		.SYNOPSIS
			Tries to convert an object from one type of another.
		
		.DESCRIPTION
			Tries to convert an object from one type of another.
		
		.PARAMETER InputObject
			The objects to convert.
		
		.PARAMETER Type
			ParSet: Type
			The type to cast to.
		
		.PARAMETER TypeName
			ParSet: String
			The type to cast to.
		
		.PARAMETER EnableException
	        Replaces user friendly yellow warnings with bloody red exceptions of doom!
	        Use this if you want the function to throw terminating errors you want to catch.
		
		.EXAMPLE
			PS C:\> "01", "02", "03", "42" | Set-PSUObjectType "int"
			
			Tries to convert strings with numeric values into pure integers (hint: This will probably succeede).
	#>
	[CmdletBinding(DefaultParameterSetName = "String")]
	Param (
		[Parameter(ValueFromPipeline = $true)]
		$InputObject,
		
		[Parameter(ParameterSetName = "Type")]
		[Type]
		$Type,
		
		[Parameter(ParameterSetName = "String", Position = 0)]
		[String]
		$TypeName,
		
		[switch]
		$EnableException
	)
	
	Begin
	{
		Write-PSFMessage -Level Debug -Message "Casting Objects to another type" -Tag start
		$ParSet = $PSCmdlet.ParameterSetName
		Write-PSFMessage -Level InternalComment -Message "Active Parameterset: $ParSet | Bound Parameters: $($PSBoundParameters.Keys -join ", ")" -Tag start
		
		switch ($ParSet)
		{
			"Type" { $name = $Type.FullName }
			"String" { $name = $TypeName }
		}
	}
	Process
	{
		foreach ($object in $InputObject)
		{
			$temp = $null
			$temp = $object -as $name
			if ($temp) { $temp }
			else { Stop-PSFFunction -Message "Failed to convert '$object' to '$name'" -EnableException $EnableException -Category InvalidData -Tag fail, cast -Target $object -Continue }
		}
	}
	End
	{
		Write-PSFMessage -Level Debug -Message "Casting Objects to another type" -Tag end
	}
}
Import-PSUAlias -Name "cast" -Command "Set-PSUObjectType"