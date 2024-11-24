this.perk_legend_sprint <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_sprint";
		this.m.Name = this.Const.Strings.PerkName.LegendSprint;
		this.m.Description = this.Const.Strings.PerkDescription.LegendLegendSprint;
		this.m.Icon = "ui/perks/perk_sprint.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_sprint_skill_5"));
		}
	}

});

