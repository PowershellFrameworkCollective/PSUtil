Register-PSFTeppScriptblock -Name 'PSUtil.Knowledge.Book' -ScriptBlock {
	$libraryPath = Get-PSFConfigValue -FullName 'PSUtil.Knowledge.LibraryPath'
	if (-not (Test-Path $libraryPath)) { return }
	
	Get-ChildItem -Path $libraryPath -Filter *.json | ForEach-Object {
		[System.Text.Encoding]::UTF8.GetString(([convert]::FromBase64String($_.BaseName)))
	} | Sort-Object
}

Register-PSFTeppScriptblock -Name 'PSUtil.Knowledge.Page' -ScriptBlock {
	$book = '*'
	if ($fakeBoundParameter.Book) { $book = $fakeBoundParameter.Book }
	(Read-PSUKnowledge -Book $book).Name | Select-PSFObject -Unique | Sort-Object
}

Register-PSFTeppScriptblock -Name 'PSUtil.Knowledge.Tags' -ScriptBlock {
	$book = '*'
	if ($fakeBoundParameter.Book) { $book = $fakeBoundParameter.Book }
	(Read-PSUKnowledge -Book $book).Tags | Select-PSFObject -Unique | Sort-Object
}