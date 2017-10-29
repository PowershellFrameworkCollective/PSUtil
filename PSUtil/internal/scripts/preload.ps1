foreach ($function in (Get-ChildItem "$PSModuleRoot\internal\configurations\validations\*"))
{
	. Import-PSUFile -Path $function.FullName
}

foreach ($function in (Get-ChildItem "$PSModuleRoot\internal\configurations\*.ps1"))
{
	. Import-PSUFile -Path $function.FullName
}

foreach ($function in (Get-ChildItem "$PSModuleRoot\internal\functions\*"))
{
	. Import-PSUFile -Path $function.FullName
}