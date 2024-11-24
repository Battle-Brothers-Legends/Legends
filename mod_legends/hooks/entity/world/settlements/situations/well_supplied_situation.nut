::mods_hookExactClass("entity/world/settlements/situations/well_supplied_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.015);
		}
		onAdded( _settlement );
	}

	o.onUpdate = function ( _modifiers )
	{
		_modifiers.PriceMult *= 0.9;
		_modifiers.RarityMult *= 1.5;
	}
});
