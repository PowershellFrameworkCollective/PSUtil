. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\expandedObjects.ps1"
. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\aliases.ps1"
. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\keybindings.ps1"
. Import-PSUFile -Path "$PSModuleRoot\internal\scripts\license.ps1"

# TEPP Stuff
foreach ($file in (Get-ChildItem "$PSModuleRoot\internal\TEPP\scripts"))
{
	. Import-PSUFile -Path $file.FullName
}
. Import-PSUFile -Path "$PSModuleRoot\internal\TEPP\assignment.ps1"