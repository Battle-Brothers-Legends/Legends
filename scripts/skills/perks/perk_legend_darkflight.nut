this.perk_legend_darkflight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_darkflight";
		this.m.Name = this.Const.Strings.PerkName.LegendDarkflight;
		this.m.Description = this.Const.Strings.PerkDescription.LegendDarkflight;
		this.m.Icon = "ui/perks/darkflight_circle.png";
		this.m.IconDisabled = "ui/perks/darkflight_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_darkflight"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_darkflight"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_darkflight");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});
