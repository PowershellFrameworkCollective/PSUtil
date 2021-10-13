function Write-PSUKnowledge
{
<#
	.SYNOPSIS
		Writes a piece of knowledge into the designated book.
	
	.DESCRIPTION
		Writes a piece of knowledge into the designated book.
		This can be later retrieved using Read-PSUKnowledge.
		
		"Books" are an arbitrary label grouping one or multiple pieces of text ("pages").
		You could separate them by category (e.g. "Active Directory" or "Exchagne Online") or by computer (e.g. "Desktop", "Notebook", ...).
	
	.PARAMETER Name
		The name of the page to write.
	
	.PARAMETER Text
		The page / text to write.
	
	.PARAMETER Tags
		Additional tags to include.
		Tags help find content later on.
	
	.PARAMETER Book
		The book to write the content to.
		Defaults to the book specified under the 'PSUtil.Knowledge.DefaultBook' configuration setting.
		It will look for books in your library path, which can be specified under 'PSUtil.Knowledge.LibraryPath'.
	
	.PARAMETER EnableException
		This parameters disables user-friendly warnings and enables the throwing of exceptions.
		This is less user friendly, but allows catching exceptions in calling scripts.
	
	.EXAMPLE
		PS C:\> Set-PSUKnowledge -Name 'DNS Queries' -Text $nslookupExplained -Tags dns, network, infrastructure
	
		Defines a new page named "DNS Queries" with the text contained in $nslookupExplained.
		It also adds a few tags to make searching for it later easier.
#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[string]
		$Name,
		
		[parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('Page')]
		[string]
		$Text,
		
		[parameter(ValueFromPipelineByPropertyName = $true)]
		[string[]]
		$Tags,
		
		[parameter(ValueFromPipelineByPropertyName = $true)]
		[string]
		$Book = (Get-PSFConfigValue -FullName 'PSUtil.Knowledge.DefaultBook'),
		
		[switch]
		$EnableException
	)
	
	begin
	{
		$libraryPath = Get-PSFConfigValue -FullName 'PSUtil.Knowledge.LibraryPath'
		if (-not (Test-Path -Path $libraryPath))
		{
			try { $null = New-Item -Path $libraryPath -ItemType Directory -Force -ErrorAction Stop }
			catch
			{
				Stop-PSFFunction -String 'Set-PSUKnowledge.Library.Path.CreationFailed' -StringValues $libraryPath -ErrorRecord $_ -EnableException $EnableException
				return
			}
		}
	}
	process
	{
		if (Test-PSFFunctionInterrupt) { return }
		
		# Fake loop to make interrupting easier in pipeline scenarios
		foreach ($nameItem in $Name)
		{
			$bookName = '{0}.json' -f [System.Convert]::ToBase64String(([System.Text.Encoding]::UTF8.GetBytes($Book)))
			$bookPath = Join-Path $libraryPath $bookName
			$bookData = @{ }
			
			if (Test-Path -Path $bookPath)
			{
				try { $pages = Get-Content -Path $bookPath -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop }
				catch { Stop-PSFFunction -String 'Set-PSUKnowledge.Book.ImportFailed' -StringValues $Book, $bookPath -ErrorRecord $_ -EnableException $EnableException -Continue }
				
				foreach ($page in $pages)
				{
					$bookdata[$page.Name] = $page
				}
			}
			
			$bookData[$Name] = [pscustomobject]@{
				Name = $Name
				Text = $Text
				Tags = $Tags
			}
			
			try { $bookData.Values | ConvertTo-Json -ErrorAction Stop | Set-Content -Path $bookPath -ErrorAction Stop }
			catch { Stop-PSFFunction -String 'Set-PSUKnowledge.Book.ExportFailed' -StringValues $Name, $Book, $bookPath -ErrorRecord $_ -EnableException $EnableException -Continue }
		}
	}
}
Import-PSUAlias -Name 'teach' -Command Write-PSUKnowledge