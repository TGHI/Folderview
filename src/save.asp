<%@Language="VBScript"%>
<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'
%>
<%Option Explicit%>
<%Response.Buffer = True%>
<%
On Error Resume Next
Dim strPath
strPath = CStr(Request.QueryString("file"))

If InStr(strPath, "..") > 0 Then
    Response.Clear
    Response.End
ElseIf Len(strPath) > 1024 Then
    Response.Clear
    Response.End
Else
    Call DownloadFile(strPath)
End If
 
Private Sub DownloadFile(file)

	Dim strAbsFile, strFileExtension, objFSO, objFile, objStream

    strAbsFile = Server.MapPath(file)

    Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

    If objFSO.FileExists(strAbsFile) Then
        Set objFile = objFSO.GetFile(strAbsFile)

        Response.Clear

        Response.AddHeader "Content-Disposition", "attachment; filename=" & chr(34) & objFile.Name & chr(34)
        Response.AddHeader "Content-Length", objFile.Size
        Response.ContentType = "application/octet-stream"
        Set objStream = Server.CreateObject("ADODB.Stream")
        objStream.Open

        objStream.Type = 1
        Response.CharSet = "UTF-8"

        objStream.LoadFromFile(strAbsFile)

        Response.BinaryWrite(objStream.Read)
        objStream.Close
        Set objStream = Nothing
        Set objFile = Nothing
    End If
    Set objFSO = Nothing
End Sub
%>