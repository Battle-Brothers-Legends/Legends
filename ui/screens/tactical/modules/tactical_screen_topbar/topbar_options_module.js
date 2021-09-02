/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			08.03.2017
 *  @Description:	Tactical Screen - Topbar: Option Module JS
 */
"use strict";


var TacticalScreenTopbarOptionsModule = function()
{
	this.mSQHandle  = null;
	
	// event listener
	this.mEventListener = null;

	// container
	this.mContainer = null;

	// buttons
	this.mToggleHighlightBlockedTilesButton	    = null;
	this.mSwitchMapLevelUpButton		        = null;
	this.mSwitchMapLevelDownButton		        = null;
	this.mToggleStatsOverlaysButton		        = null;
	this.mCenterButton					        = null;
	this.mTreesButton					        = null;
	this.mFleeButton					        = null;
	this.mQuitButton					        = null;
};

TacticalScreenTopbarOptionsModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

TacticalScreenTopbarOptionsModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

TacticalScreenTopbarOptionsModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


TacticalScreenTopbarOptionsModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: container
	this.mContainer = $('<div class="topbar-options-module"></div>');
	_parentDiv.append(this.mContainer);

	// create: buttons
	var layout = $('<div class="l-center-camera-button"/>');
	this.mContainer.append(layout);
	this.mCenterButton = layout.createImageButton(Path.GFX + Asset.ICON_CENTER, function ()
	{
		self.notifyBackendCenterButtonPressed();
	}, '', 6);

	layout = $('<div class="l-switch-map-level-up-button"/>');
	this.mContainer.append(layout);
	this.mSwitchMapLevelUpButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SWITCH_MAP_LEVEL_UP, function()
	{
		self.notifyBackendSwitchMapLevelUpButtonPressed();
	}, '', 6);

	layout = $('<div class="l-switch-map-level-down-button"/>');
	this.mContainer.append(layout);
	this.mSwitchMapLevelDownButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SWITCH_MAP_LEVEL_DOWN, function()
	{
		self.notifyBackendSwitchMapLevelDownButtonPressed();
	}, '', 6);

	layout = $('<div class="l-toggle-stats-overlays-button"/>');
	this.mContainer.append(layout);
	this.mToggleStatsOverlaysButton = layout.createImageButton(Path.GFX + Asset.BUTTON_TOGGLE_STATS_OVERLAYS_ENABLED, function()
	{
		self.notifyBackendToggleStatsOverlaysButtonPressed();
	}, '', 6);

	layout = $('<div class="l-toggle-trees-button"/>');
	this.mContainer.append(layout);
	this.mTreesButton = layout.createImageButton(Path.GFX + Asset.BUTTON_TOGGLE_TREES_ENABLED, function ()
	{
		self.notifyBackendToggleTreesButtonPressed();
	}, '', 6);

	layout = $('<div class="l-toggle-blocked-tile-highlights-button"/>');
	this.mContainer.append(layout);
	this.mToggleHighlightBlockedTilesButton = layout.createImageButton(Path.GFX + Asset.BUTTON_TOGGLE_HIGHLIGHT_BLOCKED_TILES_DISABLED, function ()
	{
		self.notifyBackendHighlightBlockedTilesButtonPressed();
	}, '', 6);

	layout = $('<div class="l-flee-button"/>');
	this.mContainer.append(layout);
	this.mFleeButton = layout.createImageButton(Path.GFX + Asset.BUTTON_FLEE, function ()
	{
		self.notifyBackendFleeButtonPressed();
	}, '', 6);

	layout = $('<div class="l-quit-button"/>');
	this.mContainer.append(layout);
	this.mQuitButton = layout.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function ()
	{
		self.notifyBackendQuitButtonPressed();
	}, '', 6);
};

