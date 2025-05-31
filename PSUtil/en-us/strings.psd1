@{
	'Remove-PSUDirectory.Error.IsRootPath'         = 'This is the drive root, not deleting the entire volume for you! {0}' # location
	'Remove-PSUDirectory.Error.NotFileSystem'      = 'Not a filesystem path, cannot remove the current location: {0}' # $location
	'Remove-PSUDirectory.RemoveItem'               = 'Removing {0} items in {1}' # $children.Count, $location
	'Set-PSUKnowledge.Library.Path.CreationFailed' = 'Failed to create library path: {0}. Validate the path and ensure the necessary permissions are in place.' # $libraryPath
	'Set-PSUKnowledge.Book.ImportFailed'           = 'Failed to read the book "{0}" from "{1}"' # $Book, $bookPath
	'Set-PSUKnowledge.Book.ExportFailed'           = 'Failed to write the page "{0}" into the book "{1}" at "{2}"' # $Name, $Book, $bookPath
}