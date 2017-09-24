. Import-PSUFile -Path "$PSUtilModuleRoot\internal\scripts\expandedObjects.ps1"
. Import-PSUFile -Path "$PSUtilModuleRoot\internal\scripts\Aliases.ps1"

# TEPP Stuff
foreach ($file in (Get-ChildItem "$PSUtilModuleRoot\internal\TEPP\scripts"))
{
	. Import-PSUFile -Path $file.FullName
}
. Import-PSUFile -Path "$PSUtilModuleRoot\internal\TEPP\assignment.ps1"