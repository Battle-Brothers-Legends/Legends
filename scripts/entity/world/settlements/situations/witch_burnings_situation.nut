this.witch_burnings_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.witch_burnings";
		this.m.Name = "Witch Burnings";
		this.m.Description = "A fiery spectacle, witch burnings attract spectators, and spectators attract food stands. And then, there\'s bound to be a number of witchhunters in town...";
		this.m.Icon = "ui/settlement_status/settlement_effect_32.png";
		this.m.Rumors = [
			"Some witch hunters came by yesterday. They didn\'t find what they were looking for and headed on to %settlement%.",
			"From what I hear they found a witch in %settlement% and will put her to the pyre. Come to think of it, maybe I should report that old shrew that bested me on the market the other day, she\'s a witch for sure!"
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
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.05);
		}
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onRemoved( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");

		if (_gender)
		{
			_draftList.push("female_beggar_background");
			_draftList.push("female_beggar_background");
			_draftList.push("female_beggar_background");
			_draftList.push("legend_nun_background");

		}
	}
});

