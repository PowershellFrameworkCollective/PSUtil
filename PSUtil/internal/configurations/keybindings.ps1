﻿Set-PSFConfig -Module 'PSUtil' -Name 'Keybinding.GetHelp' -Value "F1" -Initialize -Description "The key chord(s) the open help functionality is bound to. Will provide help for the currently typed command."
Set-PSFConfig -Module 'PSUtil' -Name 'Keybinding.ExpandAlias' -Value "Shift+Spacebar" -Initialize -Description "The key chord(s) the alias expansion functionality is bound to. Will expand all aliases in the current input."
Set-PSFConfig -Module 'PSUtil' -Name 'Keybinding.CopyAll' -Value "Ctrl+Shift+c" -Initialize -Description "The key chord(s) the copy all functionality is bound to. Will copy all lines of the current input to the clipboard."
Set-PSFConfig -Module 'PSUtil' -Name 'Keybinding.BrowseHistory' -Value "F7" -Initialize -Description "The key chord(s) the browse history functionality is bound to. Will open a gridview and allow you to pick from your input history, then insert the chosen line(s) as your current input."
Set-PSFConfig -Module 'PSUtil' -Name 'Keybinding.SendToHistory' -Value "Alt+w" -Initialize -Description "The key chord(s) the send to history functionality is bound to. Your current input will be sent to history without actually executing it. Access it by using the Arrow-UP key."