TacticalScreenTopbarOptionsModule.prototype.destroyDIV = function ()
{
	this.mToggleHighlightBlockedTilesButton.remove();
	this.mToggleHighlightBlockedTilesButton = null;
	this.mCenterButton.remove();
	this.mCenterButtonButton = null;
	this.mSwitchMapLevelUpButton.remove();
	this.mSwitchMapLevelUpButton = null;
	this.mSwitchMapLevelDownButton.remove();
	this.mSwitchMapLevelDownButton = null;
	this.mToggleStatsOverlaysButton.remove();
	this.mToggleStatsOverlaysButton = null;
	this.mTreesButton.remove();
	this.mTreesButton = null;
	this.mFleeButton.remove();
	this.mFleeButton = null;    
	this.mQuitButton.remove();
	this.mQuitButton = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


TacticalScreenTopbarOptionsModule.prototype.bindTooltips = function ()
{
	this.mToggleHighlightBlockedTilesButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.ToggleHighlightBlockedTilesButton });
	this.mCenterButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.CenterButton });
	this.mSwitchMapLevelUpButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.SwitchMapLevelUpButton });
	this.mSwitchMapLevelDownButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.SwitchMapLevelDownButton });
	this.mToggleStatsOverlaysButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.ToggleStatsOverlaysButton });
	this.mTreesButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.TreesButton });
	this.mFleeButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.FleeButton });
	this.mQuitButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.OptionsBarModule.QuitButton });
};

TacticalScreenTopbarOptionsModule.prototype.unbindTooltips = function ()
{
	this.mToggleHighlightBlockedTilesButton.unbindTooltip();
	this.mCenterButton.unbindTooltip();
	this.mSwitchMapLevelUpButton.unbindTooltip();
	this.mSwitchMapLevelDownButton.unbindTooltip();
	this.mToggleStatsOverlaysButton.unbindTooltip();
	this.mTreesButton.unbindTooltip();
	this.mFleeButton.unbindTooltip();
	this.mQuitButton.unbindTooltip();
};


TacticalScreenTopbarOptionsModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

TacticalScreenTopbarOptionsModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


TacticalScreenTopbarOptionsModule.prototype.register = function (_parentDiv)
{
	console.log('TacticalScreenTopbarOptionsModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Options Module. Reason: Options Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

TacticalScreenTopbarOptionsModule.prototype.unregister = function ()
{
	console.log('TacticalScreenTopbarOptionsModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Options Module. Reason: Options Module is not initialized.');
		return;
	}

	this.destroy();
};

TacticalScreenTopbarOptionsModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


TacticalScreenTopbarOptionsModule.prototype.registerEventListener = function (_listener)
{
	this.mEventListener = _listener;
};


TacticalScreenTopbarOptionsModule.prototype.setHighlightBlockedTilesButtonState = function (_enable)
{
	if (_enable !== null && typeof (_enable) === 'boolean')
	{
		if (_enable === true)
			this.mToggleHighlightBlockedTilesButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_HIGHLIGHT_BLOCKED_TILES_ENABLED);
		else
			this.mToggleHighlightBlockedTilesButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_HIGHLIGHT_BLOCKED_TILES_DISABLED);
	}
};


TacticalScreenTopbarOptionsModule.prototype.setToggleStatsOverlaysButtonState = function (_enable)
{
	if (_enable !== null && typeof(_enable) === 'boolean')
	{
		if (_enable === true)
			this.mToggleStatsOverlaysButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_STATS_OVERLAYS_ENABLED);
		else
			this.mToggleStatsOverlaysButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_STATS_OVERLAYS_DISABLED);
	}
};


TacticalScreenTopbarOptionsModule.prototype.setToggleTreesButtonState = function (_enable)
{
	if (_enable !== null && typeof (_enable) === 'boolean')
	{
		if (_enable === true)
			this.mTreesButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_TREES_ENABLED);
		else
			this.mTreesButton.changeButtonImage(Path.GFX + Asset.BUTTON_TOGGLE_TREES_DISABLED);
	}
};


TacticalScreenTopbarOptionsModule.prototype.setFleeButtonEnabled = function (_enabled)
{
	this.mFleeButton.enableButton(_enabled);
};

TacticalScreenTopbarOptionsModule.prototype.changeFleeButtonToAllowRetreat = function (_allowRetreat)
{
	if (_allowRetreat === true) 
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Legends.BUTTON_ALLOW_RETREAT);
	}
	else if(_allowRetreat === false)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Asset.BUTTON_FLEE);
	}
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendCenterButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onCenterButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendHighlightBlockedTilesButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onToggleHighlightBlockedTilesListenerButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendSwitchMapLevelUpButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onSwitchMapLevelUpButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendSwitchMapLevelDownButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onSwitchMapLevelDownButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendToggleStatsOverlaysButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onToggleStatsOverlaysButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendToggleTreesButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onToggleTreesButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendFleeButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onFleeButtonPressed');
};

TacticalScreenTopbarOptionsModule.prototype.notifyBackendQuitButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onQuitButtonPressed');
	}
};