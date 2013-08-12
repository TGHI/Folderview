<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'
Option Explicit

CONST PROGRAM_NAME = "fldrview"
CONST PROGRAM_VERSION = "0.7.1"

CONST FOLDERVIEW_PATH = "projects"

Dim arrTextExtensions : arrTextExtensions = array("txt","js","css","xml","bat","ini")
Dim arrImageExtensions : arrImageExtensions = array("jpg","jpeg","png","gif")
Dim arrDisallowedExtensions : arrDisallowedExtensions = array("db")

%>
<!--#include file="lang/en-CA/en-CA.asp"-->
<!--#include file="src/folders.asp"-->
<!--#include file="src/layout.asp"-->