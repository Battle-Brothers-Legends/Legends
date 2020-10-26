this.legend_piercing_bolt <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_piercing_bolt";
		this.m.Name = "Piercing Bolt";
		this.m.Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them";
		this.m.KilledString = "Pierced";
		this.m.Icon = "skills/PiercingBoltSkill.png";
		this.m.IconDisabled = "skills/PiercingBoltSkill_bw.png";
		this.m.Overlay = "piercing_bolt";
		this.m.SoundOnUse = [
			"sounds/combat/bolt_shot_01.wav",
			"sounds/combat/bolt_shot_02.wav",
			"sounds/combat/bolt_shot_03.wav"
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
			"sounds/combat/bolt_shot_miss_01.wav",
			"sounds/combat/bolt_shot_miss_02.wav",
			"sounds/combat/bolt_shot_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 100;
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
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
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
			text = "If the bolt hits its target, it will continue through and damage any target behind, dealing 50% damage."
		});

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles on even ground, more if shooting downhill"
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] chance to hit, and [color=" + this.Const.UI.Color.NegativeValue + "]-3%[/color] per tile of distance"
		});
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getItem().isLoaded();
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

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Bolts)
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
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
	}


	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);
		this.getItem().setLoaded(false);
		local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
		skillToAdd.setItem(this.getItem());
		this.getContainer().add(skillToAdd);

		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		
		if (!ret)
		{
			return ret
		}

		if (!_targetTile.hasNextTile(dir))
		{
			return ret
		}

		local forwardTile = _targetTile.getNextTile(dir);
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

		this.getContainer().setBusy(true);
		local _targetEntity = forwardTile.getEntity();
		local properties = this.m.Container.buildPropertiesForUse(this, _targetEntity);
		properties.DamageTotalMult *= 0.50;
		local info = {
			Skill = this,
			Container = this.getContainer(),
			User = _user,
			TargetEntity = _targetEntity,
			Properties = properties,
			DistanceToTarget = _user.getTile().getDistanceTo(_targetEntity.getTile())
		};

		this.onScheduledTargetHit(info);
		this.Tactical.EventLog.logEx(this.getName() + " pierces " + this.Const.UI.getColorizedEntityName(target) + " and hits " + this.Const.UI.getColorizedEntityName(_targetEntity));
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
			_properties.RangedSkill += 15;
			_properties.HitChanceAdditionalWithEachTile -= 3;
		}
	}

});
