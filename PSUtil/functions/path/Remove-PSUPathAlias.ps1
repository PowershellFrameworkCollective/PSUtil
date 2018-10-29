function Unregister-PSUPathAlias {
    <#
    .SYNOPSIS
        Removes a path alias fromm the configuration system.
    .DESCRIPTION
        Removes a path alias from the configuration system using Unregister-PSFConfig.
        Note: This command has no effect on configuration setings currently in memory.
    .PARAMETER Alias
        The name of the Alias that you want to remove from the configuration system.
    .EXAMPLE
        PS C:\> Remove-PSUPathAlias -Alias work
        Removes the path alias named work from the configuration system.
    #>
    [CmdletBinding()]
    param (
        $Alias
    )
    Get-PSFConfig -FullName psutil.pathalias.$Alias | Unregister-PSFConfig
}