﻿Set-PSFConfig -Module PSUtil -Name 'Import.Aliases.Grep' -Value $true -Initialize -Validation "bool" -Handler { } -Description "Whether the module will on import create an alias named 'grep' for Select-String"