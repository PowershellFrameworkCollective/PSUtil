function Remove-PSUKnowledge
{
<#
	.SYNOPSIS
		Removes pages from the books of your holy console library of knowledge.
	
	.DESCRIPTION
		Removes pages from the books of your holy console library of knowledge.
		Contribute new knowledge by using Write-PSUKnowledge or search it by using Read-PSUKnowlege.
	
	.PARAMETER Name
		The name of the page to rip out.
	
	.PARAMETER Book
		The book of knowledge to deface.
		Defaults to the book specified under the 'PSUtil.Knowledge.DefaultBook' configuration setting.
		It will look for books in your library path, which can be specified under 'PSUtil.Knowledge.LibraryPath'.
	
	.EXAMPLE
		PS C:\> Remove-PSUKnowledge -Name 'DNS for Dummies'
	
		Rips out the page 'DNS for Dummies' from your default book.
#>
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[Alias('page')]
		[string[]]
		$Name,
		
		[Parameter(ValueFromPipelineByPropertyName = $true)]
		[string]
		$Book = (Get-PSFConfigValue -FullName 'PSUtil.Knowledge.DefaultBook')
	)
	
	begin
	{
		$libraryPath = Get-PSFConfigValue -FullName 'PSUtil.Knowledge.LibraryPath'
	}
	process
	{
		if (-not (Test-Path -Path $libraryPath)) { return }
		
		$bookName = '{0}.json' -f [System.Text.Encoding]::UTF8.GetBytes($Book)
		$bookPath = Join-Path $libraryPath $bookName
		
		if (-not (Test-Path -Path $bookPath)) { return }
		
		$pageEntries = Get-Content -Path $bookPath | ConvertFrom-Json
		$pageEntries = $pageEntries | Where-Object Name -notin $Name
		$pageEntries | ConvertTo-Json | Set-Content -Path $bookPath
	}
}