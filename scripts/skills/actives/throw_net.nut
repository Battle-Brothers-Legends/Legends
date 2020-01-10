this.throw_net <- this.inherit("scripts/skills/skill", {
	m = {
		IsReinforced = false
	},
	function setReinforced( _r )
	{
		this.m.IsReinforced = _r;
	}

	function create()
	{
		this.m.ID = "actives.throw_net";
		this.m.Name = "Throw Net";
		this.m.Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively. Will always hit if the enemy isn\'t immune.";
		this.m.Icon = "skills/active_73.png";
		this.m.IconDisabled = "skills/active_73_sw.png";
		this.m.Overlay = "active_73";
		this.m.SoundOnUse = [
			"sounds/combat/throw_net_01.wav",
			"sounds/combat/throw_net_02.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] tiles"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local r = this.Math.rand(1,100);
		if (_user.getSkills().hasSkill("perk.legend_net_casting"));
		{
		local r = this.Math.rand(1,50);
		}
		local ourSkill = _user.getCurrentProperties().getRangedSkill();
		local theirSkill = targetEntity.getCurrentProperties().getRangedDefense();

		if (r < (ourSkill - theirSkill))
		{
			if (!targetEntity.getCurrentProperties().IsImmuneToRoot)
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
				}

				_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));

				targetEntity.getSkills().add(this.new("scripts/skills/effects/net_effect"));
				local breakFree = this.new("scripts/skills/actives/break_free_skill");
				breakFree.m.Icon = "skills/active_74.png";
				breakFree.m.IconDisabled = "skills/active_74_sw.png";
				breakFree.m.Overlay = "active_74";
				breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

				if (this.m.IsReinforced)
				{
					breakFree.setDecal("net_destroyed_02");
					breakFree.setChanceBonus(-15);
					this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));	
				}
				else
				{
					breakFree.setDecal("net_destroyed");
					breakFree.setChanceBonus(0);
					local chance = this.Math.rand(1,100);
					if (chance > 50)
					{
						this.World.Assets.getStash().add(this.new("scripts/items/tools/legend_broken_throwing_net"));
					}
				}

				targetEntity.getSkills().add(breakFree);
				local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
				local flip = !targetEntity.isAlliedWithPlayer();
				effect.setHorizontalFlipping(flip);
				this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
					TargetEntity = targetEntity,
					IsReinforced = this.m.IsReinforced
				});
			}
			else
			{
				if (this.m.SoundOnMiss.len() != 0)
				{
					this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
				}

				_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				if (this.m.IsReinforced)
				{
				this.World.Assets.getStash().add(this.new("scripts/items/tools/reinforced_throwing_net"));
				}
				else
				{
				this.World.Assets.getStash().add(this.new("scripts/items/tools/throwing_net"));
				}

				return false;
			}	
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				if (this.m.IsReinforced)
				{
				this.World.Assets.getStash().add(this.new("scripts/items/tools/reinforced_throwing_net"));
				}
				else
				{
				this.World.Assets.getStash().add(this.new("scripts/items/tools/throwing_net"));
				}

			return false;
		}	

	}

	function onNetSpawn( _data )
	{
		local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush(_data.IsReinforced ? "bust_net_02" : "bust_net");
		rooted.Visible = true;
		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush(_data.IsReinforced ? "bust_net_back_02" : "bust_net_back");
		rooted_back.Visible = true;
		_data.TargetEntity.setDirty(true);
	}

});

