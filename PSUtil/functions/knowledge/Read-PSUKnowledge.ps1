function Read-PSUKnowledge
{
<#
	.SYNOPSIS
		Searches for knowledge.
	
	.DESCRIPTION
		Searches for knowledge.
		Generally, knowledge must first be generated using Write-PSUKnowledge.
		This allows these functions to server as a searchable notes section right within your console.
	
		However, there might be some other ways to seek knowledge ...
	
	.PARAMETER Name
		The name of the knowledge entry.
	
	.PARAMETER Tags
		Tags to search by. At least one of the specified tags must be contained.
	
	.PARAMETER Pattern
		Search Name and text of the page by using this regex pattern.
	
	.PARAMETER Book
		The book to search in.
		By default you only have one and don't need to worry about this.
	
	.PARAMETER Online
		Mysterious parameter. I wonder what it does ...
	
	.EXAMPLE
		PS C:\> Read-PSUKnowledge
	
		Lists all knowledge entries.
	
	.EXAMPLE
		PS C:\> Read-PSUKnowledge -Tags DNS
	
		Lists all knowledge entries with the tag "DNS"
	
	.EXAMPLE
		PS C:\> read -p ldap
	
		Lists all knowledge entries with the string "ldap" in name or text.
#>
	[CmdletBinding()]
	param (
		[parameter(Position = 0)]
		[Alias('Page')]
		[string]
		$Name = '*',
		
		[string[]]
		$Tags,
		
		[Alias('p','f','filter')]
		[string]
		$Pattern = '.',
		
		[string]
		$Book = '*',
		
		[switch]
		$Online
	)
	
	begin
	{
		$libraryPath = Get-PSFConfigValue -FullName 'PSUtil.Knowledge.LibraryPath'
	}
	process
	{
		# Gimmick: Search in wikipedia
		if ($Online)
		{
			$url = "https://en.wikipedia.org/wiki/Special:Search/$Name"
			Start-Process $url
			return
		}
		
		if (-not (Test-Path -Path $libraryPath)) { return }
		
		foreach ($bookFile in (Get-ChildItem -Path $libraryPath -Filter *.json))
		{
			$bookName = [System.Text.Encoding]::UTF8.GetString(([convert]::FromBase64String($bookFile.BaseName)))
			if ($bookName -notlike $Book) { continue }
			
			$data = Get-Content -Path $bookFile.FullName | ConvertFrom-Json
			
			foreach ($page in $data)
			{
				if ($page.Name -notlike $Name) { continue }
				if ($Tags -and -not ($Tags | Where-Object { $_ -in $page.Tags })) { continue }
				
				if ($Pattern -ne '.')
				{
					$matched = $false
					if ($page.Name -match $Pattern) { $matched = $true }
					elseif ($page.Text -match $Pattern) { $matched = $true }
					if (-not $matched) { continue }
				}
				
				$page | Select-PSFObject -KeepInputObject -TypeName 'PSUtil.Knowledge.Page'
			}
		}
	}
}
Import-PSUAlias -Name 'read' -Command Read-PSUKnowledge
Import-PSUAlias -Name 'rdk' -Command Read-PSUKnowledge
Import-PSUAlias -Name 'page' -Command Read-PSUKnowledge
Import-PSUAlias -Name 'learn' -Command Read-PSUKnowledge