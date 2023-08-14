this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_blend_in";
		this.m.Name = this.Const.Strings.PerkName.LegendBlendIn;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBlendIn;
		this.m.Icon = "ui/perks/perk_42.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.1;
		_properties.MeleeDefense += 3;
		_properties.RangedDefense += 5;
	}

});

