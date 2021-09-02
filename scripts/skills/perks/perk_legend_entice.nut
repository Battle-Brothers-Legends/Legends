this.perk_legend_entice <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_entice";
		this.m.Name = this.Const.Strings.PerkName.LegendEntice;
		this.m.Description = this.Const.Strings.PerkDescription.LegendEntice;
		this.m.Icon = "skills/entice_circle_56.png";
		this.m.IconDisabled = "ui/perks/entice_circle_56_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_entice"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_entice"));
		}
	}
	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_entice");
	}

});
