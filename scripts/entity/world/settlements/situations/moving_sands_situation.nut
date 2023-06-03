this.moving_sands_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.moving_sands";
		this.m.Name = "Moving Sands";
		this.m.Description = "The area around the city has been infested with swarming serpents, some especially large. Trade has suffered and goods have become more rare and expensive.";
		this.m.Icon = "ui/settlement_status/settlement_effect_42.png";
		this.m.Rumors = [
			"Word is that traders on the road to %settlement% have been swallowed whole by shifting sands. But who believes nonsense like that?",
			"You afraid of snakes? A lot have been seen near %settlement% lately, some as long as my arm, some as long as a whole trader\'s wagon!"
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
		_settlement.removeSituationByID("situation.safe_roads");
		_settlement.resetShop();

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
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.85;
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

