this.perk_legend_tackle <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_tackle";
		this.m.Name = this.Const.Strings.PerkName.LegendTackle;
		this.m.Description = this.Const.Strings.PerkDescription.LegendTackle;
		this.m.Icon = "ui/perks/tackle_circle.png";
		this.m.IconDisabled = "ui/perks/tackle_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_tackle"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_tackle"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_tackle");
	}

});

