this.razed_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.razed";
		this.m.Name = "Razed";
		this.m.Description = "This place has been razed. Many of its inhabitants lie slain, and any valuables have been plundered.";
		this.m.Icon = "ui/settlement_status/settlement_effect_10.png";
		this.m.Rumors = [
			"Smoke columns can be seen from miles and miles away. There is naught more than a burning pile of rubble where %settlement% once stood.",
			"Floods of refugees have been arriving from %settlement%. They claim that most of it has been burned to the ground! Can this be true?",
			"%settlement% is no more, just a black charred skeleton smoking and smoldering... How did it come to this?"
		];
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + " now is " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer is " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.20);
		}
		_settlement.resetShop();
		_settlement.resetRoster(false);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 0.5;
		_modifiers.BuyPriceMult *= 2.0;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.25;
		_modifiers.RarityMult *= 0.25;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("graverobber_background");
		_draftList.push("raider_background");

		if (_gender)
		{
		_draftList.push("female_beggar_background");
		_draftList.push("female_beggar_background");
		_draftList.push("female_beggar_background");
		_draftList.push("female_thief_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}
	}

});

