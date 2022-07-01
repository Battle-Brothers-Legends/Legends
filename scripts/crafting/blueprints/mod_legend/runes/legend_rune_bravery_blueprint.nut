this.legend_rune_bravery_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = 12;
		this.m.Skill = "perk.legend_vala_inscribe_helmet";		
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_bravery";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
