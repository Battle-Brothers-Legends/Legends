this.shoot_bolt <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 15,
		AdditionalHitChance = -3
	},
	function onItemSet()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	function create()
	{
		this.m.ID = "actives.shoot_bolt";
		this.m.Name = "Shoot Bolt";
		this.m.Description = "A quick pull of the trigger to loose a bolt. Must be reloaded after each shot to be able to fire again.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_17.png";
		this.m.IconDisabled = "skills/active_17_sw.png";
		this.m.Overlay = "active_17";
		this.m.SoundOnUse = [
			"sounds/combat/bolt_shot_01.wav",
			"sounds/combat/bolt_shot_02.wav",
			"sounds/combat/bolt_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bolt_shot_hit_01.wav",
			"sounds/combat/bolt_shot_hit_02.wav",
			"sounds/combat/bolt_shot_hit_03.wav"
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
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.45;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
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

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.7 : 0.5;
		this.m.AdditionalAccuracy = 15 + this.m.Item.getAdditionalAccuracy();
	}

	function onUse( _user, _targetTile )
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);
		local skillToAdd = this.new("scripts/skills/actives/reload_bolt");
		skillToAdd.setItem(this.getItem());
		skillToAdd.setFatigueCost(this.Math.max(0, skillToAdd.getFatigueCostRaw() + this.getItem().m.FatigueOnSkillUse));
		this.getContainer().add(skillToAdd);
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.reload_bolt");
	}

});

