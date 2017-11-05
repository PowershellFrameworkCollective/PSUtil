# The king of aliases
Import-PSUAlias -Name "grep" -Command "Select-String"

# Add simple aliases for everyday cmdlets
Import-PSUAlias -Name "a" -Command "Get-Alias"
Import-PSUAlias -Name "c" -Command "Get-Command"
Import-PSUAlias -Name "m" -Command "Measure-Object"
Import-PSUAlias -Name "v" -Command "Get-Variable"

# Add aliases for frequent export commands
Import-PSUAlias -Name "ix" -Command "Import-Clixml"
Import-PSUAlias -Name "ex" -Command "Export-Clixml"
Import-PSUAlias -Name "ic" -Command "Import-Csv"
Import-PSUAlias -Name "ec" -Command "Export-Csv"

# Add alias for easy clipboarding
Import-PSUAlias -Name "ocb" -Command "Set-Clipboard"