::Legends.Class.PerkTreeStatic <- class extends ::Legends.Class.PerkTree
{
	constructor( _perkDefsTree )
	{
		base.constructor();
		this.PerkDefsTree = _perkDefsTree;
	}

	function build()
	{
		if (::Legends.Mod.ModSettings.getSetting("PerkTrees").getValue())
		{
			this.__build(this.PerkDefsTree);
		}
		else
		{
			this.__build(::Const.Perks.DefaultCustomPerkTree);
		}
	}
}
