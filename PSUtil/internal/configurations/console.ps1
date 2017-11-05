# Configure the current window width
Set-PSFConfig -Module PSUtil -Name 'Console.Width' -Value ($Host.UI.RawUI.WindowSize.Width) -Initialize -Validation "PSUConsoleWidth" -Handler { Set-PSUShell -WindowWidth $args[0] } -Description "The width of the current console"

# Buffer Length
Set-PSFConfig -Module PSUtil -Name 'Console.Buffer' -Value ($Host.UI.RawUI.BufferSize.Height) -Initialize -Validation "integerpositive" -Handler { Set-PSUShell -BufferLength $args[0] } -Description "The length of the console screen history"

# Foreground Color
Set-PSFConfig -Module PSUtil -Name 'Console.ForegroundColor' -Value ($Host.ui.rawui.ForegroundColor) -Initialize -Validation "consolecolor" -Handler { Set-PSUShell -ForegroundColor $args[0] } -Description "The foreground color used in the PowerShell console"

# Background Color
Set-PSFConfig -Module PSUtil -Name 'Console.BackgroundColor' -Value ($Host.ui.rawui.BackgroundColor) -Initialize -Validation "consolecolor" -Handler { Set-PSUShell -BackgroundColor $args[0] } -Description "The background color used in the PowerShell console"

# Window Title
Set-PSFConfig -Module PSUtil -Name 'Console.WindowTitle' -Value ($Host.ui.rawui.Windowtitle) -Initialize -Validation "string" -Handler { Set-PSUShell -WindowTitle $args[0] } -Description "The background color used in the PowerShell console"