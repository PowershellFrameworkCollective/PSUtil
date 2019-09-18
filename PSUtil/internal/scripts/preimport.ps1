# Add all things you want to run before importing the main code
foreach ($file in (Get-ChildItem "$script:ModuleRoot\internal\configurations\validations" -Filter '*.ps1'))
{
	. Import-ModuleFile -Path $file.FullName
}

foreach ($file in (Get-ChildItem "$script:ModuleRoot\internal\configurations" -Filter '*.ps1'))
{
	. Import-ModuleFile -Path $file.FullName
}