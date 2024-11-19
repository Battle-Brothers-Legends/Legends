::mods_hookExactClass("entity/world/settlements/situations/disbanded_troops_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.035);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList = function ( _draftList, _gender = null)
	{
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");

		_draftList.push("legend_shieldmaiden_background");
		_draftList.push("legend_shieldmaiden_background");
		_draftList.push("legend_shieldmaiden_background");

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}
	}
});
