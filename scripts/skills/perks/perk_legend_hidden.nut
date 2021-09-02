this.perk_legend_hidden <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_hidden";
		this.m.Name = this.Const.Strings.PerkName.LegendHidden;
		this.m.Description = this.Const.Strings.PerkDescription.LegendHidden;
		this.m.Icon = "ui/perks/hidden.png";
		this.m.IconDisabled = "ui/perks/hidden_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_hidden"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_hidden_skill"));
		}
	}
	
	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_hidden");
	}

});
