this.cascade_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.cascade";
		this.m.Name = "Cascade";
		this.m.Description = "Let loose a cascade of three striking heads on your opponent. Will strike over or around shield cover.";
		this.m.KilledString = "Smashed";
		this.m.Icon = "skills/active_125.png";
		this.m.IconDisabled = "skills/active_125_sw.png";
		this.m.Overlay = "active_125";
		this.m.SoundOnUse = [
			"sounds/combat/flail_01.wav",
			"sounds/combat/flail_02.wav",
			"sounds/combat/flail_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/flail_hit_01.wav",
			"sounds/combat/flail_hit_02.wav",
			"sounds/combat/flail_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = false;
		this.m.IsWeaponSkill = true;
		this.m.Delay = 250;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will make three separate strikes for half of the weapon\'s damage each"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Ignores the bonus to Melee Defense granted by shields"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);

		if (!target.isAlive()) //very rarely something will die to a cascade due to an AOO this should fix it
		{
			return ret;
		}

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.attackEntity(_user, target);
				}
			}.bindenv(this), this);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.attackEntity(_user, target);
				}

				_skill.m.IsDoingAttackMove = true;
				_skill.getContainer().setBusy(false);
			}.bindenv(this), this);
			return true;
		}
		else
		{
			if (target.isAlive())
			{
				ret = this.attackEntity(_user, target) || ret;
			}

			if (target.isAlive())
			{
				ret = this.attackEntity(_user, target) || ret;
			}

			return ret;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
		}
	}

});
