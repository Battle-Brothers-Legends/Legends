/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			23.09.2017
 *  @Description:	World Screen: Day-Time Module JS
 */
"use strict";


var WorldScreenTopbarDayTimeModule = function(_dataSource)
{
	this.mSQHandle = null;
    this.mDataSource = _dataSource;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;

	// text & image containers
    this.mDayTimeText = null;
    this.mDayTimeImage = null;

	this.mPausedDiv = null;
	this.mPausedSpacebarDiv = null;

	this.mTimePauseButton = null;
	this.mTimeNormalButton = null;
	this.mTimeFastButton = null;
	this.mTimeVeryfastButton = null;
	this.mTimeLudicrousButton = null;

    this.registerDatasourceListener();
};


WorldScreenTopbarDayTimeModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

WorldScreenTopbarDayTimeModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

		// notify listener
		if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
			this.mEventListener.onModuleOnConnectionCalled(this);
		}
	}
};

WorldScreenTopbarDayTimeModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


WorldScreenTopbarDayTimeModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers
	this.mContainer = $('<div class="topbar-daytime-module ui-control"></div>');
    _parentDiv.append(this.mContainer);

	var textContainer = $('<div class="text-container"></div>');
	this.mContainer.append(textContainer);
	var imageContainer = $('<div class="image-container"></div>');
	this.mContainer.append(imageContainer);

    this.mDayTimeText = $('<div class="text title-font-small font-bold font-bottom-shadow font-color-title"></div>');
    textContainer.append(this.mDayTimeText);

    this.mDayTimeImage = $('<img/>');
    this.mDayTimeImage.attr('src', Path.GFX + Asset.IMAGE_DAY_TIME);
    imageContainer.append(this.mDayTimeImage);

    /*this.mDayTimeImage.on("click", function ()
    {
    	self.notifyBackendPauseButtonPressed();
    });*/

    var layout = $('<div class="l-pause-button"/>');
    this.mContainer.append(layout);
    this.mTimePauseButton = layout.createImageButton(Path.GFX + Legends.BUTTON_PAUSE_DISABLED, function ()
    {
    	self.notifyBackendTimePauseButtonPressed();

    	self.mTimePauseButton.changeButtonImage(Path.GFX + Legends.BUTTON_PAUSE);
    	self.mTimeNormalButton.changeButtonImage(Path.GFX + Legends.BUTTON_1X_SPEED_DISABLED);
    	self.mTimeFastButton.changeButtonImage(Path.GFX + Legends.BUTTON_2X_SPEED_DISABLED);
    	self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Legends.BUTTON_4X_SPEED_DISABLED);
    	self.mTimeLudicrousButton.changeButtonImage(Path.GFX + Legends.BUTTON_8X_SPEED_DISABLED);
    }, '', 10);

    var layout = $('<div class="l-normal-time-button"/>');
    this.mContainer.append(layout);
    this.mTimeNormalButton = layout.createImageButton(Path.GFX + Legends.BUTTON_1X_SPEED_DISABLED, function ()
    {
    	self.notifyBackendTimeNormalButtonPressed();

    	self.mTimePauseButton.changeButtonImage(Path.GFX + Legends.BUTTON_PAUSE_DISABLED);
    	self.mTimeNormalButton.changeButtonImage(Path.GFX + Legends.BUTTON_1X_SPEED);
    	self.mTimeFastButton.changeButtonImage(Path.GFX + Legends.BUTTON_2X_SPEED_DISABLED);
    	self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Legends.BUTTON_4X_SPEED_DISABLED);
    	self.mTimeLudicrousButton.changeButtonImage(Path.GFX + Legends.BUTTON_8X_SPEED_DISABLED);
    }, '', 10);

    var layout = $('<div class="l-fast-time-button"/>');
    this.mContainer.append(layout);
    this.mTimeFastButton = layout.createImageButton(Path.GFX + Legends.BUTTON_2X_SPEED_DISABLED, function ()
    {
    	self.notifyBackendTimeFastButtonPressed();

    	self.mTimePauseButton.changeButtonImage(Path.GFX + Legends.BUTTON_PAUSE_DISABLED);
    	self.mTimeNormalButton.changeButtonImage(Path.GFX + Legends.BUTTON_1X_SPEED_DISABLED);
    	self.mTimeFastButton.changeButtonImage(Path.GFX + Legends.BUTTON_2X_SPEED);
    	self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Legends.BUTTON_4X_SPEED_DISABLED);
    	self.mTimeLudicrousButton.changeButtonImage(Path.GFX + Legends.BUTTON_8X_SPEED_DISABLED);
    }, '', 10);


    var layout = $('<div class="l-veryfast-time-button"/>');
    this.mContainer.append(layout);
    this.mTimeVeryfastButton = layout.createImageButton(Path.GFX + Legends.BUTTON_4X_SPEED_DISABLED, function ()
    {
    	self.notifyBackendTimeVeryfastButtonPressed();

    	self.mTimePauseButton.changeButtonImage(Path.GFX + Legends.BUTTON_PAUSE_DISABLED);
    	self.mTimeNormalButton.changeButtonImage(Path.GFX + Legends.BUTTON_1X_SPEED_DISABLED);
    	self.mTimeFastButton.changeButtonImage(Path.GFX + Legends.BUTTON_2X_SPEED_DISABLED);
    	self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Legends.BUTTON_4X_SPEED);
    	self.mTimeLudicrousButton.changeButtonImage(Path.GFX + Legends.BUTTON_8X_SPEED_DISABLED);
    }, '', 10);

    var layout = $('<div class="l-ludicrous-time-button"/>');
    this.mContainer.append(layout);
    this.mTimeLudicrousButton = layout.createImageButton(Path.GFX + Legends.BUTTON_8X_SPEED_DISABLED, function ()
    {
    	self.notifyBackendTimeLudicrousButtonPressed();

    	self.mTimePauseButton.changeButtonImage(Path.GFX + Legends.BUTTON_PAUSE_DISABLED);
    	self.mTimeNormalButton.changeButtonImage(Path.GFX + Legends.BUTTON_1X_SPEED_DISABLED);
    	self.mTimeFastButton.changeButtonImage(Path.GFX + Legends.BUTTON_2X_SPEED_DISABLED);
    	self.mTimeVeryfastButton.changeButtonImage(Path.GFX + Legends.BUTTON_4X_SPEED_DISABLED);
    	self.mTimeLudicrousButton.changeButtonImage(Path.GFX + Legends.BUTTON_8X_SPEED);;
    }, '', 10);
    
    this.mPausedDiv = $('<div class="display-none title-font-very-big paused-label font-color-title font-shadow-silhouette">PAUSED</div>');
    this.mPausedSpacebarDiv = $('<div class="display-none text-font-small paused-spacebar-label font-color-title font-shadow-silhouette">(Press Spacebar)</div>');
	_parentDiv.append(this.mPausedDiv);
	_parentDiv.append(this.mPausedSpacebarDiv);
};

