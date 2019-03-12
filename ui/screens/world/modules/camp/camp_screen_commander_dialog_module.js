
"use strict";

var CampScreenCommanderDialogModule = function(_parent)
{
	this.mSQHandle = null;
    this.mParent = _parent;

	this.mRoster = null;

    // event listener
    this.mEventListener = null;

	// generic containers
	this.mContainer = null;
    this.mDialogContainer = null;

    this.mListScrollContainer = null;
    this.mSlots = null;
    // buttons
    this.mLeaveButton = null;

    // generics
    this.mIsVisible = false;
};


CampScreenCommanderDialogModule.prototype.isConnected = function ()
{
    return this.mSQHandle !== null;
};

CampScreenCommanderDialogModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

        // notify listener
        if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
		{
            this.mEventListener.onModuleOnConnectionCalled(this);
        }
	}
};

CampScreenCommanderDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

    // notify listener
    if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
        this.mEventListener.onModuleOnDisconnectionCalled(this);
    }
};

CampScreenCommanderDialogModule.prototype.createDIV = function (_parentDiv)
{
    var self = this;

    // create: containers (init hidden!)
    this.mContainer = $('<div class="l-commander-dialog-container display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);
    this.mDialogContainer = this.mContainer.createDialog('Commander', '', '', true, 'dialog-1024-768');

    // create content
    var content = this.mDialogContainer.findDialogContentContainer();

    // left column
    var column = $('<div class="left-column"/>');
    content.append(column);


    // right column
    column = $('<div class="right-column"/>');
    content.append(column);

    var top = $('<div class="top"/>');
    column.append(top);
    var listContainerLayout = $('<div class="l-list-container"/>');
    top.append(listContainerLayout);
    this.createBrotherSlots(listContainerLayout);

    var bottom = $('<div class="bottom"/>');
    column.append(bottom);
    listContainerLayout = $('<div class="l-list-container"/>');
    bottom.append(listContainerLayout);
    this.createBrotherSlots(listContainerLayout, true);
    // var listContainerLayout = $('<div class="l-list-container"/>');
    // column.append(listContainerLayout);
    // this.mListScrollContainer = listContainerLayout;

    // create empty slots
    // this.createBrotherSlots(this.mListScrollContainer);


    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"/>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-leave-button"/>');
    footerButtonBar.append(layout);
    this.mLeaveButton = layout.createTextButton("Leave", function() {
        self.notifyBackendLeaveButtonPressed();
    }, '', 1);

    this.mIsVisible = false;
};

CampScreenCommanderDialogModule.prototype.destroyDIV = function ()
{
	this.mLeaveButton.remove();
    this.mLeaveButton = null;

    this.mListScrollContainer.empty();
    this.mListScrollContainer = null;

    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;



    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};

CampScreenCommanderDialogModule.prototype.createBrotherSlots = function (_parentDiv, reserve)
{
    var self = this;

    var mSlots = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null ];

    var dropHandler = function (ev, dd)
    {
        var drag = $(dd.drag);
        var drop = $(dd.drop);
        var proxy = $(dd.proxy);

        if (proxy === undefined || proxy.data('idx') === undefined || drop === undefined || drop.data('idx') === undefined)
        {
            return false;
        }

        drag.removeClass('is-dragged');

        if (drag.data('idx') == drop.data('idx'))
        {
            return false;
        }

        // number in formation is limited
        if (self.mNumActive >= self.mNumActiveMax && drag.data('idx') > 27 && drop.data('idx') <= 27 && self.mSlots[drop.data('idx')].data('child') == null)
        {
            return false;
        }

        // always keep at least 1 in formation
        if (self.mNumActive == 1 && drag.data('idx') <= 27 && drop.data('idx') > 27 && self.mSlots[drop.data('idx')].data('child') == null)
        {
            return false;
        }

        // do the swapping
        self.swapSlots(drag.data('idx'), drop.data('idx'));
    };

    for (var i = 0; i < 27; ++i)
    {
        if(!reserve)
            mSlots[i] = $('<div class="ui-control is-brother-slot is-roster-slot"/>');
        else
            mSlots[i] = $('<div class="ui-control is-brother-slot is-reserve-slot"/>');

        _parentDiv.append(mSlots[i]);

        mSlots[i].data('idx', i);
        mSlots[i].data('child', null);
        mSlots[i].drop("end", dropHandler);
    }
    return mSlots;

    /*$('.is-brother-slot')
      .drop("start", function ()
      {
          $(this).addClass("is-active-slot");
      })
      .drop("end", function ()
      {
          $(this).removeClass("is-active-slot");
      });*/
}


CampScreenCommanderDialogModule.prototype.bindTooltips = function ()
{
    //this.mAssets.bindTooltips();
    this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

CampScreenCommanderDialogModule.prototype.unbindTooltips = function ()
{
	//this.mAssets.unbindTooltips();
    this.mLeaveButton.unbindTooltip();
};


CampScreenCommanderDialogModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

CampScreenCommanderDialogModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


CampScreenCommanderDialogModule.prototype.register = function (_parentDiv)
{
    console.log('CampScreenCommanderDialogModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

CampScreenCommanderDialogModule.prototype.unregister = function ()
{
    console.log('CampScreenCommanderDialogModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
        return;
    }

    this.destroy();
};

CampScreenCommanderDialogModule.prototype.isRegistered = function ()
{
    if (this.mContainer !== null)
    {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


CampScreenCommanderDialogModule.prototype.registerEventListener = function(_listener)
{
    this.mEventListener = _listener;
};


CampScreenCommanderDialogModule.prototype.show = function (_withSlideAnimation)
{
    var self = this;

    var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true)
    {
        var offset = -(this.mContainer.parent().width() + this.mContainer.width());
        this.mContainer.css({ 'left': offset });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function () {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
    else
    {
        this.mContainer.css({ opacity: 0 });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function() {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function() {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
};

CampScreenCommanderDialogModule.prototype.hide = function ()
{
    var self = this;

    var offset = -(this.mContainer.parent().width() + this.mContainer.width());
    this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
        duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
        easing: 'swing',
        begin: function ()
        {
            $(this).removeClass('is-center');
            self.notifyBackendModuleAnimating();
        },
        complete: function ()
        {
        	self.mIsVisible = false;
            $(this).removeClass('display-block').addClass('display-none');
            self.notifyBackendModuleHidden();
        }
    });
};

CampScreenCommanderDialogModule.prototype.isVisible = function ()
{
    return this.mIsVisible;
};

CampScreenCommanderDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
	//this.updateListEntryValues();
}

CampScreenCommanderDialogModule.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null)
    {
        return;
    }
};


CampScreenCommanderDialogModule.prototype.notifyBackendModuleShown = function ()
{
    SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenCommanderDialogModule.prototype.notifyBackendModuleHidden = function ()
{
    SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenCommanderDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
    SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenCommanderDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};