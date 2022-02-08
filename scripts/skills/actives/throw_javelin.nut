this.throw_javelin <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 20,
		AdditionalHitChance = -10,
		SoundOnMissTarget = [
			"sounds/combat/javelin_miss_01.wav",
			"sounds/combat/javelin_miss_02.wav",
			"sounds/combat/javelin_miss_03.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.throw_javelin";
		this.m.Name = "Throw Javelin";
		this.m.Description = "Hurl a javelin at a target. Can not be used while engaged in melee.";
		this.m.KilledString = "Impaled";
		this.m.Icon = "skills/active_43.png";
		this.m.IconDisabled = "skills/active_43_sw.png";
		this.m.Overlay = "active_43";
		this.m.SoundOnUse = [
			"sounds/combat/javelin_throw_01.wav",
			"sounds/combat/javelin_throw_02.wav",
			"sounds/combat/javelin_throw_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/javelin_hit_01.wav",
			"sounds/combat/javelin_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 0;
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
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Javelin;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.SoundOnMissTarget )
		{
			this.Tactical.addResource(r);
		}
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
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] javelins left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]No javelins left[/color]"
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

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = 20 + this.m.Item.getAdditionalAccuracy();
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local ret = this.attackEntity(_user, target);
		this.consumeAmmo();

		if (!ret && this.m.SoundOnMissTarget.len() != 0)
		{
			this.Sound.play(this.m.SoundOnMissTarget[this.Math.rand(0, this.m.SoundOnMissTarget.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			if (_properties.IsSpecializedInSpearThrust)
			{
				this.m.AdditionalHitChance += 10;
			}
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
			
		}
	}

});

