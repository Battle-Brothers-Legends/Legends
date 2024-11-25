this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_perfect_focus";
		this.m.Name = this.Const.Strings.PerkName.LegendPerfectFocus;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPerfectFocus;
		this.m.Icon = "ui/perks/perfectfocus_circle.png";
		this.m.IconDisabled = "ui/perks/perfectfocus_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.perfect_focus"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/perfect_focus"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.perfect_focus");
	}

});
