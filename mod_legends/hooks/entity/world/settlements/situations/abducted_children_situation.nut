::mods_hookExactClass("entity/world/settlements/situations/abducted_children_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Children have been disappearing from this settlement. Distrust and fear rule the streets and are slowly poisoning the community. The Witch Hunters have come to investigate.";
		this.m.Rumors = [
			"Rumor is that children disappear from their cribs in %settlement% into thin air. Imagine the parents\' terror...",
			"My grandma told me a story about witches abducting children for their innocent blood. And now in %settlement%, kids have gone missing just like in the stories.",
			"Never ever strike a deal with witches! A relative in %settlement% did it years ago and now his kid is gone missing.",
			"You didn\'t hear this from me, but a bunch of pompous-looking Witch Hunters stopped by on their way to %settlement% a few days ago. One of them was yammering on about the punishment due for those who consort with witches!"
		];
	}

	o.onAdded = function ( _settlement )
	{
		_settlement.resetRoster(true);
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}

		if (::Math.rand(1,10)==1)
		{
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
		}
	}

	o.onUpdate = function ( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
	}

	o.onUpdateDraftList <- function ( _draftList, _gender = null)
	{
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
	}
});
