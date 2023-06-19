this.disappearing_villagers_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.disappearing_villagers";
		this.m.Name = "Disappearing Villagers";
		this.m.Description = "Villagers have been disappearing from this town, putting everyone on edge. Fewer potential recruits are to be found on the streets, and people deal less favourably with strangers.";
		this.m.Icon = "ui/settlement_status/settlement_effect_11.png";
		this.m.Rumors = [
			"I just cancelled my visit to %settlement% after I heard that people go missing over there. Staying out of trouble served me well so far!",
			"Me neighbour %randomname% went to %settlement% \'bout a week ago. Haven\'t heard a word of him since. I just hope nothing happened to him, you know, with them brigands and monsters and all roaming \'bout...",
			"The forces of evil are strong in this world. They hide in the woods, and in the mountains, and in the shadows, and sometimes folk just disappear without a trace. It\'s happening again right now over in %settlement%."
		];
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
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
	}

	function onResolved( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.5;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}
	}

});

