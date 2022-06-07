this.perk_nine_lives <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		LastFrameUsed = 0,
		MinHP = 11,
		MaxHP = 15,
		RemoveDamageOverTime = true,
		DamageOverTimeSkills = []
	},
	function isSpent()
	{
		return this.m.IsSpent;
	}

	function getLastFrameUsed()
	{
		return this.m.LastFrameUsed;
	}

	function create()
	{
		this.m.ID = "perk.nine_lives";
		this.m.Name = this.Const.Strings.PerkName.NineLives;
		this.m.Description = this.Const.Strings.PerkDescription.NineLives;
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.VeryLast + 10000;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function setSpent( _f )
	{
		if (_f && !this.m.IsSpent)
		{
			if (this.m.MinHP != 11 || this.m.MaxHP != 15)
			{
				this.getContainer().getActor().m.Hitpoints = ::Math.rand(this.m.MinHP, this.m.MaxHP);
				this.getContainer().getActor().setDirty(true);
			}
			foreach (skill in this.m.DamageOverTimeSkills)
			{
				skill.m.SkillType += ::Const.SkillType.DamageOverTime;
			}
			this.m.DamageOverTimeSkills.clear();

			this.onProc();

			this.getContainer().add(this.new("scripts/skills/effects/nine_lives_effect"));
		}

		this.m.IsSpent = _f;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	function onProc()
	{
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.m.RemoveDamageOverTime && _damageHitpoints > this.getContainer().getActor().getHitpoints())
		{
			this.m.DamageOverTimeSkills = this.getContainer().getSkillsByFunction(@(skill) skill.isType(::Const.SkillType.DamageOverTime));
			foreach (skill in this.m.DamageOverTimeSkills)
			{
				skill.m.SkillType -= ::Const.SkillType.DamageOverTime;
			}
		}
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
		this.skill.onCombatFinished();
	}

	function onUpdate( _properties )
	{
		if (this.m.RemoveDamageOverTime && this.m.IsSpent && this.m.LastFrameUsed == this.Time.getFrame())
		{
			this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
		}
		_properties.SurviveWithInjuryChanceMult *= 1.11;
	}

});

