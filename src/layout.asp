<%
'
' @package     folderview
' @copyright   Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)
' @license     GNU General Public License version 3 or later
'
%>
<!DOCTYPE html>
<html lang="en-gb">
<head>
<title><% response.write(PROGRAM_NAME) %></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="folderview/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="folderview/css/bootstrap-responsive.min.css" type="text/css" />
<link rel="stylesheet" href="folderview/css/highlight.css" type="text/css" />
<link rel="stylesheet" href="folderview/css/style.css" type="text/css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="folderview/js/highlight.min.js"></script>
<script type="text/javascript" src="folderview/js/bootstrap.min.js"></script>
<script type="text/javascript" src="folderview/js/zeroclipboard.min.js"></script>
<script type="text/javascript">

	// translatable strings in js

	var copyToClipboard = "<% response.write(COPY_TO_CLIPBOARD) %>",
		textCopiedToClipboard = "<% response.write(TEXT_COPIED_TO_CLIPBOARD) %>"

</script>
</head>
<body>
<div class="navbar-wrapper">
  <div id="navbar" class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="brand"><img src="folderview/img/brand.png" alt=""/></div>
      <ul class="nav">
        <li class="divider-vertical"></li>
        <li><a id="dirOutput" href="#"><% response.write(strWorkingDir) %></a></li>
      </ul>
    </div>
  </div>
</div>
<div class="container-fluid">
  <div class="row-fluid">
    <div class="span12">
      <div class="navbar" id="toolbar">
        <div class="navbar-inner">
          <div class="pull-left btn-group">
            <button class="btn btn-small" id="openAll"><i class="icon-folder-open"></i> <% response.write(EXPAND_ALL) %></button>
            <button class="btn btn-small" id="closeAll"><i class="icon-folder-close"></i> <% response.write(COLLAPSE_ALL) %></button>
          </div>
          <ul class="nav">
            <li class="divider-vertical"></li>
          </ul>
        </div>
      </div>
      <ul class="folder-tree" id="masterList">
        <% ListFolderContents(Server.MapPath(FOLDERVIEW_PATH)) %>
      </ul>
    </div>
  </div>
</div>
<div id="modalFrame" class="modal hide fade">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3></h3>
  </div>
  <pre><code class="modal-body" id="modalBody"></code></pre>
  <div class="modal-footer"></div>
</div>
<div class="bottom-shadow"></div>
<div class="fldrview-copyright">
  <a class="modal-launch" data-mime-type="text/txt" data-file-size="woo, fldrvw!" data-target="#modalFrame" href="#" data-remote="folderview/changelog.txt"><% response.write(PROGRAM_NAME) %> &middot; <% response.write(PROGRAM_VERSION) %></a>
</div>
<script type="text/javascript" src="folderview/js/main.js"></script>
</body>
</html>