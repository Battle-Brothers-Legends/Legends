this.perk_legend_bloody_harvest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_bloody_harvest";
		this.m.Name = this.Const.Strings.PerkName.LegendBloodyHarvest;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBloodyHarvest;
		this.m.Icon = "ui/perks/perk_14.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	 
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAOE() && _skill.isAttack())
		{
			_properties.MeleeSkill += 10;
		}
	}

});

