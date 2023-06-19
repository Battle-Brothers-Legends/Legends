this.perk_legend_assassinate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_assassinate";
		this.m.Name = this.Const.Strings.PerkName.LegendAssassinate;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAssassinate; //All effects of this perk are contained within hidden_effect.nut
		this.m.Icon = "ui/perks/assassinate_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

