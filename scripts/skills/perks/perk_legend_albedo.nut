this.perk_legend_albedo <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_albedo";
		this.m.Name = this.Const.Strings.PerkName.LegendAlbedo;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAlbedo;
		this.m.Icon = "ui/perks/MaxToolsT1.png"; //todo icons	
		this.m.IconDisabled = "ui/perks/MaxToolsT1_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_albedo"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_albedo"));
		}
	}
	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_albedo");
	}

});