WorldScreenTopbarDayTimeModule.prototype.destroyDIV = function ()
{
    // text & image containers
    this.mDayTimeText.remove();
    this.mDayTimeText = null;
    this.mDayTimeImage.remove();
    this.mDayTimeImage = null;

	this.mPausedDiv.remove();
	this.mPausedDiv = null;
	this.mPausedSpacebarDiv.remove();
	this.mPausedSpacebarDiv = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


WorldScreenTopbarDayTimeModule.prototype.bindTooltips = function ()
{
	this.mTimePauseButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Topbar.TimePauseButton });
	this.mTimeNormalButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Topbar.TimeNormalButton });
	this.mTimeFastButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Topbar.TimeFastButton });
	this.mTimeVeryfastButton.bindTooltip({ contentType: 'ui-element', elementId: "world-screen.topbar.TimeVeryfastButton" });
	this.mTimeLudicrousButton.bindTooltip({ contentType: 'ui-element', elementId: "world-screen.topbar.TimeLudicrousButton" });
};

WorldScreenTopbarDayTimeModule.prototype.unbindTooltips = function ()
{
	this.mTimePauseButton.unbindTooltip();
	this.mTimeNormalButton.unbindTooltip();
	this.mTimeFastButton.unbindTooltip();
	this.mTimeVeryfastButton.unbindTooltip();
	this.mTimeLudicrousButton.unbindTooltip();
};


WorldScreenTopbarDayTimeModule.prototype.registerDatasourceListener = function()
{
    this.mDataSource.addListener(WorldScreenTopbarDatasourceIdentifier.TimeInformation.Updated, jQuery.proxy(this.onTimeInformation, this));
};


WorldScreenTopbarDayTimeModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

WorldScreenTopbarDayTimeModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


WorldScreenTopbarDayTimeModule.prototype.register = function (_parentDiv)
{
    console.log('WorldScreenTopbarDayTimeModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Day-Time Module. Reason: Day-Time Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

WorldScreenTopbarDayTimeModule.prototype.unregister = function ()
{
    console.log('WorldScreenTopbarDayTimeModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Day-Time Module. Reason: Options Bar Module is not initialized.');
        return;
    }

    this.destroy();
};

WorldScreenTopbarDayTimeModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


WorldScreenTopbarDayTimeModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};

WorldScreenTopbarDayTimeModule.prototype.showMessage = function(_data)
{
    this.mPausedDiv.addClass('display-block');
	this.mPausedSpacebarDiv.addClass('display-block');

	this.mPausedDiv.html(_data.Header)
	this.mPausedSpacebarDiv.empty()
	for(var i = 0; i < _data.Subheader.length; ++i)
	{
		var text = $('<div>' + _data.Subheader[i] + '</div>')
		this.mPausedSpacebarDiv.append(text);
	}
 
	//this.mPausedSpacebarDiv.html(_data.Subheader);
}

WorldScreenTopbarDayTimeModule.prototype.hideMessage = function()
{
    this.mPausedDiv.removeClass('display-block');
	this.mPausedSpacebarDiv.removeClass('display-block');
}


WorldScreenTopbarDayTimeModule.prototype.onTimeInformation = function (_datasource, _data)
{
    if (_data === undefined || _data === null || typeof(_data) !== "object" ||
        (!(WorldScreenTopbarIdentifier.TimeInformation.Day in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Day]) !== "number") ||
        (!(WorldScreenTopbarIdentifier.TimeInformation.Time in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Time]) !== "string") ||
        (!(WorldScreenTopbarIdentifier.TimeInformation.Degree in _data) || typeof(_data[WorldScreenTopbarIdentifier.TimeInformation.Degree]) !== "number")
        )
    {
        console.error('ERROR: Failed to query time information data. Reason: Invalid result.');
        return;
    }

    this.mDayTimeText.html('Day ' + _data[WorldScreenTopbarIdentifier.TimeInformation.Day] + '<br/>' + _data[WorldScreenTopbarIdentifier.TimeInformation.Time]);
    this.mDayTimeImage.css('transform', 'rotate(' + _data[WorldScreenTopbarIdentifier.TimeInformation.Degree] + 'deg)');
};


WorldScreenTopbarDayTimeModule.prototype.updateButtons = function (_state)
{
	this.mTimePauseButton.changeButtonImage(Path.GFX + (_state == 0 ? Legends.BUTTON_PAUSE : Legends.BUTTON_PAUSE_DISABLED));
	this.mTimeNormalButton.changeButtonImage(Path.GFX + (_state == 1 ? Legends.BUTTON_1X_SPEED : Legends.BUTTON_1X_SPEED_DISABLED));
	this.mTimeFastButton.changeButtonImage(Path.GFX + (_state == 2 ? Legends.BUTTON_2X_SPEED : Legends.BUTTON_2X_SPEED_DISABLED));
	this.mTimeVeryfastButton.changeButtonImage(Path.GFX + (_state == 3 ? Legends.BUTTON_4X_SPEED : Legends.BUTTON_4X_SPEED_DISABLED));
	this.mTimeLudicrousButton.changeButtonImage(Path.GFX + (_state == 4 ? Legends.BUTTON_8X_SPEED : Legends.BUTTON_8X_SPEED_DISABLED));
};


WorldScreenTopbarDayTimeModule.prototype.enableNormalTimeButton = function (_enabled)
{
	this.mTimeNormalButton.enableButton(_enabled);
}


WorldScreenTopbarDayTimeModule.prototype.notifyBackendPauseButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onPauseButtonPressed');
};


WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimePauseButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimePauseButtonPressed');
};


WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeNormalButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeNormalButtonPressed');
};


WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeFastButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeFastButtonPressed');
};

WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeVeryfastButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeVeryfastButtonPressed');
};

WorldScreenTopbarDayTimeModule.prototype.notifyBackendTimeLudicrousButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onTimeLudicrousButtonPressed');
};