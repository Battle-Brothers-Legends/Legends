this.perk_legend_favoured_enemy_hyena <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_hyena";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyHyena;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyHyena;
		this.m.Icon = "ui/perks/favoured_hyena_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteHyenas;
	}

});

