function Remove-PSUPathAlias {
    <#
    .SYNOPSIS
        Removes a path alias form the configuration system
    .DESCRIPTION
        Removes a path alias form the configuration system
    .PARAMETER Alias
        The Alias that you want to remove.
    .EXAMPLE
        PS C:\> Remove-PSUPathAlias -Alias work
        Removes the path alias named work from the configuration system.
    #>
    [CmdletBinding()]
    param (
        $Alias
    )
    #TODO write this command
}