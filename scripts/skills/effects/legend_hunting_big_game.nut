this.legend_hunting_big_game <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_hunting_big_game";
		this.m.Name = "Hunting big game";
		this.m.Icon = "ui/perks/BigGameHunterPerk.png";
		this.m.IconMini = "mini_big_game_hunter";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = false;
	}

	function getDescription()
	{
		return "if an enemy has more health than you, gain % damage equal to their health divided by your health. So if an enemy has 1,000 health, and you have 100 health, you would gain +10% damage. If you have 10 health, gain +100% damage. If you have 1 health, gain +1000% damage.";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return
		}
	
		local actor = this.getContainer().getActor();
		local targetHP = _targetEntity.getHitpoints()
		local ourHP =  actor.getHitpoints();
		local ratio = targetHP / ourHP.tofloat();
		if (ratio > 1.0)
		{
			_properties.DamageRegularMult *= 1.0 + ratio * 0.01; 
		}
	}
});
