this.perk_legend_forceful_swing<- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_forceful_swing";
		this.m.Name = this.Const.Strings.PerkName.LegendForcefulSwing;
		this.m.Description = this.Const.Strings.PerkDescription.LegendForcefulSwing;
		this.m.Icon = "ui/perks/perk_14.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	 

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isRanged())
		{
			 return;
		}
		if (_skill.isAOE() && _skill.isAttack())
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

});

