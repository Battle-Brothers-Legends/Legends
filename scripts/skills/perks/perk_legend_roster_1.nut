this.perk_legend_roster_1 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_roster_1";
		this.m.Name = this.Const.Strings.PerkName.LegendRoster1;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRoster1;
		this.m.Icon = "ui/perks/recruit1.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});
