/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			03.03.2017 (refactored: 25.10.2017)
 *  @Description:	Tactical Screen - Topbar: Event Log Module JS
 */
"use strict";


var TacticalScreenTopbarEventLogModule = function()
{
	this.mSQHandle  = null;
	
	// event listener
	this.mEventListener = null;

	// container
	this.mContainer = null;
	this.mEventsListContainer = null;
	this.mEventsListScrollContainer = null;

	// buttons
	this.ExpandButton = null;

	// states
	this.mIsExpanded = false;

	// timing
	this.mExpandDelay = 400;
	//this.mTimerHandle = null;

	// constants
	this.mMaxVisibleEntries = 150;
	this.mNormalHeight = '13.0rem';
	//this.mExtendedHeight = '41.1rem';
	this.mExtendedHeight = '40.0rem';
};


TacticalScreenTopbarEventLogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

TacticalScreenTopbarEventLogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
    {
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

TacticalScreenTopbarEventLogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
    {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


TacticalScreenTopbarEventLogModule.prototype.createDIV = function (_parentDiv)
{
	var grandpa = _parentDiv.parent();
	_parentDiv.css('opacity', '0');

	var newlog = $('<div class="new-log-container"/>');
	grandpa.append(newlog);
	var width = Math.max(200, Math.min(grandpa.parent().width() / 3.5, 800));
	newlog.css('width', width);
	newlog.css('background-size', newlog.width() + " " + newlog.height());
	
	var self = this;

	// create: container
	this.mContainer = $('<div class="topbar-event-log-module"/>');
    newlog.append(this.mContainer);

	// create: log container
	var eventLogsContainerLayout = $('<div class="l-event-logs-container"/>');
	eventLogsContainerLayout.css('width', newlog.width() - 50);

	this.mContainer.append(eventLogsContainerLayout);
    this.mEventsListContainer = eventLogsContainerLayout.createList(15);
    this.mEventsListScrollContainer = this.mEventsListContainer.findListScrollContainer();

    this.mEventsListContainer.css('background-size', newlog.width() - 65, + " " + newlog.height());

    // create: button
    var layout = $('<div class="l-expand-button"/>');
    this.mContainer.append(layout);
    this.ExpandButton = layout.createImageButton(Path.GFX + Asset.BUTTON_OPEN_EVENTLOG, function ()
    {
        self.expand(!self.mIsExpanded);
    }, '', 6);
	//this.ExpandButton.css('z-index', '9999999');
    this.expand(false);
};

TacticalScreenTopbarEventLogModule.prototype.destroyDIV = function ()
{
    this.mEventsListScrollContainer.empty();
    this.mEventsListScrollContainer = null;
    this.mEventsListContainer.destroyList();
    this.mEventsListContainer.remove();
    this.mEventsListContainer = null;

    this.ExpandButton.remove();
    this.ExpandButton = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


TacticalScreenTopbarEventLogModule.prototype.createEventLogEntryDIV = function (_text)
{
	if (_text === null || typeof(_text) != 'string')
	{
		return null;
	}

	var entry = $('<div class="entry text-font-very-small font-color-ink"></div>');
	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	entry.html(parsedText.html);
	return entry;
};


TacticalScreenTopbarEventLogModule.prototype.bindTooltips = function ()
{
	this.ExpandButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.EventLogModule.ExpandButton });
};

TacticalScreenTopbarEventLogModule.prototype.unbindTooltips = function ()
{
	this.ExpandButton.unbindTooltip();
};


TacticalScreenTopbarEventLogModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

TacticalScreenTopbarEventLogModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


TacticalScreenTopbarEventLogModule.prototype.register = function (_parentDiv)
{
    console.log('TacticalScreenTopbarEventLogModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Event Log Module. Reason: Event Log Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};


TacticalScreenTopbarEventLogModule.prototype.unregister = function ()
{
    console.log('TacticalScreenTopbarEventLogModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Event Log Module. Reason: Event Log Module is not initialized.');
        return;
    }

    this.destroy();
};


TacticalScreenTopbarEventLogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


TacticalScreenTopbarEventLogModule.prototype.registerEventListener = function (_listener)
{
	this.mEventListener = _listener;
};


TacticalScreenTopbarEventLogModule.prototype.log = function (_text)
{
	var entry = this.createEventLogEntryDIV(_text);
	if (entry !== null)
	{
		if (this.mEventsListScrollContainer.children().length > this.mMaxVisibleEntries)
		{
			var firstDiv = this.mEventsListScrollContainer.children(':first');
			if (firstDiv.length > 0)
			{
				firstDiv.remove();
			}
		}

		this.mEventsListScrollContainer.append(entry);
        //this.mEventsListContainer.scrollListToElement(entry);
        this.mEventsListContainer.scrollListToBottom();
	}
};


TacticalScreenTopbarEventLogModule.prototype.clear = function ()
{
	this.mEventsListScrollContainer.empty();
};


TacticalScreenTopbarEventLogModule.prototype.expand = function (_value)
{
	if (this.mIsExpanded == _value)
	{
        this.mEventsListContainer.showListScrollbar(_value);
		return;
	}

	var self = this;
	this.mEventsListContainer.velocity("finish", true).velocity({ height: _value === true ? this.mExtendedHeight : this.mNormalHeight },
	{
		easing: 'linear',
		duration: this.mExpandDelay,
		begin: function ()
		{
            self.mEventsListContainer.scrollListToElement();
			if (_value === false)
			{
                self.mEventsListContainer.showListScrollbar(false);
			}

			if (_value)
				self.mEventsListContainer.css({ 'padding-bottom': '1.8rem' });
			else
				self.mEventsListContainer.css({ 'padding-bottom': '0' });
		},
		progress: function ()
		{
            //self.mEventsListContainer.scrollListToElement();
		},
		complete: function ()
		{
			self.mEventsListContainer.trigger('update', true);

			self.mEventsListContainer.scrollListToElement();
			if (_value === true)
			{
                self.mEventsListContainer.showListScrollbar(true)
			}

			// change button image
            self.ExpandButton.changeButtonImage(Path.GFX + (_value === true ? Asset.BUTTON_CLOSE_EVENTLOG :  Asset.BUTTON_OPEN_EVENTLOG));
		}
	});

	this.mIsExpanded = !this.mIsExpanded;
};


/*
TacticalScreenTopbarEventLogModule.prototype.scrollToLast = function (_element)
{
	var lastEntry = null;
	if (_element !== undefined)
	{
		lastEntry = _element;
	}
	else
	{
		lastEntry = this.mEventsListScrollContainer.children(':last');
	}
	
	if (lastEntry !== null && lastEntry.length > 0)
	{
		// force the renderer to relayout his shit...
		var offsets = lastEntry[0].offsetTop;
		offsets = this.mEventsListContainer[0].offsetTop;
		offsets = this.mEventsListScrollContainer[0].offsetTop;
		
		var self = this;
		
		if (this.mTimerHandle !== null)
		{
			this.mTimerHandle = clearTimeout(this.mTimerHandle);
		}

		this.mTimerHandle = setTimeout(function() {
			// force the renderer to relayout his shit...
			var offsets = lastEntry[0].offsetTop;
			offsets = self.mEventsListContainer[0].offsetTop;
			offsets = self.mEventsListScrollContainer[0].offsetTop;
			self.mEventsListScrollContainer.trigger('scroll', { top: lastEntry[0].offsetTop, duration: 0, animate: true, scrollTo: 'bottom' });
		}, 10);
	}
};
*/

/*
TacticalScreenTopbarEventLogModule.prototype.update = function ()
{
	this.mEventsListContainer.trigger('update', true);

	var lastEntry = this.mEventsListScrollContainer.children(':last');
	if (lastEntry !== null && lastEntry.length > 0)
	{
		var self = this;

		if (this.mTimerHandle !== null)
		{
			this.mTimerHandle = clearTimeout(this.mTimerHandle);
		}

		this.mTimerHandle = setTimeout(function() {
			// force the renderer to relayout his shit...
			var offsets = lastEntry[0].offsetTop;
			offsets = self.mEventsListContainer[0].offsetTop;
			offsets = self.mEventsListScrollContainer[0].offsetTop;
			self.mEventsListScrollContainer.trigger('scroll', { top: lastEntry[0].offsetTop, duration: 0, animate: true, scrollTo: 'bottom' });
		}, 10);
	}
};
    */