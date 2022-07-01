this.legend_rune_accuracy_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = 2;
		this.m.Skill = "perk.legend_vala_inscribe_weapon";
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_accuracy";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
