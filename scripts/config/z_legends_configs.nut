local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

gt.Const.LegendMod.Configs <- {
    IsArmor = false,
    IsMagic = false,
    IsGender = false,
	IsItemScaling = false,
	IsLocationScaling = false,
	IsCampUnlock = false,
	IsRecruitScaling = false,
    IsBleedKiller = false

    Update = function (_settings)
    {
		this.IsGender = _settings.LegendGenderEquality;
		this.IsMagic = _settings.LegendMagic;
		this.IsArmor = _settings.LegendArmor;
		this.IsItemScaling = _settings.LegendItemScaling;
		this.IsLocationScaling = _settings.LegendLocationScaling;
		this.IsCampUnlock = _settings.LegendCampUnlock;
		this.IsRecruitScaling = _settings.LegendRecruitScaling;
        this.IsBleedKiller = _settings.LegendBleedKiller;
    }

    LegendArmorsEnabled = function ()
    {
        return this.IsArmor
    }

    LegendMagicEnabled = function ()
    {
        return this.IsMagic
    }

    LegendGenderEnabled = function ()
    {
        return this.IsGender
    }

    LegendItemScalingEnabled = function ()
    {
        return this.IsItemScaling
    }

    LegendLocationScalingEnabled = function ()
    {
        return this.IsLocationScaling
    }

    LegendCampUnlockEnabled = function ()
    {
        return this.IsCampUnlock
    }

    LegendRecruitScalingEnabled = function ()
    {
        return this.IsRecruitScaling
    }

    LegendBleedKillerEnabled = function ()
    {
        return this.IsBleedKiller
    }

    onSerialize = function (_out)
    {
        _out.writeBool(this.IsArmor);
		_out.writeBool(this.IsMagic);
		_out.writeBool(this.IsGender);
		_out.writeBool(this.IsItemScaling);
		_out.writeBool(this.IsLocationScaling);
		_out.writeBool(this.IsCampUnlock);
		_out.writeBool(this.IsRecruitScaling);
        _out.writeBool(this.IsBleedKiller);
    }

    onDeserialize = function (_in)
    {
		this.IsArmor = _in.readBool();
		this.IsMagic = _in.readBool();
		this.IsGender = _in.readBool();
        this.IsItemScaling = _in.readBool();
        this.IsLocationScaling = _in.readBool();
        this.IsCampUnlock = _in.readBool();
        this.IsRecruitScaling = _in.readBool();
        if (_in.getMetaData().getVersion() >= 63)
		{
			this.IsBleedKiller = _in.readBool();
		}
        
    }
}

