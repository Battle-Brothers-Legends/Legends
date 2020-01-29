this.puncture <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.puncture";
		this.m.Name = "Puncture";
		this.m.Description = "A well-placed attack at the opponent armor\'s weakspots. Ignores all armor but is harder to hit with and can not land critical hits for additional damage, nor inflict additional damage with double grip.";
		this.m.KilledString = "Stabbed";
		this.m.Icon = "skills/active_27.png";
		this.m.IconDisabled = "skills/active_27_sw.png";
		this.m.Overlay = "active_27";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Hit chance determined by your targets fatigue, 0% if they are fresh and 100% if they are exhausted. If your target is dazed or parried hitchance is increaded by +10%.  If they are stunned or netted you gain +25%. If they are grappled or sleeping you gain +50%. Dagger mastery doubles your chance to hit. These bonuses stack up to 100%.  "
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			}
		]);
		return ret;
	}

	function canDoubleGrip()
	{
		local missinghand = this.m.Container.getSkillByID("injury.missing_hand");
		local newhand = this.m.Container.getSkillByID("trait.legend_prosthetic_hand");
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return (missinghand == null || newhand != null) && main != null && off == null && main.isDoubleGrippable();
	}

	function getHitChance(_targetEntity)
	{
		if (_targetEntity == null)
		{
			return 0;
		}
		local mod = 0;
		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
		mod += 0.1;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
		mod += 0.1;
		}
		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
		mod += 0.5;
		}
		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
		mod += 0.25;
		}
		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
		mod += 0.5;
		}
		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
		mod += 0.25;
		}
        if (_targetEntity.getFaction() == this.Const.Faction.Player )
		{
			mod += 0.75;
		}
		local chance = _targetEntity.getFatiguePct();
		return (chance + mod);
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local chance = this.getHitChance(_targetEntity)
			if (_properties.IsSpecializedInDaggers)
			{
				chance = this.Math.floor(chance * 1.5)
			}
			local bonus = chance * _properties.MeleeSkill;
			_properties.MeleeSkill = bonus;
			_properties.DamageArmorMult *= 0.0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}

});

