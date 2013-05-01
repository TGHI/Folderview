<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'
sub ListFolderContents(path)

  dim fs, folder, file, item, url, fileCount, subfolderCount, extension, fileSize, mimetype
  
  allowedTextExtensions = array("txt","js","css","xml")
  allowedImageExtensions = array("jpg","png","gif")

  set fs = CreateObject("Scripting.FileSystemObject")
  set folder = fs.GetFolder(path)

  fileCount = folder.Files.Count
  subfolderCount = folder.SubFolders.Count
  formattedPath = Mid(folder, InStr(folder, "\Justin"), len(folder))

  if subfolderCount = 0 and fileCount = 0 then
    toggle = " disabled"
  else
   toggle = " toggle"
  end if

  Response.Write("<li class=""root-folder"" data-type-path=""" & formattedPath &""">" & vbCrLf)
  Response.Write("  <span class=""btn btn-info btn-mini" & toggle & """><i class=""icon-plus icon-white""></i></span><span class=""folder-name" & toggle & """><a href=""#"">" & folder.Name & "</a></span>")

  if subfolderCount = 0 and fileCount = 0 then
    Response.Write("<span class=""label label-warning"">Empty</span>")
	toggle = ""
  else
  
    dim subfolderLabel, fileLabel, plural
    subfolderLabel = "subfolder"
    fileLabel = "file"
    plural = "s"
	
    if subfolderCount <> 0 then
    if subfolderCount > 1 then subfolderLabel = subfolderLabel & plural
	
      Response.Write("<span class=""label"">" & subfolderCount & " " & subfolderLabel & "</span>")
	  
    end if
  
    if fileCount <> 0 then
    if fileCount > 1 then fileLabel = fileLabel & plural
	
      Response.Write("<span class=""label label-inverse"">" & fileCount & " " & fileLabel & "</span>")
	  
    end if
	
  end if

  Response.Write(vbCrLf & "  <ul class=""sub-folder"">" & vbCrLf)

  for each item in folder.SubFolders
    ListFolderContents(item.Path)
  next

  for each item in folder.Files
   
    url = MapURL(item.path)
	extensionName = Mid(item.name,InStrRev(item.name, ".") + 1, len(item.name))
	
	For each x in allowedTextExtensions
	  if x = extensionName then
	    mimetype = "text/" & extensionName
		found = "true"
		exit for
	  end if
	next
	
	if found <> "true" then
	  For each y in allowedImageExtensions
	    if y = extensionName then
	      mimetype = "image/" & extensionName
		  exit for
	    end if
	  next
    end if
	
	if item.Size < 1024 then
	  fileSize = item.Size & " bytes"
	elseif item.Size > 1024 then
	  fileSize = round(item.Size / 1024, 2) & "KB"
	elseif item.size > 1048576 then
	  fileSize =round(item.Size / 1048576, 2) & "MB"
	end if

    Response.Write("  <li><a role=""button"" data-remote="""& url &""" class=""btn modal-launch"" data-target=""#modalFrame"" data-mime-type="""& mimetype &""" data-file-size="""& fileSize &""" href="""& url &""">" & item.Name & "</a>")
	Response.Write("<span class=""file-info muted""> - " & fileSize & ", " & "Last modified " & item.DateLastModified & ".</span>" & "</li>" & vbCrLf)
  next

  Response.Write("  </ul>" & vbCrLf)
  Response.Write("  </li>" & vbCrLf)

end sub

function MapURL(path)

  dim rootPath, url
  
  rootPath = Server.MapPath("/")
  url = Right(path, Len(path) - Len(rootPath))
  MapURL = Replace(url, "\", "/")

end function %>