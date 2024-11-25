this.perk_legend_cheer_on <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_cheer_on";
		this.m.Name = this.Const.Strings.PerkName.LegendCheerOn;
		this.m.Description = this.Const.Strings.PerkDescription.LegendCheerOn;
		this.m.Icon = "ui/perks/cheered_on_circle.png";
		this.m.IconDisabled = "ui/perks/cheered_on_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_cheer_on_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_cheer_on_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_cheer_on_skill");
	}



});

