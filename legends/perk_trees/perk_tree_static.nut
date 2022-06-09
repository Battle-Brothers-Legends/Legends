this.perk_tree_static <- ::inherit("scripts/legends/perk_trees/perk_tree", {
{
	m = {},
	function create()
	{
	}

	function init( _template )
	{
		this.perk_tree.init();
		this.setTemplate(_template);
		return this;
	}

	function build()
	{
		this.__build(this.m.Template);
	}
});
