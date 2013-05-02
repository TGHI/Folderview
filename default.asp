<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'
%>
<!--#include file="src/folders.asp"-->
<!DOCTYPE html>
<html lang="en-gb">
<head>
<title>folderview</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" type="text/css" />
<link rel="stylesheet" href="css/highlight.css" type="text/css" />
<link rel="stylesheet" href="css/style.css" type="text/css" />
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="js/highlight.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/zeroclipboard.min.js"></script>
<script src="js/main.js"></script>
</head>
<body>
<div class="navbar-wrapper">
  <div id="navbar" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="brand"><img src="img/brand.png" alt="Justin Renaud"/></div>
      <ul class="nav">
        <li class="divider-vertical"></li>
        <li><a id="dirOutput" href="#">\Justin</a></li>
      </ul>
      <div class="pull-right" style="padding:15px">Version 0.6.5</div>
    </div>
  </div>
</div>
<div class="container-fluid">
  <div class="row-fluid">
    <div class="span5">
      <div class="left-column">
        <div class="toolbar">
          <button class="btn" id="openAll"><i class="icon-folder-open"></i> Expand all</button>
          <button class="btn" id="closeAll"><i class="icon-folder-close"></i> Collapse all</button>
        </div>
        <ul class="folder-tree" id="masterList">
          <% ListFolderContents(Server.MapPath("projects")) %>
        </ul>
      </div>
    </div>
    <div class="span7" style="margin-top:70px"> </div>
  </div>
</div>
<div id="modalFrame" class="modal hide fade">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3></h3>
  </div>
  <pre><code class="modal-body" id="modalBody"></code></pre>
  <div class="modal-footer"> <a class="btn btn-info raw-view" aria-hidden="true"><i class="icon-file icon-white"></i>View Raw</a> </div>
</div>
<div class="bottom-shadow"></div>
</body>
</html>
