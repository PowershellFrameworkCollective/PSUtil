# Changelog 2.0.0.0
 - new: Command Get-PSUPathAlias lists all current path aliases
 - new: Command Remove-PSUPathAlias removes a path alias
 - new: Command Set-PSUPath used to implement the path alias functionality
 - new: Command Set-PSUPathAlias creates or updates an alias for a path
 - other: Major project refactoring
 - rem: Command `Select-PSUObject` has been removed
 - new: Alias `Select-PSUObject` pointing at `Select-PSFPobject`
 - upd: Alias `ex` now points at `Export-PSFClixml`
 - upd: Alias `ix` now points at `Import-PSFClixml`
 - upd: Alias `spo` now points at `Select-PSFObject`

## Version 1.1.5.17 (2018-06-19)
 - new: Command Select-PSUObject - Select-Object in awesome.
 - upd: Command Set-PSUString / replace - can now do lambda replacement

## Version 1.1.4.15 (2018-03-30)
 - new: Select-PSUFunctionCode / Inspect

## Version 1.1.3.13 (2018-03-20)
 - new: Command Start-PSUTimer / timer

## Version 1.1.2.12 (2018-03-06)
 - new: Command Backup-PSULocation / bu (#18)
 - new: Command Set-PSUDrive / set-as (#18)
 - new: Command New-PSUDirectory / mcd (#18)

## Version 1.1.1.10 (2018-02-23)
 - upd: Select-PSUObjectSample / s can now select last items (#15)
 - fix: Format-PSUString / format will now format numbers correctly (#14)

## Version 1.1.1.9 (2018-02-02)
 - new: Command Convert-PSUObject / convert. (#9)
   Allows converting input from a source format to a destination format. Can be dynamically extended.
 - new: Command Register-PSUObjectConversion. (#9)
   Registers conversion path for Convert-PSUObject.
 - new: Added module tests and build definition for CI/CD integration
 - upd: All keybindings can now be configured using the config system. Changes require reimport to apply. (#7)
 - fix: Fixed 'replace' not accepting empty string as replace with option (#8)