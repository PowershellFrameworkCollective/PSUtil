# Add all things you want to run before importing the main code
foreach ($function in (Get-ChildItem "$script:ModuleRoot\internal\configurations\validations\*"))
{
	. Import-ModuleFile -Path $function.FullName
}

foreach ($function in (Get-ChildItem "$script:ModuleRoot\internal\configurations\*.ps1"))
{
	. Import-ModuleFile -Path $function.FullName
}

foreach ($function in (Get-ChildItem "$script:ModuleRoot\internal\functions\*"))
{
	. Import-ModuleFile -Path $function.FullName
}