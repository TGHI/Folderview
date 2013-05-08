$(document).ready(function () {

  var modalObj = document.getElementById('modalFrame'),
    modalBody = document.getElementById('modalBody'),
    folderToggle = $('.toggle');

  $(".modal-launch").each(function (e) {

    var filePath = $(this).attr('data-remote'),
      fileSize = $(this).attr('data-file-size'),
      fileMimetype = $(this).attr('data-mime-type'),
      fileType = fileMimetype.substr(0, fileMimetype.indexOf('/')),
      fileExtension = fileMimetype.substr(fileMimetype.indexOf('/') + 1, fileMimetype.length),
      fileName = filePath.substr(filePath.lastIndexOf('/') + 1, filePath.length);


    if (fileMimetype !== "") {
      $(this).click(function (a) {
        a.preventDefault();
        a.stopPropagation();
        $(modalObj).modal('toggle');
        $(modalObj).find('.modal-header h3').html(fileName + ' <small>(' + fileSize + ')</small>');
        $(modalObj).find('.modal-footer .raw-view').attr('href', filePath);

        if (fileType == "text") {
          $(modalBody).load(filePath, function () {
            hljs.highlightBlock(modalBody);
            createClipButton('#clip_button');
          })
        }
        if (fileType == "image") {
          $(modalBody).html('<img src="' + filePath + '" alt="" />')
        }
      })
    }
  })

  $(modalObj).on('hidden', function () {
    $(this).removeData('modal');
    $('#clip_button').remove();
  })

  folderToggle.each(function (i, el) {
    $(el).click(function () {
      folderNav($(el));
    })
  })

  $('#openAll').on('click', function () {
    folderNav(folderToggle, "expand")
  })
  $('#closeAll').on('click', function () {
    folderNav(folderToggle, "collapse")
  })

})

function createClipButton(id) {

  $('.modal-footer').append('<a class="btn btn-success" aria-hidden="true" id="clip_button" data-clipboard-target="modalBody"><i class="icon-pencil icon-white"></i>Copy to Clipboard</a>');

  var clip = new ZeroClipboard($(id), {
    moviePath: "folderview/swf/ZeroClipboard.swf",
    hoverClass: "btn-success-hover",
    activeClass: "active"
  })
    .on('complete', function (client, args) {
    $(id).html('<i class="icon-ok-sign icon-white"></i> Text Copied');
  });
}

function folderNav(nav, intent, derp) {

  var subFolder = nav.parent().find('ul:first'),
    icon = nav.parent().find('.icon-plus:first');

  if (!intent) {
    nav.siblings('ul:first').stop(!0, !0).animate({
      'opacity': 'toggle',
      'height': 'toggle'
    }, 350).toggleClass('open');
    icon.toggleClass('icon-minus');
    setPath(subFolder.parent().attr('data-type-path'));
  
  }else{

    if (intent == "collapse") {
      subFolder.css('display', 'none').removeClass('open');
      icon.removeClass('icon-minus');
    }
    if (intent == "expand") {
      subFolder.css('display', 'block').addClass('open');
      icon.addClass('icon-minus');
    }
  }
}

function setPath(pathName) {
  var formattedFolders = pathName.substr(0, pathName.lastIndexOf('\\') + 1);
  var formattedCurrentDirectory = pathName.substr(pathName.lastIndexOf('\\') + 1, pathName.length);
  $('#dirOutput').html(formattedFolders).append("<span style=\"opacity:0;position:absolute;top:8px;width:auto;color:#55bad8;white-space:nowrap\">" + formattedCurrentDirectory + "</span>");
  $('#dirOutput span').animate({'opacity':'1','top':'16px'})
}
