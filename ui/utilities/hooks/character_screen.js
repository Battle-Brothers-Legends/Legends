// add this variable
Screens.WorldCharacterScreen.mPopupDialog = null;

// add this
CharacterScreen.prototype.openUrl = function(_data)
{
	if (_data === undefined || _data === null || !jQuery.isArray(_data) || _data.length == 0)
		return;

	openURL(_data[0]);

	if (_data.length > 1 && _data[1] !== undefined && typeof _data[1] == "string")
		this.openPopupDialog(_data[1]);
};

CharacterScreen.prototype.openPopupDialog = function(_text)
{
	var self = this;

	this.mPopupDialog = $('.character-screen').createPopupDialog('Notice', null, null, 'notice-popup-dialog');
	this.mPopupDialog.addPopupDialogOkButton(function(_dialog) {
		self.mPopupDialog = null;
		_dialog.destroyPopupDialog();
	});

	// make the content
	var result = $('<div class="notice-popup-container"/>');
	var row = $('<div class="row"/>');
		row.appendTo(result);

	var label = $('<div class="text-font-normal font-color-label"></div>');
		label.appendTo(row);

	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});
									
	label.html(parsedText.html);
	// the end of the content

	this.mPopupDialog.addPopupDialogContent(result);
};
