# Set Path Aliases for Set-PSUPath from config system
$aliases = ((Get-PSUPathAlias).name.replace('.', ' ') -split ' ')[-1]

foreach ($alias in $aliases) {
    Import-PSUAlias -Name $alias -Command 'Set-PSUPath'
}