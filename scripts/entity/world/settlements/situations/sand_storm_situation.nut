this.sand_storm_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.sand_storm";
		this.m.Name = "Sand Storm";
		this.m.Description = "Howling sandstorms have engulfed the city and hinder traders both from entering and leaving it safely. Goods are becoming more rare and prices higher.";
		this.m.Icon = "ui/settlement_status/settlement_effect_38.png";
		this.m.Rumors = [
			"I just came back from %settlement%, barely made it out! A sandstorm has engulfed the whole city!",
			"It happened again, %settlement% has been engulfed in the most terrible of sandstorms."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
	}

	function getAddedString( _s )
	{
		return _s + " suffers from a " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer suffers from a " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		}
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.75;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
	}

});

