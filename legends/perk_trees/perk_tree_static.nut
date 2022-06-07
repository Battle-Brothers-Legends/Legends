this.perk_tree_static <- ::inherit("scripts/legends/perk_trees/perk_tree", {
{
	m = {},
	function create()
	{
	}

	function init( _perkDefsTree )
	{
		this.perk_tree.init();
		this.m.PerkDefsTree = _perkDefsTree;
	}

	function build()
	{
		this.__build(this.m.PerkDefsTree);
	}
});
