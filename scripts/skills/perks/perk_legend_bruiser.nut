this.perk_legend_bruiser <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_bruiser";
		this.m.Name = this.Const.Strings.PerkName.LegendBruiser;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBruiser;
		this.m.Icon = "skills/passive_03.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.DamageArmorMult += 0.1;
	}

});


