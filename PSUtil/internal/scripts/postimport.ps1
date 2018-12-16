# Add all things you want to run after importing the main code

# Load Tab Expansion
foreach ($file in (Get-ChildItem (Join-PSFPath $script:ModuleRoot 'internal' 'tepp' '*.tepp.ps1') -ErrorAction Ignore)) {
	. Import-ModuleFile -Path $file.FullName
}

# Load Tab Expansion Assignment
. Import-ModuleFile -Path "$script:ModuleRoot\internal\tepp\assignment.ps1"

# Load License
. Import-ModuleFile -Path "$script:ModuleRoot\internal\scripts\license.ps1"

. Import-ModuleFile -Path "$script:ModuleRoot\internal\scripts\expandedObjects.ps1"
. Import-ModuleFile -Path "$script:ModuleRoot\internal\scripts\aliases.ps1"
. Import-ModuleFile -Path "$script:ModuleRoot\internal\scripts\keybindings.ps1"
. Import-ModuleFile -Path "$script:ModuleRoot\bin\type-aliases.ps1"
# Import aliases for Set-PSUPath
. Import-ModuleFile -Path "$script:ModuleRoot\internal\scripts\pathAliases.ps1"

# Convert-PSUObject Conversions
foreach ($file in (Get-ChildItem (Join-PSFPath $script:ModuleRoot 'internal' 'conversions')) {
    . Import-ModuleFile -Path $file.FullName
}