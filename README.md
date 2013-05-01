Folderview - The ASP-generated foldertree
--------------

**Current Version: 0.65**

How-to
--------------
Folderview recursively scans a given folder(s) and creates a navigable folder tree.

Pick your directory in **default.asp**

```
  ListFolderContents(Server.MapPath("your/directory/here"))
```

Currently, Foldertree is setup to open certain files in a modal window for viewing instead of simply opening them as a hyperlink

This is found in **src/folders.asp**

```
  allowedTextExtensions = array("txt","js","css","xml")
  allowedImageExtensions = array("jpg","png","gif")
```
Disclaimer
--------------
I'm not an ASP/IIS guy.  There are some strange (but innocuous) bugs with some file extensions.  I'm not sure why at this time.

Jargon
--------------

This package includes:

Twitter Bootstrap (http://twitter.github.io/bootstrap/)

Zero Clipboard (http://jonrohan.github.io/ZeroClipboard/)

highlight.js (http://softwaremaniacs.org/soft/highlight/)

All other portions Copyright (C) 2013 Justin Renaud (tghidsgn@gmail.com)

Folderview is licensed under the GNU General Public License version 3; see LICENCE.txt
