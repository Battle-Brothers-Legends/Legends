this.perk_legend_surpress_urges <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_surpress_urges";
		this.m.Name = this.Const.Strings.PerkName.LegendSurpressUrges;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSurpressUrges;
		this.m.Icon = "ui/perks/surpress_urges.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
