<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'

Dim objFSO, strScriptPath, strWorkingDir

strScriptPath = Request.ServerVariables("PATH_TRANSLATED")
strWorkingDir = Mid(strScriptPath,1,InStrRev(strScriptPath, "\"))

Set objFSO = CreateObject("Scripting.FileSystemObject")

Sub ListFolderContents(path)

	Dim objFolder, objFile, objSubFolder, strFileCount, strSubFolderCount, strToggle

	Set objFolder = objFSO.GetFolder(path)

	strFileCount = objFolder.Files.Count
	strSubFolderCount = objFolder.SubFolders.Count
 
	If strSubFolderCount = 0 And strFileCount = 0 Then
		strToggle = " empty-folder disabled"
	Else
		strToggle = " toggle"
	End If

	Response.Write("<li class=""root-folder"" data-type-path=""" & objFolder.path &""">" & vbCrLf)
	Response.Write("  <span class=""btn btn-info btn-mini" & strToggle & """ data-folder-name=""" & objFolder.Name & """><i class=""icon-folder-close icon-white""></i></span><span class=""folder-name" & strToggle & """><a href=""#"">" & objFolder.Name & "</a></span>")

	If strSubFolderCount = 0 And strFileCount = 0 Then
		Response.Write("<span class=""label label-warning"">" & LABEL_EMPTY & "</span>")
		strToggle = ""

	Else

		Dim strSubFolderLabel, strFileLabel, strPlural
		
		strSubFolderLabel = LABEL_SUBFOLDER
		strFileLabel = LABEL_FILE
		strPlural = LABEL_PLURAL
	
		If strSubFolderCount <> 0 Then
			If strSubFolderCount > 1 Then strSubFolderLabel = strSubFolderLabel & strPlural
			Response.Write("<span class=""label"">" & strSubFolderCount & " " & strSubFolderLabel & "</span>")
		End If

   		If strFileCount <> 0 Then
   			If strFileCount > 1 Then strFileLabel = strFileLabel & strPlural
				Response.Write("<span class=""label label-inverse"">" & strFileCount & " " & strFileLabel & "</span>")
			End If
		End If

		Response.Write(vbCrLf & "  <ul class=""sub-folder"">" & vbCrLf)

		
		For Each objSubFolder In objFolder.SubFolders
			ListFolderContents(objSubFolder.Path)
		Next
  
		For Each objFile In objFolder.Files
			ListFiles(objFile)
		Next

		Response.Write("  </ul>" & vbCrLf)
		Response.Write("  </li>" & vbCrLf)

End Sub

Sub ListFiles(objFile)

  Dim strExtension, boolFound, strDisallowedExtension

  boolFound = true

  For Each strDisallowedExtension In arrDisallowedExtensions
    If getExtension(objFile.Name) = strDisallowedExtension Then
       boolFound = false
	  Exit For
    End If
  Next

  If boolFound = true Then
    Response.Write(createFileItem(objFile.Name, objFile.DateLastModified, safeURL(objFile.Path), prettyFileSize(objFile.Size)))	
  End If 
	
End Sub

' return extension name (without period)
Function getExtension(strFileName)

   getExtension = Mid(strFileName,InStrRev(strFileName, ".") + 1, len(strFileName))

End Function

' fixes slashes In path, replaces spaces with %20
Function safeURL(path)

	Dim strRootPath, strURL

	strRootPath = Server.MapPath("/")
	strURL = Right(path, Len(path) - Len(strRootPath))
	strURL = Replace(strURL," ", "%20")

	safeURL = Replace(strURL, "\", "/")

End Function 

' proper units for filesizes
Function prettyFileSize(bytes)

	If bytes < 1024 Then
		prettyFileSize = bytes & " " & SIZE_BYTES
	ElseIf bytes > 1024 Then
		prettyFileSize = round(bytes / 1024, 2) & " " &  SIZE_KILOBYTES
	ElseIf bytes > 1048576 Then
		prettyFileSize = round(bytes / 1048576, 2) & " " &  SIZE_MEGABYTES
	End If

End function

' determines mimetype, creates file button, dropdown and info
Function createFileItem(strFileName, strFileDateLastModified, strFileURL, strFileSize)

	Dim boolFound, strExtensionName, strFileMimeType, strMatchedExtension, strMatchedExtensionX

	strExtensionName = getExtension(strFileName)

	For Each strMatchedExtension In arrTextExtensions
		If strMatchedExtension = strExtensionName Then
			strFileMimeType = "text/" & strExtensionName
			boolFound = true
      		Exit For
    	End If
	Next
      
	If boolFound <> true Then
		For Each strMatchedExtensionX In arrImageExtensions
			If strMatchedExtensionX = strExtensionName Then
			strFileMimeType = "image/" & strExtensionName
			Exit For
		End If
		Next
	End If

	createFileItem = _
		"<li>" & vbCrLf &_
		"  <div class=""btn-group"">" & vbCrLf &_
		"    <a role=""button"" data-remote="""& strFileURL &""" class=""btn modal-launch"" data-target=""#modalFrame"" data-mime-type="""& strFileMimeType &""" data-file-size="""& strFileSize &""" href="""& strFileURL &"""><i class=""icon-file""></i> " & strFileName & "</a>" & vbCrLf  &_
		"    <button class=""btn dropdown-toggle"" data-toggle=""dropdown""><i class=""caret""></i></button>" & vbCrLf &_
		"    <ul class=""dropdown-menu"">" & vbCrLf &_
		"      <li class=""nav-header"">" & FILE_OPTIONS & "</li>" & vbCrLf &_
		"      <li><a href=""folderview/src/save.asp?file=" & strFileURL & """><i class=""icon-download""></i> " & DOWNLOAD_FILE &  "</a></li>" & vbCrLf &_
		"      <li><a href=""" & strFileURL & """ target=""_blank""><i class=""icon-share""></i> " & OPEN_IN_NEW_WINDOW & "</a></li>" & vbCrLf &_
		"    </ul>" & vbCrLf &_
		"  </div>" & vbCrLf &_
		"  <div class=""btn-group"">" & vbCrLf &_
		"    <span class=""btn disabled"">" & strFileSize & "</span><span class=""btn disabled"">" & strFileDateLastModified & "</span>" & vbCrLf &_
		"  </div>" & vbCrLf &_
		"</li>" & vbCrLf

End Function

%>