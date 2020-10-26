this.legend_piercing_shot <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 20,
		AdditionalHitChance = 0
	},
	function create()
	{
		this.m.ID = "actives.legend_piercing_shot";
		this.m.Name = "Piercing Shot";
		this.m.Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them";
		this.m.KilledString = "Pierced";
		this.m.Icon = "skills/PiercingBoltSkill.png";
		this.m.IconDisabled = "skills/PiercingBoltSkill_bw.png";
		this.m.Overlay = "piercing_bolt";
		this.m.SoundOnUse = [
			"sounds/combat/aimed_shot_01.wav",
			"sounds/combat/aimed_shot_02.wav",
			"sounds/combat/aimed_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/split_hit_01.wav",
			"sounds/combat/split_hit_02.wav",
			"sounds/combat/split_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];		
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 1000;		
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;		
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 8;		
		this.m.ChanceDecapitate = 10;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the arrow hits its target, it will continue through and damage any target behind, dealing 50% damage."
		});

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles on even ground, more if shooting downhill"
		});

		if (this.m.AdditionalAccuracy >= 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit, and [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] per tile of distance"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] chance to hit, and [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] per tile of distance"
			});
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}
		return ret;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return true;
		}

		if (!actor.getSkills().hasSkill("perk.legend_piercing_shot"))
		{
			return true;
		}

		return false;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Arrows)
		{
			return item.getAmmo();
		}
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() - 1 + (_properties.IsSpecializedInBows ? 1 : 0);
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.consumeAmmo();
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);

			this.Time.scheduleEvent(this.TimeUnit.Virtual, this.m.Delay, this.onPerformAttack, tag);

			if (!_user.isPlayerControlled() && _targetTile.getEntity().isPlayerControlled())
			{
				_user.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}
			return true;
		}

		return this.onPerformAttack(tag);
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.spawnAttackEffect(_tag.TargetTile, this.Const.Tactical.AttackEffectSplit);		
		_tag.Skill.getContainer().setBusy(false);
		local ret = _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
		local ownTile = _tag.User.getTile();
		local dir = ownTile.getDirectionTo(_tag.TargetTile);

		if (!ret)
		{
			return ret
		}

		if (!_tag.TargetTile.hasNextTile(dir))
		{
			return ret
		}

		local forwardTile = _tag.TargetTile.getNextTile(dir);
		if (!forwardTile.IsOccupiedByActor)
		{
			return ret
		}

		if (!forwardTile.getEntity().isAttackable())
		{
			return ret
		}
		
		if (this.Math.abs(forwardTile.Level - ownTile.Level) > 1)
		{
			return ret
		}

		_tag.Skill.getContainer().setBusy(true);
		local _targetEntity = forwardTile.getEntity();
		local properties = _tag.Skill.m.Container.buildPropertiesForUse(_tag.Skill, _targetEntity);
		properties.DamageTotalMult *= 0.50;
		local info = {
			Skill = _tag.Skill,
			Container = _tag.Skill.getContainer(),
			User = _tag.User,
			TargetEntity = _targetEntity,
			Properties = properties,
			DistanceToTarget = _tag.User.getTile().getDistanceTo(_targetEntity.getTile())
		};

		_tag.Skill.onScheduledTargetHit(info);
		this.Tactical.EventLog.logEx(_tag.Skill.getName() + " pierces " + this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + " and hits " + this.Const.UI.getColorizedEntityName(_targetEntity));
		return ret
	}

	function onTargetSelected( _targetTile )
	{
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - ownTile.Level) <= 1)
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, forwardTile, forwardTile.Pos.X, forwardTile.Pos.Y);
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -4 + this.m.AdditionalHitChance;
		}
	}

});
