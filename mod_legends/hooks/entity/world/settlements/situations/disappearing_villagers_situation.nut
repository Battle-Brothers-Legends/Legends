::mods_hookExactClass("entity/world/settlements/situations/disappearing_villagers_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Villagers have been disappearing from this town, putting everyone on edge. Fewer locals are to be found on the streets, the belongings of the disappeared have somehow appeared in the markets. Enterprising Ratcatchers and Beast Slayers have also turned up, offering to hunt down the beasts plaguing the settlement in exchange for coin.";
		this.m.Rumors = [
			"I just cancelled my visit to %settlement% after I heard that people go missing over there. Staying out of trouble served me well so far!",
			"Me neighbour %randomname% went to %settlement% \'bout a week ago. Haven\'t heard a word of him since. I just hope nothing happened to him, you know, with them brigands and monsters and all roaming \'bout...",
			"The forces of evil are strong in this world. They hide in the woods, and in the mountains, and in the shadows, and sometimes folk just disappear without a trace. It\'s happening again right now over in %settlement%.",
			"If ye are of the beast hunting sort, there\'s been talk of crowns to be made at %settlement% on account of the beast attacks there. Why, many a ratcatcher or so-called beast slayer has stopped by here on their way there. Fools, all of them!"
		];
	}

	o.onAdded <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
		_settlement.resetRoster(true);
		_settlement.resetShop();

		if (::Math.rand(1,10)==1)
		{
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
		}
	}

	o.onUpdate = function ( _modifiers )
	{
		// _modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RarityMult *= 1.1;
		_modifiers.RecruitsMult *= 0.7;
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		if  (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		_draftList.push("ratcatcher_background");
		_draftList.push("ratcatcher_background");
		_draftList.push("ratcatcher_background");
		_draftList.push("ratcatcher_background");
		_draftList.push("beast_hunter_background");
		_draftList.push("beast_hunter_background");
	}
});
