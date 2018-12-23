Register-PSFTeppArgumentCompleter -Command Invoke-PSUDesktop -Parameter User -Name psutil-userprofile

Register-PSFTeppArgumentCompleter -Command Convert-PSUObject -Parameter From -Name psutil-convert-object-from
Register-PSFTeppArgumentCompleter -Command Convert-PSUObject -Parameter To -Name psutil-convert-object-to

#region Module
Register-PSFTeppArgumentCompleter -Command Update-Module -Parameter Name -Name 'PSUtil-Module-Installed'
Register-PSFTeppArgumentCompleter -Command Uninstall-Module -Parameter Name -Name 'PSUtil-Module-Installed'
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