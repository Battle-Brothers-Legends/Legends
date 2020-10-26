this.vengeance_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.vengeance";
		this.m.Name = "Vengeance!";
		this.m.Icon = "skills/vengeance_square.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Having just received a blow, this character is determined to fight even harder! The next attack will inflict double damage to a single target. If multiple targets are hit, only the first one will receive increased damage. If the attack misses, the effect is wasted.";
	}
	
	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 2.0;
	}	

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		} 

		if (!this.m.IsGarbage && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			this.removeSelf();
		}
	}

});

