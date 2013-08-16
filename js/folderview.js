var fldrview = function () {

	var modalObj = document.getElementById('modalFrame'),
		modalBody = document.getElementById('modalBody'),
		folderNames = new Array();

	return {

		init: function () {

			this.buildTree();
			this.toolbar();
		},

		buildTree: function () {

			var folderObjects = $('#masterList .btn.toggle'),
				fileObjects = $(".modal-launch");

			this.folders = folderObjects.each(function () {
				this.subfolder = $(this).siblings('ul:first');
				this.parentFolder = this.subfolder.parent().find('ul:first');
				this.parentPath = this.parentFolder.parent().attr('data-type-path');
				this.icon = this.subfolder.parent().find('.icon-folder-close:first');
				folderNames.push($(this).attr('data-folder-name'));
			}).click(function () {
				fldrview.traverse(this);
			})

			this.files = fileObjects.each(function () {
				this.path = $(this).attr('data-remote');
				this.size = $(this).attr('data-file-size');
				this.mimetype = $(this).attr('data-mime-type');
				if (this.mimetype) this.type = this.mimetype.substr(0, this.mimetype.indexOf('/'));
				this.name = $(this).text();
			}).click(function (e) {
				fldrview.launch(this, e);
			})
		},

		jumpto: function (folder, searchObj) {

			var found = this.folders.siblings().find('span:contains(' + folder + ')');

			if (found.length > 0) {

				found.addClass('highlight');
				found.icon = found.siblings().children().parents().siblings().find('> .icon-folder-close');
				found.subfolder = found.siblings('.sub-folder');
				found.path = null;

				found.parents('#masterList li ul').stop(!0, !0).addClass('open').slideDown();
				found.subfolder.stop(!0, !0).addClass('open').slideDown();
				found.icon.addClass('icon-folder-open');
			}
		},

		traverse: function (branch) {

			branch.subfolder.stop(!0, !0).animate({
				'opacity': 'toggle',
				'height': 'toggle'
			}, 350).toggleClass('open');
			
			branch.icon.toggleClass('icon-folder-open');

			this.setPath(branch.parentPath);
			this.setHash(branch.parentPath)
			
		},
		
		setHash: function (path) {
			window.location.hash = path;
		},

		setPath: function (path) {

			var formattedFolders = path.substr(0, path.lastIndexOf('\\') + 1);
			var formattedCurrentDirectory = path.substr(path.lastIndexOf('\\') + 1, path.length);
			$('#dirOutput').html(formattedFolders).append("<span>" + formattedCurrentDirectory + "</span>");
			$('#dirOutput span').animate({
				'opacity': '1',
				'margin-top': '0px'
			})
		},

		launch: function (file, action) {

			if (file.mimetype) {
				action.preventDefault();
				action.stopPropagation();
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
			}
		},

		createClipButton: function () {

			var button = $('<a class="btn btn-success" id="clipboard_button" aria-hidden="true" data-clipboard-target="modalBody"><i class="icon-pencil icon-white"></i> ' + copyToClipboard + '</a>');

			$(modalObj).find('.modal-footer').append(button);

			var clip = new ZeroClipboard(button, {
				moviePath: "swf/ZeroClipboard.swf",
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

		toolbar: function () {

			$('#closeAll').on('click', function () {
				fldrview.folders.parent().find('ul:first').css('display', 'none').removeClass('open');
				$('.icon-folder-close').removeClass('icon-folder-open');
			})

			$('#openAll').on('click', function () {
				fldrview.folders.parent().find('ul:first').css('display', 'block').addClass('open');
				$('.icon-folder-close').addClass('icon-folder-open');
			})
			$('#clearFound').click(function () {
				$('*').removeClass('highlight');
			})

			$('#searchField').typeahead({
				source: folderNames,
				items: 6,
				minLength: 3
			})

			$("#folderSearch").submit(function (e) {

				e.preventDefault();
				e.stopPropagation();

				var searchObj = $("input:first"),
					searchValue = searchObj.val();

				if (searchValue.length < 3) {
					searchObj.tooltip('show')
				} else {
					fldrview.jumpto(searchValue)
					searchObj.tooltip('hide');
				}
			})
		}
	}
}()

fldrview.init()