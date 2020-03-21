# The king of aliases
Import-PSUAlias -Name "grep" -Command "Select-String"

# Strings
Import-PSUAlias -Name add -Command Add-String
Import-PSUAlias -Name Add-PSUString -Command Add-String
Import-PSUAlias -Name wrap -Command Add-String
Import-PSUAlias -Name Add-PSUString -Command Add-String
Import-PSUAlias -Name format -Command Format-String
Import-PSUAlias -Name Format-PSUString -Command Format-String
Import-PSUAlias -Name trim -Command Get-SubString
Import-PSUAlias -Name Remove-PSUString -Command Get-SubString
Import-PSUAlias -Name join -Command Join-String
Import-PSUAlias -Name Join-PSUString -Command Join-String
Import-PSUAlias -Name replace -Command Set-String
Import-PSUAlias -Name Set-PSUString -Command Set-String
Import-PSUAlias -Name split -Command Split-String
Import-PSUAlias -Name Split-PSUString -Command Split-String

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
Import-PSUAlias -Name "ctj" -Command "ConvertTo-Json"
Import-PSUAlias -Name "cfj" -Command "ConvertFrom-Json"
Import-PSUAlias -Name "ctx" -Command "ConvertTo-PSFClixml"
Import-PSUAlias -Name "cfx" -Command "ConvertFrom-PSFClixml"

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

Import-PSUAlias -Name "rmn" -Command "Remove-PSFNull"