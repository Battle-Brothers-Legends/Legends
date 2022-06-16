this.hunting_season_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.hunting_season";
		this.m.Name = "Hunting Season";
		this.m.Description = "The forests are bustling with deer and it is hunting season. Venison and furs are in rich supply.";
		this.m.Icon = "ui/settlement_status/settlement_effect_36.png";
		this.m.Rumors = [
			"Do you like venison, sellsword? And how about your men? I heard that hunting season has started in %settlement%. Just saying.",
			"It\'s the time of the year that all hunters have been eagerly waiting for. The hunting season started around %settlement% just now!",
			"Hunting outside the season might get you your hands cut right off! Doesn\'t matter, though, as the season will start any day now in the forests over by %settlement%."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.02);
		}
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("legend_taxidermist_background");
		_draftList.push("legend_taxidermist_background");
		_draftList.push("houndmaster_background");
		_draftList.push("houndmaster_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
	}

});

