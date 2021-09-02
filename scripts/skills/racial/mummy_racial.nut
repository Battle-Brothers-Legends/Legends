this.mummy_racial <- this.inherit("scripts/skills/skill", {
	m = {
		Killer = null
	},
	function create()
	{
		this.m.ID = "racial.mummy";
		this.m.Name = "Resistant to Ranged Attacks";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot"  || _skill.getID() == "actives.legend_cascade"  || _skill.getID() == "actives.legend_siphon_skill")
		{
			_properties.DamageReceivedRegularMult *= 0.2;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.legend_piercing_shot" || _skill.getID() == "actives.fire_handgonne")
		{
			_properties.DamageReceivedRegularMult *= 0.66;
		}
		else if (_skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.legend_magic_missile" || _skill.getID() == "actives.ignite_firelance")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.lunge")
		{
			_properties.DamageReceivedRegularMult *= 0.75;
		}

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			_properties.DamageReceivedRegularMult *= 0.75;
		}

	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor)
	{
		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			this.m.Killer = _attacker;
		}
	}

	function onDeath()
	{
		this.skill.onDeath();
		if (this.m.Killer != null)
		{
			this.m.Killer.getSkills().add(this.new("scripts/skills/effects/mummy_curse_effect"));
		}
	}	

});
