::Legends.Class.PerkTreeDynamic <- class extends ::Legends.Class.PerkTree
{
	DynamicPerkTreeMap = null;
	Player = null;

	constructor( _player, _map )
	{
		base.constructor();
		if (!::MSU.isKindOf(_player, "player")) throw ::MSU.Exception.InvalidType(_player);
		this.Player = ::MSU.asWeakTableRef(_player);
		this.DynamicPerkTreeMap = _map;
	}

	function build()
	{
		if (::Legends.Mod.ModSettings.getSetting("PerkTrees").getValue())
		{
			local result = ::Const.Perks.GetDynamicPerkTree(_player.getBackground().getPerkTreeDynamicMins(), this.DynamicPerkTreeMap, this.Player);
			this.__build(result.PerkDefsTree);
		}
		else
		{
			this.__build(::Const.Perks.DefaultCustomPerkTree);
		}
	}
}
