/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			12.04.2017 (refactored: 03.10.2017)
 *  @Description:	Options Menu Module - Datasource JS
 */
"use strict";


var OptionsMenuModuleDatasourceIdentifier = {
	Options: {
		Loaded: 'options.loaded',
		Reseted: 'options.reseted'
	}
};


var OptionsMenuModuleDatasource = function()
{
	this.mSQHandle = null;

	// Event handling
	this.mEventListener = {};

	// Caches
	this.mOptions = null;

	// init the datasource
	this.init();
};


OptionsMenuModuleDatasource.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
};

OptionsMenuModuleDatasource.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
	this.reset();
};


OptionsMenuModuleDatasource.prototype.addListener = function(_chanel, _callback)
{
	if (_chanel in this.mEventListener)
	{
		if (jQuery.inArray(_callback, this.mEventListener[_chanel]) === -1)
		{
			this.mEventListener[_chanel].push(_callback);
		}
	}
};

OptionsMenuModuleDatasource.prototype.removeListener = function(_chanel, _callback)
{
	if (_chanel in this.mEventListener)
	{
		var idx = jQuery.inArray(_callback, this.mEventListener[_chanel]);
		if (idx !== -1)
		{
			this.mEventListener[_chanel].remove(idx);
		}
	}
};

OptionsMenuModuleDatasource.prototype.removeListeners = function()
{
	this.createEventChannels();
};

OptionsMenuModuleDatasource.prototype.notifyEventListener = function(_chanel, _payload)
{
	if (_chanel in this.mEventListener)
	{
		var listeners = this.mEventListener[_chanel];
		for (var i = 0; i < listeners.length; ++i)
		{
			listeners[i](this, _payload);
		}
	}
};


OptionsMenuModuleDatasource.prototype.createEventChannels = function()
{
	this.mEventListener[OptionsMenuModuleDatasourceIdentifier.Options.Loaded] = [ ];
	this.mEventListener[OptionsMenuModuleDatasourceIdentifier.Options.Reseted] = [ ];
};


OptionsMenuModuleDatasource.prototype.init = function()
{
	this.createEventChannels();
};

OptionsMenuModuleDatasource.prototype.reset = function()
{
	// Caches
	this.mOptions = null;
};


OptionsMenuModuleDatasource.prototype.loadOptions = function(_data, _withoutNotify)
{
	if (_data === null)
	{
		console.log('ERROR: Failed to query options data. Reason: Invalid result.');
		return;
	}

	// extract options
	this.mOptions = {};
	if (OptionsMenuModuleIdentifier.QueryResult.Current in _data)
	{
		this.mOptions = _data[OptionsMenuModuleIdentifier.QueryResult.Current];
	}

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(OptionsMenuModuleDatasourceIdentifier.Options.Loaded, this.mOptions);
	}
};

OptionsMenuModuleDatasource.prototype.getOptions = function()
{
	if (this.mOptions === null)
	{
		this.loadOptions(true);
	}

	return this.mOptions;
};


OptionsMenuModuleDatasource.prototype.getVideoOptions = function()
{
	if (OptionsMenuModuleIdentifier.QueryResult.Video.Key in this.mOptions)
	{
		return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Video.Key];
	}

	return {};
};

OptionsMenuModuleDatasource.prototype.getVideoOption = function(_key)
{
	if (OptionsMenuModuleIdentifier.QueryResult.Video.Key in this.mOptions)
	{
		if (_key in this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Video.Key])
		{
			return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Video.Key][_key];
		}
		return null;
	}
	return null;
};


OptionsMenuModuleDatasource.prototype.getAudioOptions = function()
{
	if (OptionsMenuModuleIdentifier.QueryResult.Audio.Key in this.mOptions)
	{
		return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Audio.Key];
	}

	return {};
};

OptionsMenuModuleDatasource.prototype.getAudioOption = function(_key)
{
	if (OptionsMenuModuleIdentifier.QueryResult.Audio.Key in this.mOptions)
	{
		if (_key in this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Audio.Key])
		{
			return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Audio.Key][_key];
		}
		return null;
	}
	return null;
};


OptionsMenuModuleDatasource.prototype.getControlsOptions = function()
{
	if (OptionsMenuModuleIdentifier.QueryResult.Controls.Key in this.mOptions)
	{
		return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Controls.Key];
	}

	return {};
};


OptionsMenuModuleDatasource.prototype.getControlsOption = function(_key)
{
	if (OptionsMenuModuleIdentifier.QueryResult.Controls.Key in this.mOptions)
	{
		if (_key in this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Controls.Key])
		{
			return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Controls.Key][_key];
		}
		return null;
	}
	return null;
};


OptionsMenuModuleDatasource.prototype.getGameplayOptions = function()
{
	if (OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key in this.mOptions)
	{
		return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key];
	}

	return {};
};


OptionsMenuModuleDatasource.prototype.getGameplayOption = function(_key)
{
	if (OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key in this.mOptions)
	{
		if (_key in this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key])
		{
			return this.mOptions[OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key][_key];
		}
		return null;
	}
	return null;
};


OptionsMenuModuleDatasource.prototype.updateOption = function (_root, _key, _value)
{
	if (_root === null || !(_root in this.mOptions))
	{
		return;
	}

	if (_key in this.mOptions[_root])
	{
		this.mOptions[_root][_key] = _value;
	}
};

OptionsMenuModuleDatasource.prototype.updateVideoOption = function (_key, _value)
{
	if (_key === null || typeof(_key) !== 'string' ||  _value === null)
	{
		return;
	}

	this.updateOption(OptionsMenuModuleIdentifier.QueryResult.Video.Key, _key, _value);
};

