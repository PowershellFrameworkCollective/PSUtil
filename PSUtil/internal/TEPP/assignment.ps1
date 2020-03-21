Register-PSFTeppArgumentCompleter -Command Invoke-PSUDesktop -Parameter User -Name psutil-userprofile

Register-PSFTeppArgumentCompleter -Command Convert-PSUObject -Parameter From -Name psutil-convert-object-from
Register-PSFTeppArgumentCompleter -Command Convert-PSUObject -Parameter To -Name psutil-convert-object-to

Register-PSFTeppArgumentCompleter -Command Set-PSUPrompt -Parameter Prompt -Name 'psutil.prompt'

#region Module
Register-PSFTeppArgumentCompleter -Command Update-Module -Parameter Name -Name 'PSUtil-Module-Installed'
Register-PSFTeppArgumentCompleter -Command Uninstall-Module -Parameter Name -Name 'PSUtil-Module-Installed'
Register-PSFTeppArgumentCompleter -Command Get-InstalledModule -Parameter Name -Name 'PSUtil-Module-Installed'
Register-PSFTeppArgumentCompleter -Command Install-Module -Parameter Name -Name 'PSUtil-Module-Total'

Register-PSFTeppArgumentCompleter -Command Find-Command -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Find-DscResource -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Find-Module -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Find-RoleCapability -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Find-Script -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Install-Module -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Install-Script -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Publish-Module -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Publish-Script -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Save-Module -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Save-Script -Parameter Repository -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Get-PSRepository -Parameter Name -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Unregister-PSRepository -Parameter Name -Name 'PSUtil-Module-Repository'
Register-PSFTeppArgumentCompleter -Command Register-PSRepository -Parameter PackageManagementProvider -Name 'PSUtil-Module-PackageProvider'
#endregion Module

#region Input Object Property
Register-PSFTeppArgumentCompleter -Command Select-Object -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Select-Object -Parameter ExpandProperty -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Select-Object -Parameter ExcludeProperty -Name PSFramework-Input-ObjectProperty

Register-PSFTeppArgumentCompleter -Command Expand-PSUObject -Parameter Name -Name PSFramework-Input-ObjectProperty

Register-PSFTeppArgumentCompleter -Command Get-Member -Parameter Name -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Format-Table -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Format-List -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Group-Object -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Measure-Object -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Sort-Object -Parameter Property -Name PSFramework-Input-ObjectProperty
Register-PSFTeppArgumentCompleter -Command Where-Object -Parameter Property -Name PSFramework-Input-ObjectProperty
#endregion Input Object Property

Register-PSFTeppArgumentCompleter -Command Read-PSUKnowledge -Parameter Book -Name 'PSUtil.Knowledge.Book'
Register-PSFTeppArgumentCompleter -Command Read-PSUKnowledge -Parameter Name -Name 'PSUtil.Knowledge.Page'
Register-PSFTeppArgumentCompleter -Command Read-PSUKnowledge -Parameter Tags -Name 'PSUtil.Knowledge.Tags'
Register-PSFTeppArgumentCompleter -Command Remove-PSUKnowledge -Parameter Book -Name 'PSUtil.Knowledge.Book'
Register-PSFTeppArgumentCompleter -Command Remove-PSUKnowledge -Parameter Name -Name 'PSUtil.Knowledge.Page'
Register-PSFTeppArgumentCompleter -Command Write-PSUKnowledge -Parameter Book -Name 'PSUtil.Knowledge.Book'
Register-PSFTeppArgumentCompleter -Command Write-PSUKnowledge -Parameter Tags -Name 'PSUtil.Knowledge.Tags'