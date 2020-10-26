this.perk_legend_roster_4 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_roster_4";
		this.m.Name = this.Const.Strings.PerkName.LegendRoster4;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRoster4;
		this.m.Icon = "ui/perks/recruit4.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
