# Changelog

## Version 1.1.1.10 (2018-02-23
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