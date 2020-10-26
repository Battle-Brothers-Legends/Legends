this.perk_legend_roster_7 <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_roster_7";
		this.m.Name = this.Const.Strings.PerkName.LegendRoster7;
		this.m.Description = this.Const.Strings.PerkDescription.LegendRoster7;
		this.m.Icon = "ui/perks/recruit7.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
