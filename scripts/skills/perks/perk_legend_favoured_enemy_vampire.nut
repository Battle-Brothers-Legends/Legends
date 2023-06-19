this.perk_legend_favoured_enemy_vampire <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_vampire";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyVampire;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyVampire;
		this.m.Icon = "ui/perks/favoured_vampire_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteVampire;
		this.m.BraveryMult = 1.5;
	}

});