OptionsMenuModuleDatasource.prototype.updateAudioOption = function (_key, _value)
{
	if (_key === null || typeof(_key) !== 'string' ||  _value === null)
	{
		return;
	}

	this.updateOption(OptionsMenuModuleIdentifier.QueryResult.Audio.Key, _key, _value);
};

OptionsMenuModuleDatasource.prototype.updateControlsOption = function (_key, _value)
{
	if (_key === null || typeof(_key) !== 'string' ||  _value === null)
	{
		return;
	}

	this.updateOption(OptionsMenuModuleIdentifier.QueryResult.Controls.Key, _key, _value);
};

OptionsMenuModuleDatasource.prototype.updateGameplayOption = function (_key, _value)
{
	if (_key === null || typeof(_key) !== 'string' ||  _value === null)
	{
		return;
	}

	this.updateOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key, _key, _value);
};

OptionsMenuModuleDatasource.prototype.applyVideoOptions = function ()
{
	if (!(OptionsMenuModuleIdentifier.QueryResult.Video.Key in this.mOptions))
	{
		console.error('ERROR: Failed to apply video options. Invalid data.');
		return;
	}

	var options = [];

	var value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.Resolution.Key);
	options.push(value);

	value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.WindowMode.Key);
	options.push(value);

	value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.VSync);
	options.push(value);

	value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.DepthOfField);
	options.push(value);

	value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.UIScaling.Key);
	options.push(value);

	value = this.getVideoOption(OptionsMenuModuleIdentifier.QueryResult.Video.SpriteScaling.Key);
	options.push(value);

	this.notifyBackendApplyVideoOptions(options);
};

OptionsMenuModuleDatasource.prototype.applyAudioOptions = function ()
{
	if (!(OptionsMenuModuleIdentifier.QueryResult.Audio.Key in this.mOptions))
	{
		console.error('ERROR: Failed to apply audio options. Invalid data.');
		return;
	}

	var options = [];

	var value = this.getAudioOption(OptionsMenuModuleIdentifier.QueryResult.Audio.Master);
	options.push(value);

	var value = this.getAudioOption(OptionsMenuModuleIdentifier.QueryResult.Audio.Music);
	options.push(value);

	var value = this.getAudioOption(OptionsMenuModuleIdentifier.QueryResult.Audio.Effects);
	options.push(value);

	var value = this.getAudioOption(OptionsMenuModuleIdentifier.QueryResult.Audio.Ambience);
    options.push(value);

    var value = this.getAudioOption(OptionsMenuModuleIdentifier.QueryResult.Audio.HWSound);
    options.push(value);

	this.notifyBackendApplyAudioOptions(options);
};

OptionsMenuModuleDatasource.prototype.applyControlsOptions = function ()
{
	if (!(OptionsMenuModuleIdentifier.QueryResult.Controls.Key in this.mOptions))
	{
		console.error('ERROR: Failed to apply controls options. Invalid data.');
		return;
	}

	var options = [];

	var value = this.getControlsOption(OptionsMenuModuleIdentifier.QueryResult.Controls.Scrollmode.Key);
	options.push(value);

	value = this.getControlsOption(OptionsMenuModuleIdentifier.QueryResult.Controls.HardwareMouse);
	options.push(value);

	this.notifyBackendApplyControlsOptions(options);
};

OptionsMenuModuleDatasource.prototype.applyGameplayOptions = function ()
{
	if (!(OptionsMenuModuleIdentifier.QueryResult.Gameplay.Key in this.mOptions))
	{
		console.error('ERROR: Failed to apply gameplay options. Invalid data.');
		return;
	}

	var options = [];

	var value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.CameraFollowMode);
	options.push(value);

	var value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.CameraAdjustLevel);
	options.push(value);

	var value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.AlwaysHideTrees);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.StatsOverlays);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.OrientationOverlays);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.MovementPlayer);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.MovementAI);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.AutoEndTurn);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.AutoLoot);
	options.push(value);

	value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.RestoreEquipment);
    options.push(value);

    value = this.getGameplayOption(OptionsMenuModuleIdentifier.QueryResult.Gameplay.AutoPauseAfterCity);
    options.push(value);

	value = this.getGameplayOption("AISpeed");
	options.push(value * 10);

	value = this.getGameplayOption("EnemyTooltips");
	options.push(value);

	this.notifyBackendApplyGameplayOptions(options);
};

OptionsMenuModuleDatasource.prototype.applyOptions = function ()
{
	this.applyAudioOptions();
	this.applyControlsOptions();
	this.applyGameplayOptions();
	this.applyVideoOptions();
};


OptionsMenuModuleDatasource.prototype.notifyBackendApplyVideoOptions = function (_options)
{
	SQ.call(this.mSQHandle, 'onApplyVideoOptions', _options);
};

OptionsMenuModuleDatasource.prototype.notifyBackendApplyAudioOptions = function (_options)
{
	SQ.call(this.mSQHandle, 'onApplyAudioOptions', _options);
};

OptionsMenuModuleDatasource.prototype.notifyBackendApplyControlsOptions = function (_options)
{
	SQ.call(this.mSQHandle, 'onApplyControlsOptions', _options);
};

OptionsMenuModuleDatasource.prototype.notifyBackendApplyGameplayOptions = function (_options)
{
	SQ.call(this.mSQHandle, 'onApplyGameplayOptions', _options);
};