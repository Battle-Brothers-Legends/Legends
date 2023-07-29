this.tactical_screen_topbar_options <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		OnToggleHighlightBlockedTilesListener = null,
		OnSwitchMapLevelUpListener = null,
		OnSwitchMapLevelDownListener = null,
		OnToggleStatsOverlaysListener = null,
		OnFleePressedListener = null,
		OnQuitPressedListener = null,
		OnCenterPressedListener = null,
		OnToggleTreesPressedListener = null
	},
	function setOnToggleHighlightBlockedTilesListener( _listener )
	{
		this.m.OnToggleHighlightBlockedTilesListener = _listener;
	}

	function setOnSwitchMapLevelUpListener( _listener )
	{
		this.m.OnSwitchMapLevelUpListener = _listener;
	}

	function setOnSwitchMapLevelDownListener( _listener )
	{
		this.m.OnSwitchMapLevelDownListener = _listener;
	}

	function setOnToggleStatsOverlaysListener( _listener )
	{
		this.m.OnToggleStatsOverlaysListener = _listener;
	}

	function setOnFleePressedListener( _listener )
	{
		this.m.OnFleePressedListener = _listener;
	}

	function setOnQuitPressedListener( _listener )
	{
		this.m.OnQuitPressedListener = _listener;
	}

	function setOnCenterPressedListener( _listener )
	{
		this.m.OnCenterPressedListener = _listener;
	}

	function setOnToggleTreesListener( _listener )
	{
		this.m.OnToggleTreesPressedListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnToggleHighlightBlockedTilesListener = null;
		this.m.OnSwitchMapLevelUpListener = null;
		this.m.OnSwitchMapLevelDownListener = null;
		this.m.OnToggleStatsOverlaysListener = null;
		this.m.OnFleePressedListener = null;
		this.m.OnQuitPressedListener = null;
		this.m.OnCenterPressedListener = null;
		this.m.OnToggleTreesPressedListener = null;
	}

	function create()
	{
		this.m.ID = "TopbarOptionsModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.clearEventListener();
		this.ui_module.destroy();
	}

	function setToggleHighlightBlockedTilesListenerButtonState( _enable )
	{
		this.m.JSHandle.asyncCall("setHighlightBlockedTilesButtonState", _enable);
	}

	function setToggleStatsOverlaysButtonState( _enable )
	{
		this.m.JSHandle.asyncCall("setToggleStatsOverlaysButtonState", _enable);
	}

	function setToggleTreesButtonState( _enable )
	{
		this.m.JSHandle.asyncCall("setToggleTreesButtonState", _enable);
	}

	function setFleeButtonEnabled( _enabled )
	{
		this.m.JSHandle.asyncCall("setFleeButtonEnabled", _enabled);
	}

	function onToggleHighlightBlockedTilesListenerButtonPressed()
	{
		if (this.m.OnToggleHighlightBlockedTilesListener != null)
		{
			this.m.OnToggleHighlightBlockedTilesListener();
		}
	}

	function onSwitchMapLevelUpButtonPressed()
	{
		if (this.m.OnSwitchMapLevelUpListener != null)
		{
			this.m.OnSwitchMapLevelUpListener();
		}
	}

	function onSwitchMapLevelDownButtonPressed()
	{
		if (this.m.OnSwitchMapLevelDownListener != null)
		{
			this.m.OnSwitchMapLevelDownListener();
		}
	}

	function onToggleStatsOverlaysButtonPressed()
	{
		if (this.m.OnToggleStatsOverlaysListener != null)
		{
			this.m.OnToggleStatsOverlaysListener();
		}
	}

	function onToggleTreesButtonPressed()
	{
		if (this.m.OnToggleTreesPressedListener != null)
		{
			this.m.OnToggleTreesPressedListener();
		}
	}

	function onFleeButtonPressed()
	{
		if (this.m.OnFleePressedListener != null)
		{
			this.m.OnFleePressedListener();
		}
	}

	function onCenterButtonPressed()
	{
		if (this.m.OnCenterPressedListener != null)
		{
			this.m.OnCenterPressedListener();
		}
	}

	function onQuitButtonPressed()
	{
		if (this.m.OnQuitPressedListener != null)
		{
			this.m.OnQuitPressedListener();
		}
	}

});

