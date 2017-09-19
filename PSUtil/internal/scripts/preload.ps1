foreach ($function in (Get-ChildItem "$PSUtilModuleRoot\internal\functions"))
{
	. Import-PSUFile -Path $function.FullName
}