# The king of aliases
Import-PSUAlias -Name "grep" -Command "Select-String"

# Add simple aliases for everyday cmdlets
Import-PSUAlias -Name "a" -Command "Get-Alias"
Import-PSUAlias -Name "c" -Command "Get-Command"
Import-PSUAlias -Name "m" -Command "Measure-Object"
Import-PSUAlias -Name "v" -Command "Get-Variable"

# Add aliases for frequent export commands
Import-PSUAlias -Name "ix" -Command "Import-PSFClixml"
Import-PSUAlias -Name "ex" -Command "Export-PSFClixml"
Import-PSUAlias -Name "ic" -Command "Import-Csv"
Import-PSUAlias -Name "ec" -Command "Export-Csv"

# Add alias for easy clipboarding
Import-PSUAlias -Name "ocb" -Command "Set-Clipboard"

# Add alias for creating object
Import-PSUAlias -Name "new" -Command "New-Object"

# Add alias for the better select and to avoid breaking on old command
Import-PSUAlias -Name "spo" -Command "Select-PSFObject"
Import-PSUAlias -Name "Select-PSUObject" -Command "Select-PSFObject"

if (Get-PSFConfigValue -FullName 'PSUtil.Import.Alias.SystemOverride')
{
	Remove-PSFAlias -Name select -Force
	Remove-PSFAlias -Name gm -Force
	Import-PSUAlias -Name select -Command 'Select-PSFObject'
	Import-PSUAlias -Name gm -Command 'Get-PSMDMember'
}