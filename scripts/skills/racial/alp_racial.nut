this.alp_racial <- this.inherit("scripts/skills/skill", {
	m = {
		TimesWaited = 0
	},
	function create()
	{
		this.m.ID = "racial.alp";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "skills/status_effect_81.png";
		this.m.SoundOnUse = [
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		this.m.TimesWaited = 0;
	}

	function onResumeTurn()
	{
		if (++this.m.TimesWaited <= 1 && this.getContainer().getActor().getActionPoints() >= 4)
		{
			this.getContainer().getActor().setWaitActionSpent(false);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot")
		{
			_properties.DamageReceivedRegularMult *= 0.1;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone")
		{
			_properties.DamageReceivedRegularMult *= 0.33;
		}
		else if (_skill.getID() == "actives.throw_javelin")
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.lunge" || _skill.getID() == "actives.fire_handgonne" || _skill.getID() == "actives.throw_spear")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
		else if (_skill.getID() == "actives.wardog_bite" || _skill.getID() == "actives.wolf_bite" || _skill.getID() == "actives.warhound_bite")
		{
			_properties.DamageReceivedRegularMult *= 0.33;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();

		if (_damageHitpoints >= actor.getHitpoints())
		{
			return;
		}

		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 30, this.teleport.bindenv(this), null);
	}

	function onDeath( _fatalityType )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 30, this.teleport.bindenv(this), null);
	}

	function teleport( _tag )
	{
		local allies = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in allies )
		{
			if (a.getHitpoints() > 0 && a.getType() == this.Const.EntityType.Alp)
			{
				local b = a.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AlpTeleport);
				b.onEvaluate(a);
				b.onExecute(a);
			}
		}
	}

});

