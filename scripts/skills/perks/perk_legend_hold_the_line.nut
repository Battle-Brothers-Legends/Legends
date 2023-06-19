this.perk_legend_hold_the_line <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_hold_the_line";
		this.m.Name = this.Const.Strings.PerkName.LegendHoldTheLine;
		this.m.Description = this.Const.Strings.PerkDescription.LegendHoldTheLine;
		this.m.Icon = "ui/perks/holdtheline_circle.png";
		this.m.IconDisabled = "ui/perks/holdtheline_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_hold_the_line"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_hold_the_line"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_hold_the_line");
	}

});

