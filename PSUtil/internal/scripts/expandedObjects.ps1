<#
In this file, all default expansion definitions are stored.
Wrap into a region each, with corresponding region label.
#>

#region Microsoft.PowerShell.Commands.MatchInfo
[PSUtil.Object.ObjectHost]::ExpandedTypes[[Microsoft.PowerShell.Commands.MatchInfo]] = {
	param (
		$Object
	)
	
	foreach ($item in $Object.Matches)
	{
		$item.Groups[1 .. ($item.Groups.Count - 1)].Value
	}
}
#endregion Microsoft.PowerShell.Commands.MatchInfo

#region Microsoft.PowerShell.Commands.MemberDefinition
[PSUtil.Object.ObjectHost]::ExpandedTypes[[Microsoft.PowerShell.Commands.MemberDefinition]] = {
	param (
		$Object
	)
	
	$Object.Definition.Replace("), ", ")þ").Split("þ")
}
#endregion Microsoft.PowerShell.Commands.MemberDefinition

#region System.Management.Automation.FunctionInfo
[PSUtil.Object.ObjectHost]::ExpandedTypes[[System.Management.Automation.FunctionInfo]] = {
	param (
		$Object
	)
	
	@"
function $($Object.Name)
{
$($Object.Definition)
}
"@
}
#endregion System.Management.Automation.FunctionInfo

#region System.Management.Automation.AliasInfo
[PSUtil.Object.ObjectHost]::ExpandedTypes[[System.Management.Automation.AliasInfo]] = {
	param (
		$Object
	)
	
	if ($Object.ResolvedCommand.CommandType -eq "Function")
	{
		@"
function $($Object.ResolvedCommand.Name)
{
$($Object.ResolvedCommand.Definition)
}
"@
	}
	else
	{
		$Object.ResolvedCommand
	}
}
#endregion System.Management.Automation.AliasInfo