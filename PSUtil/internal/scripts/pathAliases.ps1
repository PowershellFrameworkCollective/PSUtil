# Set Path Aliases for Set-PSUPath from config system
$aliases = ((Get-PSUPathAlias).name -split '\.')[-1]

foreach ($alias in $aliases) {
    Import-PSUAlias -Name $alias -Command 'Set-PSUPath'
}