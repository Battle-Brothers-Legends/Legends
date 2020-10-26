this.perk_legend_favoured_enemy_serpent <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_serpent";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemySerpent;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemySerpent;
		this.m.Icon = "ui/perks/favoured_serpent_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSerpents;
	}

});

