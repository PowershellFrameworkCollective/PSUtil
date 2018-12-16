# PSUtil

The PSUtil module is designed to make the user's console life more convenient. It includes shortcuts, aliases, keybindings and convenience functions geared towards greater efficiency and less typing.

This is done by providing ...

 - ... short aliases for common tasks
 - ... functions that simplify pipeline usage
 - ... functions that mimic operators, but can be used on the pipeline
 - ... functions that hasten path navigation
 - ... keybindings that shorten some more frequent tasks
 
 ## Installation
 
 You can install the module straight from the PowerShell gallery:
 ```powershell
 Install-Module PSUtil
 ```
 
 ## Examples
 ### grep (Select-String)
 
 This module adds an alias named `grep` that points to `Select-String`:
 ```powershell
 PS C:\> dir | grep
 ```
 
 ### exp (Expand-PSUObject)
 
 Ever used `Select -Expand`? Well, me too, but it's unwieldy to type every time, so I added a function for it:
 ```powershell
 PS C:\> dir | exp FullName
 ```
 Still too long to type ...
 ```powershell
 PS C:\> dir | exp
 ```
 And sometimes some special content is of interest:
 ```powershell
 PS C:\> "abc def ghi" | grep "(d\w+)" | exp
 def
 ```
 
 ### desktop (Invoke-PSUDesktop)
 
 Sometimes it'd be convenient to be able to jump straight to a desktop
```powershell
PS C:\> desktop
PS C:\> desktop someotheruser
```

### explorer (Invoke-PSUExplorer)

Ever wanted to open some folder straight from the console? Or the current folder? Or take a peek at a module?
```powershell
explorer
dir | explorer
gmo PSUtil | explorer
```
 
 ## Alias Warning
 
 This module is chock-full with aliases. They are plentiful, as aliases are a major factor to convenience, and this module is all about convenience.
 Aliases will not overwrite existing aliases.
 Individual aliases can be disabled using the configuration system.
 
 ## Design Warning
 
 This module is designed to help me with my workflows.
 If somebody else finds it helpful: Good. I share it because I hope it might be useful to others.
 That said, all changes here reflect how I use the console.
 If something bugs you about it, feel free to raise an issue and discuss it.
 If I can accomodate it without compromising my own use-case, I may well do so, but there's no guarantee of it.
 
 ## Configuration Notice

This module uses the PSFramework for configuration management (and many other things).
Run `Get-PSFConfig -Module PSUtil` in order to retrieve the full list of configurations set.

## Profile & Autoimport

PowerShell automatically imports any module the function of which you try to run.
However, keybindings are not known before the module is imported.
If you want to make sure that the module is always available in full, add it to your profile:
```powershell
notepad $profile
```

## Links

 - [2017-12-17 : Released: 1.1.0.4 - String operators and keybindings](https://allthingspowershell.blogspot.com/2017/12/keybdindings-and-string-manipulation.html)
 - [2017-09-26 : Released: 1.0.0.0 - Introduction to convenience](https://allthingspowershell.blogspot.com/2017/09/releasing-new-module-enter-psutil.html)
