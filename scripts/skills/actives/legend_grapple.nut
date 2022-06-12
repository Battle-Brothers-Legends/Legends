this.legend_grapple <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 50
	},
	function setStunChance( _c )
	{
		this.m.StunChance = _c;
	}

	function create()
	{
		this.m.ID = "actives.legend_grapple";
		this.m.Name = "Grapple";
		this.m.Description = "Grab hold and restrain a target, heavily fatiguing them. Grappled targets can not keep up their Shieldwall, Spearwall or similar defensive skills. One hand must be free to use.";
		this.m.Icon = "skills/grapple_square.png";
		this.m.IconDisabled = "skills/grapple_square_bw.png";
		this.m.Overlay = "active_32";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
	}

	function getStunChance()
	{
		local ret = {
			StunChance = 50,
			HasOffhand = false,
			HasMainhand = false,
			HasTraining = false
		};
		ret.StunChance = this.m.StunChance;
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (mainhand != null)
		{
			ret.StunChance -= 25;
			ret.HasMainhand = true;
		}

		if (offhand != null)
		{
			ret.StunChance -= 25;
			ret.HasOffhand = true;
		}

		if (this.m.Container.getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.StunChance += 50;
			ret.HasTraining = true;
		}

		return ret;
	}

	function getTooltip()
	{
		local chance = this.getStunChance();
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 8 + "[/color] fatigue on an enemy"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + chance.StunChance + "% chance to stun"
		});

		if (chance.HasTraining)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] chance to grapple on a hit due to unarmed mastery"
			});
		}

		if (chance.HasMainhand || chance.HasOffhand)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] chance to grapple on a hit due to holding stuff in a hand"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInFists ? 3 : 4;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
			{
				return success;
			}

			if (target.getSkills().hasSkill("effects.legend_grappled"))
			{
				return success;
			}

			local mods = this.getStunChance();
			if (_user.getCurrentProperties().IsSpecializedInFists || this.Math.rand(1, 100) <= mods.StunChance)
			{
				target.getSkills().add(this.new("scripts/skills/effects/legend_grappled_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has grappled " + this.Const.UI.getColorizedEntityName(target) + " for two turns");
				}
			}
		}

		return success;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return ((offhand == null || mainhand == null) || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return mainhand != null && offhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.2;
			_properties.FatigueDealtPerHitMult += 8.0;
		}
	}

});

