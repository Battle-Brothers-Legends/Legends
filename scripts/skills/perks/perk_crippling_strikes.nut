this.perk_crippling_strikes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crippling_strikes";
		this.m.Name = this.Const.Strings.PerkName.CripplingStrikes;
		this.m.Description = this.Const.Strings.PerkDescription.CripplingStrikes;
		this.m.Icon = "ui/perks/perk_16.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToInflictInjuryMult *= 0.66;

	}

	
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (!_targetEntity.m.BaseProperties.IsAffectedByInjuries)
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

});

					