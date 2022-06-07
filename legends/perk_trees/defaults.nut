::Const.Perks.DefaultDynamicPerkTree <- {
	Weapon = [
		this.Const.Perks.SwordTree,
		this.Const.Perks.DaggerTree,
		this.Const.Perks.PolearmTree
	],
	Defense = [this.Const.Perks.MediumArmorTree],
	Traits = [
		this.Const.Perks.FitTree,
		this.Const.Perks.IntelligentTree,
		this.Const.Perks.AgileTree,
		this.Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Magic = []
};

::Const.Perks.OrderOfAssignment <- ["Profession", "Enemy", "Traits", "Class", "Defense", "Weapon", "Styles"];

::Const.Perks.validatePerk <- function( _perk )
{
	::MSU.requireInteger(_perk);
	if (_perk < 0 || _perk > ::Const.Perks.PerkDefs.len())
	{
		::logError("The PerDef " + _perk + " does not exist in the ::Const.Perks.PerkDefs table");
		::MSU.Exception.InvalidValue(_perk);
	}
}
// TODO: add default static perk tree and vanilla perk tree
