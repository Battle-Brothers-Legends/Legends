this.perk_legend_favoured_enemy_southerner <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_southerner";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemySoutherner;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemySoutherner;
		this.m.Icon = "ui/perks/favoured_southerner_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSoutherners;
	}

});

