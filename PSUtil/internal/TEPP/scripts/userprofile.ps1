$scriptblock = { Get-ChildItem "$env:SystemDrive\Users" -Force | Where-Object PSIsContainer | Expand-PSUObject Name }
Register-PSFTeppScriptblock -ScriptBlock $scriptBlock -Name psutil-userprofile