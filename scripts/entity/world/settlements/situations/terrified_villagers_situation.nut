this.terrified_villagers_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.terrified_villagers";
		this.m.Name = "Terrified Villagers";
		this.m.Description = "The villagers here are terrified of unknown horrors. Fewer potential recruits are to be found on the streets, and people deal less favourably with strangers.";
		this.m.Icon = "ui/settlement_status/settlement_effect_09.png";
		this.m.Rumors = [
			"The dead ain\'t really dead, sometimes they come back to haunt the living! Don\'t believe me? Just head over to %settlement% and see for yourself!",
			"You look like an able swordsman! I heard rumors of the dead walking again near %settlement%. Humbug probably, but frightened folks often pay good crowns to feel safe again."
		];
	}

	function onAdded( _settlement )
	{
		_settlement.resetRoster(true);
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

});

