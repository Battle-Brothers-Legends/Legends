this.perk_legend_wolfform <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_wolfform";
		this.m.Name = this.Const.Strings.PerkName.LegendWolfform;
		this.m.Description = this.Const.Strings.PerkDescription.LegendWolfform;
		this.m.Icon = "ui/perks/wolf_circle.png";
		this.m.IconDisabled = "ui/perks/wolf_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_transform_into_wolf"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_transform_into_wolf_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_transform_into_wolf");
	}

});
