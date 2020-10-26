this.perk_legend_roster_3 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_roster_3";
		this.m.Name = this.Const.Strings.PerkName.LegendRoster3;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRoster3;
		this.m.Icon = "ui/perks/recruit3.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
