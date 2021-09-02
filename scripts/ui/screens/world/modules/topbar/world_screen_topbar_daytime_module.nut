this.world_screen_topbar_daytime_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		OnPausePressedListener = null,
		OnTimePausePressedListener = null,
		OnTimeNormalPressedListener = null,
		OnTimeFastPressedListener = null,
		OnTimeVeryfastPressedListener = null,
		OnTimeLudicrousPressedListener = null

	},
	function clearEventListener()
	{
		this.m.OnPausePressedListener = null;
		this.m.OnTimePausePressedListener = null;
		this.m.OnTimeNormalPressedListener = null;
		this.m.OnTimeFastPressedListener = null;
		this.m.OnTimeVeryfastPressedListener = null;
		this.m.OnTimeLudicrousPressedListener = null;
	}

	function setOnPausePressedListener( _listener )
	{
		this.m.OnPausePressedListener = _listener;
	}

	function setOnTimePausePressedListener( _listener )
	{
		this.m.OnTimePausePressedListener = _listener;
	}

	function setOnTimeNormalPressedListener( _listener )
	{
		this.m.OnTimeNormalPressedListener = _listener;
	}

	function setOnTimeFastPressedListener( _listener )
	{
		this.m.OnTimeFastPressedListener = _listener;
	}

	function setOnTimeVeryfastPressedListener( _listener )
	{
		this.m.OnTimeVeryfastPressedListener = _listener;
	}

	function setOnTimeLudicrousPressedListener( _listener )
	{
		this.m.OnTimeLudicrousPressedListener = _listener;
	}

	function create()
	{
		this.m.ID = "TopbarDayTimeModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.clearEventListener();
		this.ui_module.destroy();
	}

	function update( _data )
	{
		this.m.JSHandle.asyncCall("update", _data);
	}

	function showMessage( _primary, _secondary )
	{
		local data = {
			Header = _primary,
			Subheader = _secondary
		};
		this.m.JSHandle.asyncCall("showMessage", data);
	}

	function hideMessage()
	{
		this.m.JSHandle.asyncCall("hideMessage", null);
	}

	function updateTimeButtons( _state )
	{
		this.m.JSHandle.asyncCall("updateButtons", _state);
	}

	function enableNormalTimeButton( _enabled )
	{
		this.m.JSHandle.asyncCall("enableNormalTimeButton", _enabled);
	}

	function onPauseButtonPressed()
	{
		if (this.m.OnPausePressedListener != null)
		{
			this.m.OnPausePressedListener();
		}
	}

	function onTimePauseButtonPressed()
	{
		if (this.m.OnTimePausePressedListener != null)
		{
			this.m.OnTimePausePressedListener();
		}
	}

	function onTimeNormalButtonPressed()
	{
		if (this.m.OnTimeNormalPressedListener != null)
		{
			this.m.OnTimeNormalPressedListener();
		}
	}

	function onTimeFastButtonPressed()
	{
		if (this.m.OnTimeFastPressedListener != null)
		{
			this.m.OnTimeFastPressedListener();
		}
	}

	function onTimeVeryfastButtonPressed()
	{
		if (this.m.OnTimeVeryfastPressedListener != null)
		{
			this.m.OnTimeVeryfastPressedListener();
		}
	}

	function onTimeLudicrousButtonPressed()
	{
		if (this.m.OnTimeLudicrousPressedListener != null)
		{
			this.m.OnTimeLudicrousPressedListener();
		}
	}

});

