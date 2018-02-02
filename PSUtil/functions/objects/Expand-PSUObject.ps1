function Expand-PSUObject
{
	<#
		.SYNOPSIS
			A comfortable replacement for Select-Object -ExpandProperty.
		
		.DESCRIPTION
			A comfortable replacement for Select-Object -ExpandProperty.
			Allows extracting properties with less typing and more flexibility:
	
			Preferred Properties:
			By defining a list of property-names in $DefaultExpandedProperties the user can determine his own list of preferred properties to expand.
			This allows using this command without specifying a property at all.
			It will then check the first object for the property to use (starting from the first element of the list until it finds an exact case-insensitive match).
	
			Defined Property:
			The user can specify the exact property to extract. This is the same behavior as Select-Object -ExpandProperty, with less typing (dir | exp length).
	
			Like / Match comparison:
			Specifying either like or match allows extracting any number of matching properties from each object.
			Note that this is a somewhat more CPU-expensive operation (which shouldn't matter unless with gargantuan numbers of objects).
		
		.PARAMETER Name
			ParSet: Equals, Like, Match
			The name of the Property to expand.
		
		.PARAMETER Like
			ParSet: Like
			Expands all properties that match the -Name parameter using -like comparison.
		
		.PARAMETER Match
			ParSet: Match
			Expands all properties that match the -Name parameter using -match comparison.
		
		.PARAMETER InputObject
			The objects whose properties are to be expanded.
	
		.PARAMETER RestoreDefaults
			Restores $DefaultExpandedProperties to the default list of property-names.
		
		.EXAMPLE
			PS C:\> dir | exp
	
			Expands the property whose name is the first on the defaults list ($DefaultExpandedProperties).
			By default, FullName would be expanded.
	
		.EXAMPLE
			PS C:\> dir | exp length
	
			Expands the length property of all objects returned by dir. Simply ignores those that do not have the property (folders).
	
		.EXAMPLE
			PS C:\> dir | exp name -match
	
			Expands all properties from all objects returned by dir that match the string "name" ("PSChildName", "FullName", "Name", "BaseName" for directories)
	#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidGlobalVars", "")]
	[CmdletBinding(DefaultParameterSetName = "Equals")]
	Param (
		[Parameter(Position = 0, ParameterSetName = "Equals")]
		[Parameter(Position = 0, ParameterSetName = "Like", Mandatory = $true)]
		[Parameter(Position = 0, ParameterSetName = "Match", Mandatory = $true)]
		[string]
		$Name,
		
		[Parameter(ParameterSetName = "Like", Mandatory = $true)]
		[switch]
		$Like,
		
		[Parameter(ParameterSetName = "Match", Mandatory = $true)]
		[switch]
		$Match,
		
		[Parameter(ValueFromPipeline = $true)]
		[object]
		$InputObject,
		
		[switch]
		$RestoreDefaults
	)
	
	Begin
	{
		Write-PSFMessage -Level Debug -Message "Expanding Objects" -Tag start
		$ParSet = $PSCmdlet.ParameterSetName
		Write-PSFMessage -Level InternalComment -Message "Active Parameterset: $ParSet | Bound Parameters: $($PSBoundParameters.Keys -join ", ")" -Tag start
		
		# Null the local scoped variable (So later checks for existence don't return super-scoped variables)
		$n9ZPiBh8CI = $null
		[bool]$____found = $false
		
		# If a property was specified, set it and return it
		if (Test-PSFParameterBinding -ParameterName "Name")
		{
			$n9ZPiBh8CI = $Name
			$____found = $true
		}
		
		# Restore to default if necessary
		if ($RestoreDefaults) { $global:DefaultExpandedProperties = @("Definition", "Guid", "DisinguishedName", "FullName", "Name", "Length") }
	}
	
	Process
	{
		:main foreach ($Object in $InputObject)
		{
			if ($null -eq $Object) { continue }
			
			switch ($ParSet)
			{
				#region Equals
				"Equals"
				{
					# If we didn't ask for a property in specific, and we have something prepared for this type: Run it
					if ((Test-PSFParameterBinding -ParameterName "Name" -Not) -and ([PSUtil.Object.ObjectHost]::ExpandedTypes[$Object.GetType().FullName]))
					{
						[PSUtil.Object.ObjectHost]::ExpandedTypes[$Object.GetType()].Invoke($Object)
						continue main
					}
					
					# If we already have determined the property to use, return it
					if ($____found)
					{
						if ($null -ne $Object.$n9ZPiBh8CI) { $Object.$n9ZPiBh8CI }
						continue main
					}
					
					# Otherwise, search through defaults and try to match
					foreach ($Def in $DefaultExpandedProperties)
					{
						if (Get-Member -InputObject $Object -MemberType 'Properties' -Name $Def)
						{
							$n9ZPiBh8CI = $Def
							$____found = $true
							if ($null -ne $Object.$n9ZPiBh8CI) { $Object.$n9ZPiBh8CI }
							
							break
						}
					}
					continue main
				}
				#endregion Equals
				
				#region Like
				"Like"
				{
					# Return all properties whose name are similar
					foreach ($prop in ($Object.PSObject.Properties | Where-Object Name -like $Name | Select-Object -ExpandProperty Name))
					{
						if ($null -ne $Object.$prop) { $Object.$prop }
					}
					continue
				}
				#endregion Like
				
				#region Match
				"Match"
				{
					# Return all properties whose name match
					foreach ($prop in ($Object.PSObject.Properties | Where-Object Name -Match $Name | Select-Object -ExpandProperty Name))
					{
						if ($null -ne $Object.$prop) { $Object.$prop }
					}
					continue main
				}
				#endregion Match
			}
		}
	}
	
	End
	{
		Write-PSFMessage -Level Debug -Message "Expanding Objects" -Tag end
	}
}
if (-not $global:DefaultExpandedProperties) { $global:DefaultExpandedProperties = @("Definition", "Guid", "DisinguishedName", "FullName", "Name", "Length") }
Import-PSUAlias -Name "exp" -Command "Expand-PSUObject"