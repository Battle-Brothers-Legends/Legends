this.legend_manticore_sting <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_manticore_sting";
		this.m.Name = "Sting";
		this.m.Description = "";
		this.m.KilledString = "Stung";
		this.m.Icon = "skills/active_146.png";
		this.m.Overlay = "active_146";
		this.m.SoundOnUse = [
			"sounds/enemies/Manticore_sting.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
	}

	function onUpdate( _properties )
	{
		_properties.DamageRegularMin += 70;
		_properties.DamageRegularMax += 110;
		_properties.DamageArmorMult *= 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && !target.isDying())
		{
			if (!target.getCurrentProperties().IsImmuneToPoison && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				target.getSkills().add(this.new("scripts/skills/effects/spider_poison_effect"));
			}
		}

		return success;
	}

});

