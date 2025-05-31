# Changelog

## 2.2.38 (2025-05-31)

+ New: Remove-PSUDirectory - Removes the current directory and moves the console to the parent folder.
+ Upd: Prompt Fred - added nested prompt level if greater than 0
+ Fix: Remove-PSUKnowledge - now actually works

## 2.2.35 (2021-10-13)

+ New: Object Conversion - NT <--> SID
+ New: Object Conversion - string <--> base64
+ New: Command Get-PSUCalendarWeek - Calculates the calendar week of the specified date.
+ Upd: Start-PSUTimer - added `-RandomInterval` parameter, randomizing the sound playback interval
+ Upd: Start-PSUTimer - added `-DisableScreensaver` parameter, blocking screensaver for the duration of the timer
+ Upd: Start-PSUTimer - now automatically adds a day if the destination-time is in the past
+ Upd: Manifest - added ctx and cfx to the aliases exported, enabling auto-import from using those.

## 2.1.28 (2020-03-21)

+ New: Component: Knowledge - store and search knowledge
+ New: Command: Read-PSUKnowledge (read, page, learn) - retrieves stored knowledge
+ New: Command: Write-PSUKnowledge - writes knowledge for later retrieval
+ New: Command: Remove-PSUKnowledge - removes knowledge from storage. Use on alternative facts.
+ New: Command: Out-PSUVariable - writes input to variable, enabling variable assignment at the end of the pipeline
+ New: Alias rmn --> Remove-PSFNull
+ New: Dependency on string module, dropping own string cmdlets, ading aliases for compatibility
+ New: Adding psf tab completion for property names to common object commands

## 2.0.20 (2019-09-18)

+ New: Command: Set-PSUPrompt - Applies a prompt from a set of pre-defined prompts
+ New: Command: Register-PSUObjectExpansion - Registers custom expansion rules for Expand-PSUObject
+ Upd: Start-PSUTimer - Added -MinFrequency and -MaxFrequency parameters.
+ Upd: Start-PSUTimer - Refactored parameter order, rationalized message handling
+ Upd: Invoke-PSUExplorer - Enabled opt-in exceptions and improved path resolution
+ Upd: Set-PSUPath - Now supports environment variable expansion using %name% notation.
+ Fix: Importing module from UNC path works
+ Fix: Module import concurrency issue
+ Fix: Convert-PSUObject unsafe Scriptblock handling
+ Fix: Set-PSUShell foreground color handling (requires latest pre-release version of PSReadline)
+ Fix: F1 Keybinding: On non-windows default to detailed help, rather than -ShowWindow
+ Fix: F1 Keybinding: In-Console help display now uses same application as launching application

## Version 2.0.8 (2019-01-13)

+ New: Keybinding for `Shift+SpaceBar` on PSReadline 2.0 that inserts a whitespace, helping to mitigate the typing issue in the windows release version.
+ Upd: Switched input property tab completion to PSFramework implementation: PSFramework-Input-ObjectProperty
+ Upd: Default keybinding for expanding aliases was changed to `Alt` + `q`. The previous one was inoperable under PSReadline 2.0 or later.
+ Fix: Get-PSUPathAlias returns empty objects (thanks Corbob)

## Version 2.0.4 (2018-12-23)

+ Fix: Persisting default aliases redirection fails

## Version 2.0.3 (2018-12-23)

+ New: Configuration setting 'PSUtil.Import.Alias.SystemOverride'. Persisting this will have PSUtil replace system default aliases.
+ New: Tab Expansion for PowerShellGet
+ New: Tab Expansion for Select-Object and Select-PSFObject

## Version 2.0.0 (2018-12-15)

+ new: Command Get-PSUPathAlias lists all current path aliases
+ new: Command Remove-PSUPathAlias removes a path alias
+ new: Command Set-PSUPath used to implement the path alias functionality
+ new: Command Set-PSUPathAlias creates or updates an alias for a path
+ other: Major project refactoring
+ rem: Command `Select-PSUObject` has been removed
+ new: Alias `Select-PSUObject` pointing at `Select-PSFPobject`
+ upd: Alias `ex` now points at `Export-PSFClixml`
+ upd: Alias `ix` now points at `Import-PSFClixml`
+ upd: Alias `spo` now points at `Select-PSFObject`
+ upd: Moved the list of default properties to expand using Expand-PSUObject to configuration

## Version 1.1.5.17 (2018-06-19)

+ new: Command Select-PSUObject - Select-Object in awesome.
+ upd: Command Set-PSUString / replace - can now do lambda replacement

## Version 1.1.4.15 (2018-03-30)

+ new: Select-PSUFunctionCode / Inspect

## Version 1.1.3.13 (2018-03-20)

+ new: Command Start-PSUTimer / timer

## Version 1.1.2.12 (2018-03-06)

+ new: Command Backup-PSULocation / bu (#18)
+ new: Command Set-PSUDrive / set-as (#18)
+ new: Command New-PSUDirectory / mcd (#18)

## Version 1.1.1.10 (2018-02-23)

+ upd: Select-PSUObjectSample / s can now select last items (#15)
+ fix: Format-PSUString / format will now format numbers correctly (#14)

## Version 1.1.1.9 (2018-02-02)

+ new: Command Convert-PSUObject / convert. (#9)
  Allows converting input from a source format to a destination format. Can be dynamically extended.
+ new: Command Register-PSUObjectConversion. (#9)
  Registers conversion path for Convert-PSUObject.
+ new: Added module tests and build definition for CI/CD integration
+ upd: All keybindings can now be configured using the config system. Changes require reimport to apply. (#7)
+ fix: Fixed 'replace' not accepting empty string as replace with option (#8)