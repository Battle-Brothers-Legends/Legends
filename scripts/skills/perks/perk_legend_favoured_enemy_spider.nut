this.perk_legend_favoured_enemy_spider <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_spider";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemySpider;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemySpider;
		this.m.Icon = "ui/perks/favoured_spider_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSpider;

	}

});

