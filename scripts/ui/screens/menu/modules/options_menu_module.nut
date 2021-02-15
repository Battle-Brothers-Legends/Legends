this.options_menu_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		OnOkButtonPressedListener = null,
		OnCancelButtonPressedListener = null
	},
	function setOnOkButtonPressedListener( _listener )
	{
		this.m.OnOkButtonPressedListener = _listener;
	}

	function setOnCancelButtonPressedListener( _listener )
	{
		this.m.OnCancelButtonPressedListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnOkButtonPressedListener = null;
		this.m.OnCancelButtonPressedListener = null;
	}

	function create()
	{
		this.m.ID = "OptionsMenuModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.clearEventListener();
		this.ui_module.destroy();
	}

	function show()
	{
		if (!this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("show", null);
		}
	}

	function hide()
	{
		if (this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("hide", null);
		}
	}

	function onOkButtonPressed()
	{
		if (this.m.OnOkButtonPressedListener != null)
		{
			this.m.OnOkButtonPressedListener();
		}
	}

	function onCancelButtonPressed()
	{
		if (this.m.OnCancelButtonPressedListener != null)
		{
			this.m.OnCancelButtonPressedListener();
		}
	}

	function onQueryData()
	{
		local result = {
			current = {
				video = {},
				audio = {},
				controls = {},
				gameplay = {}
			}
		};
		this.helper_addVideoOptionsToUIData(result.current.video);
		this.helper_addAudioOptionsToUIData(result.current.audio);
		this.helper_addControlsOptionsToUIData(result.current.controls);
		this.helper_addGameplayOptionsToUIData(result.current.gameplay);
		return result;
	}

	function onApplyVideoOptions( _data )
	{
		this.helper_applyVideoOptions(_data);
	}

	function onApplyAudioOptions( _data )
	{
		this.helper_applyAudioOptions(_data);
	}

	function onApplyControlsOptions( _data )
	{
		this.helper_applyControlsOptions(_data);
	}

	function onApplyGameplayOptions( _data )
	{
		this.helper_applyGameplayOptions(_data);
	}

	function helper_addVideoOptionsToUIData( _target )
	{
		this.helper_addVideoResolutionsToUIData(_target);
		local currentVideoMode = this.Settings.getVideoMode();
		this.helper_addVideoResolutionToUIData(currentVideoMode, _target);
		this.helper_addVideoDisplayToUIData(currentVideoMode, _target);
	}

	function helper_addVideoResolutionsToUIData( _target )
	{
		local modes = this.Settings.queryResolutions(this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp);

		if (modes == null || modes.len() == 0)
		{
			return;
		}

		local result = [];

		for( local i = 0; i < modes.len(); i = ++i )
		{
			local mode = modes[i];
			result.push({
				width = mode.Width,
				height = mode.Height,
				bpp = mode.ColorBits
			});
		}

		_target.resolutions <- result;
	}

	function helper_addVideoResolutionToUIData( _currentMode, _target )
	{
		_target.resolution <- this.Settings.queryResolutionIndexByVideoMode(_currentMode, this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp);
	}

	function helper_addVideoDisplayToUIData( _currentMode, _target )
	{
		if (_currentMode.Fullscreen == true)
		{
			_target.windowMode <- "fullscreen";
		}
		else if (_currentMode.Borderless == true)
		{
			_target.windowMode <- "Borderless";
		}
		else
		{
			_target.windowMode <- "window";
		}

		_target.vsync <- _currentMode.VSync;
		_target.depthOfField <- _currentMode.DepthOfField;
		_target.uiScale <- _currentMode.UIScale * 100.0;
		_target.spriteScale <- _currentMode.SceneScale * 100.0;
	}

	function helper_applyVideoOptions( _data )
	{
		local currentResolution = this.Settings.queryResolutionByIndex(_data[0], this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp);

		if (currentResolution == null)
		{
			this.logError("Failed to query current resolution. Reason: Invalid index.");
			return;
		}

		local currentVideoMode = this.Settings.getVideoMode();
		currentVideoMode.Width = currentResolution.Width;
		currentVideoMode.Height = currentResolution.Height;
		currentVideoMode.ColorBits = currentResolution.ColorBits;

		switch(_data[1])
		{
		case "fullscreen":
			currentVideoMode.Fullscreen = true;
			currentVideoMode.Borderless = false;
			break;

		case "window":
			currentVideoMode.Fullscreen = false;
			currentVideoMode.Borderless = false;
			break;

		case "borderless":
			currentVideoMode.Fullscreen = false;
			currentVideoMode.Borderless = true;
			break;
		}

		currentVideoMode.VSync = _data[2];
		currentVideoMode.DepthOfField = _data[3];
		currentVideoMode.UIScale = _data[4] * 0.01;
		currentVideoMode.SceneScale = _data[5] * 0.01;
		this.Settings.setVideoMode(currentVideoMode);
		this.Settings.saveWithCustomVideoMode(currentVideoMode);
	}

	function helper_checkVideoOptionsNeedUpdate( _data, _currentMode, _currentResolution )
	{
		if (_currentMode.Width != _currentResolution.Width || _currentMode.Height != _currentResolution.Height || _currentMode.ColorBits != _currentResolution.ColorBits)
		{
			return true;
		}

		switch(_data[1])
		{
		case "fullscreen":
			if (_currentMode.Fullscreen != true)
			{
				return true;
			}

			break;

		case "window":
			if (_currentMode.Fullscreen == true || _currentMode.Borderless == true)
			{
				return true;
			}

			break;

		case "borderless":
			if (_currentMode.Fullscreen == true || _currentMode.Borderless == false)
			{
				return true;
			}

			break;
		}

		if (_currentMode.VSync != _data[2])
		{
			return true;
		}

		if (_currentMode.DepthOfField != _data[3])
		{
			return true;
		}

		return false;
	}

	function helper_applyAudioOptions( _data )
	{
		this.Settings.setSoundVolume(this.Const.Sound.Channel.Master, _data[0] / 100.0);
		this.Settings.setSoundVolume(this.Const.Sound.Channel.Music, _data[1] / 100.0);
		this.Settings.setSoundVolume(this.Const.Sound.Channel.Effects, _data[2] / 100.0);
		this.Settings.setSoundVolume(this.Const.Sound.Channel.Ambience, _data[3] / 100.0);
		this.Settings.setHardwareSound(_data[4]);
		this.Sound.update();
		this.Settings.save();
	}

	function helper_addAudioOptionsToUIData( _target )
	{
		_target.master <- this.Settings.getSoundVolume(this.Const.Sound.Channel.Master) * 100;
		_target.music <- this.Settings.getSoundVolume(this.Const.Sound.Channel.Music) * 100;
		_target.effects <- this.Settings.getSoundVolume(this.Const.Sound.Channel.Effects) * 100;
		_target.ambience <- this.Settings.getSoundVolume(this.Const.Sound.Channel.Ambience) * 100;
		_target.hardwareSound <- this.Settings.isHardwareSound();
	}

	function helper_applyControlsOptions( _data )
	{
		local settings = this.Settings.getControlSettings();
		settings.UseDragStyleScrolling = _data[0] == "dragWithMouse";
		settings.UseHardwareCursor = _data[1];
		this.Settings.save();
		this.Cursor.setHardwareCursor(settings.UseHardwareCursor, true);
	}

	function helper_addControlsOptionsToUIData( _target )
	{
		local settings = this.Settings.getControlSettings();
		_target.scrollMode <- settings.UseDragStyleScrolling == true ? "dragWithMouse" : "edgeOfScreen";
		_target.hardwareMouse <- settings.UseHardwareCursor;
	}

	function helper_applyGameplayOptions( _data )
	{
		local settings = this.Settings.getGameplaySettings();
		settings.AlwaysFocusCamera = _data[0];
		settings.AdjustCameraLevel = _data[1];
		settings.AlwaysHideTrees = _data[2];
		settings.ShowOverlayStats = _data[3];
		settings.ShowOrientationOverlays = _data[4];
		settings.FasterPlayerMovement = _data[5];
		settings.FasterAIMovement = _data[6];
		settings.DontAutoEndTurns = !_data[7];
		settings.AutoLoot = _data[8];
		settings.RestoreEquipment = _data[9];
		settings.AutoPauseAfterCity = _data[10];
		this.LegendsMod.Configs().setAISpeed((_data[11] * 1.0) / 10.0);
		this.LegendsMod.Configs().setEnemeyTooltips(_data[12]);
		this.Settings.save();
		settings = this.Settings.getTempGameplaySettings();
		settings.ShowOverlayStats = _data[1];
		settings.HideTrees = _data[2];

	}

	function helper_addGameplayOptionsToUIData( _target )
	{
		local settings = this.Settings.getGameplaySettings();
		_target.cameraFollowMode <- settings.AlwaysFocusCamera;
		_target.cameraAdjustLevel <- settings.AdjustCameraLevel;
		_target.alwaysHideTrees <- settings.AlwaysHideTrees;
		_target.statsOverlays <- settings.ShowOverlayStats;
		_target.orientationOverlays <- settings.ShowOrientationOverlays;
		_target.movementPlayer <- settings.FasterPlayerMovement;
		_target.movementAI <- settings.FasterAIMovement;
		_target.autoEndTurn <- !settings.DontAutoEndTurns;
		_target.autoLoot <- settings.AutoLoot;
		_target.restoreEquipment <- settings.RestoreEquipment;
		_target.autoPauseAfterCity <- settings.AutoPauseAfterCity;
		_target.AISpeed <- this.LegendsMod.Configs().AISpeed();
		_target.EnemyTooltips <- this.LegendsMod.Configs().EnemeyTooltips();

	}

});

