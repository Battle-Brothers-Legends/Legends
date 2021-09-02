this.perk_legend_poison_immunity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_poison_immunity";
		this.m.Name = this.Const.Strings.PerkName.LegendPoisonImmunity;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPoisonImmunity;
		this.m.Icon = "ui/perks/poison_immunity.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});