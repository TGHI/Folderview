var fldrview = function () {

	var parentFolders = $('#masterList .toggle'),
		modalObj = document.getElementById('modalFrame'),
		modalBody = document.getElementById('modalBody');

	return {

		init: function () {
			
						

			this.modalObj();
			this.buildTree();
			this.toolbar();
		},

		buildTree: function () {

			this.button = parentFolders.each(function () {
				this.subfolder = $(this).siblings('ul:first');
				this.parentfolder = this.subfolder.parent().find('ul:first');
				this.parentPath = this.parentfolder.parent().attr('data-type-path');
				this.icon = this.subfolder.parent().find('.icon-folder-close:first');
			})

			this.button.click(function () {
				fldrview.treeNav(this.subfolder, this.parentPath, this.icon);
			})
		},

		treeNav: function (subfolder, folderpath, icon) {

			subfolder.stop(!0, !0).animate({
				'opacity': 'toggle',
				'height': 'toggle'
			}, 350).toggleClass('open');

			icon.toggleClass('icon-folder-open');

			this.setPath(folderpath);
		},

		setPath: function (pathName) {

			var formattedFolders = pathName.substr(0, pathName.lastIndexOf('\\') + 1);
			var formattedCurrentDirectory = pathName.substr(pathName.lastIndexOf('\\') + 1, pathName.length);
			$('#dirOutput').html(formattedFolders).append("<span>" + formattedCurrentDirectory + "</span>");
			$('#dirOutput span').animate({'opacity': '1','margin-top': '0px'})
		},

		modalObj: function () {

			$(".modal-launch").each(function (e) {

				var file = fldrview.fileAttributes($(this));

				if (file.mimetype) {
					$(this).click(function (a) {
						a.preventDefault();
						a.stopPropagation();
						$(modalObj).modal('toggle');
						$(modalObj).find('.modal-header h3').html(file.name + ' <small>(' + file.size + ')</small>');

						if (file.type == "text") {
							$(modalBody).load(file.path, function () {
								hljs.highlightBlock(modalBody);
								fldrview.createClipButton();
							})
						}

						if (file.type == "image") {
							modalBody.innerHTML = '<img src="' + file.path + '" alt="" />';
						}
					})
				}
			})
		},

		createClipButton: function () {

			var button = $('<a class="btn btn-success" id="clipboard_button" aria-hidden="true" data-clipboard-target="modalBody"><i class="icon-pencil icon-white"></i> ' + copyToClipboard + '</a>');

			$(modalObj).find('.modal-footer').append(button);

			var clip = new ZeroClipboard(button, {
				moviePath: "folderview/swf/ZeroClipboard.swf",
				hoverClass: "btn-success-hover",
				activeClass: "active"
			})
				.on('complete', function (client, args) {
					$('#clipboard_button').html('<i class="icon-ok-sign icon-white"></i> ' + textCopiedToClipboard);
				});

			$(modalObj).on('hidden', function () {
				$(this).removeData('modal');
				button.remove();
			})
		},

		fileAttributes: function (file) {

			file.path = file.attr('data-remote');
			file.size = file.attr('data-file-size');
			file.mimetype = file.attr('data-mime-type');
			file.type = file.mimetype.substr(0, file.mimetype.indexOf('/'));
			file.name = file.text();

			return file
		},

		toolbar : function(){

			$('#closeAll').on('click', function () {
				parentFolders.parent().find('ul:first').css('display', 'none').removeClass('open');
				$('.icon-folder-close').removeClass('icon-folder-open');
			})

			$('#openAll').on('click', function () {
				parentFolders.parent().find('ul:first').css('display', 'block').addClass('open');
				$('.icon-folder-close').addClass('icon-folder-open');
			})
		}
	}
}()

fldrview.init()