this.perk_legend_favoured_enemy_noble<- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_noble";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyNoble;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyNoble;
		this.m.Icon = "ui/perks/favoured_noble_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteNoble;
	}

});

