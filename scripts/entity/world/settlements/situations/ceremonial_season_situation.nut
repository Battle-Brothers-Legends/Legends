this.ceremonial_season_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.ceremonial_seasonn";
		this.m.Name = "Ceremonial Season";
		this.m.Description = "During the ceremonial season, large amounts of incense are used by temples. The demand and prices for incense are at an all-time high.";
		this.m.Icon = "ui/settlement_status/settlement_effect_44.png";
		this.m.Rumors = [
			"During this time of the year, the temples in %settlement% smoke like a hovel that\'s on fire! I wonder where they get all that incense from...",
			"If you are a godly person you might want to head to %settlement% to burn some incense and say some prayers."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
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
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		}
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.IncensePriceMult *= 1.5;
	}



	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("monk_background");
		_draftList.push("monk_background");
		_draftList.push("cultist_background");
		_draftList.push("flagellant_background");
		if (_gender)
			{
			_draftList.push("legend_nun_background");
			_draftList.push("legend_nun_background");
		}
		if  ( this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			_draftList.push("legend_husk_background");
			_draftList.push("legend_husk_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_magister_background");
		}
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
		{
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
		}
	}

});

