this.perk_legend_roster_2 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_roster_2";
		this.m.Name = this.Const.Strings.PerkName.LegendRoster2;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRoster2;
		this.m.Icon = "ui/perks/recruit2.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
