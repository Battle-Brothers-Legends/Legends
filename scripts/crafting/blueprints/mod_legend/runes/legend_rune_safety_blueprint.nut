this.legend_rune_safety_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = 22;
		this.m.Skill = "perk.legend_vala_inscribe_armor";			
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_safety";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
