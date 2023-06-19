this.perk_legend_knifeplay <- this.inherit("scripts/skills/skill", {
	m = {},
	
	function create()
	{
		this.m.ID = "perk.legend_knifeplay";
		this.m.Name = this.Const.Strings.PerkName.LegendKnifeplay;
		this.m.Description = this.Const.Strings.PerkDescription.LegendKnifeplay;
		this.m.Icon = "ui/perks/knifeplay.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_throw_knife"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_throw_knife"));
		}
	}


});

