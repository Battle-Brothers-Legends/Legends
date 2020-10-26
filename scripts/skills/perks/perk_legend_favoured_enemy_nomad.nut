this.perk_legend_favoured_enemy_nomad <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_nomad";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemyNomad;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemyNomad;
		this.m.Icon = "ui/perks/favoured_nomad_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteNomads;
	}

});

