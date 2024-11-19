::mods_hookExactClass("entity/world/settlements/situations/terrified_villagers_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The villagers here are terrified of unknown horrors. Fewer potential recruits are to be found on the streets, and people deal less favourably with strangers. Those formerly in the business of graves are rightfully seeking new employment. Upon resolution this will refresh the hiring roster in town.";
		this.m.Rumors = [
			"The dead ain\'t really dead, sometimes they come back to haunt the living! Don\'t believe me? Just head over to %settlement% and see for yourself!",
			"You look like an able swordsman! I heard rumors of the dead walking again near %settlement%. Humbug probably, but frightened folks often pay good crowns to feel safe again.",
			"Aye, it\'s a bad time to be in the gravedigging or graverobbing business, I tell ye. Especially if you are in %settlement%!"
		];
	}

	o.onAdded <- function ( _settlement )
	{
		_settlement.resetRoster(true);
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
		_settlement.resetRoster(true);
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}

		_settlement.resetRoster(true);

		if (::Math.rand(1,10)==1)
		{
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
		}
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("graverobber_background");
		_draftList.push("graverobber_background");
	}
});
