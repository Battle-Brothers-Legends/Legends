this.perk_legend_favoured_enemy_ifrit <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_ifrit";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyIfrit;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyIfrit;
		this.m.Icon = "ui/perks/favoured_ifrit_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteIfrits;
	}

});

