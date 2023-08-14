this.vampire_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.vampire";
		this.m.Name = "Vampire";
		this.m.Description = "TODO";
		this.m.Icon = "ui/orientation/vampire_01_orientation.png";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_life_drain_01.wav",
			"sounds/enemies/vampire_life_drain_02.wav",
			"sounds/enemies/vampire_life_drain_03.wav"
		];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= 0)
		{
			return;
		}

		local actor = this.m.Container.getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			return;
		}

		this.spawnIcon("status_effect_09", actor.getTile());

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), this.Math.round(_damageInflictedHitpoints * 1.0)) + " points");
		}

		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + this.Math.round(_damageInflictedHitpoints * 1.0)));
		actor.onUpdateInjuryLayer();
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		
		local weapon = _skill.getItem();
		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
		{

			if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
			{
				_properties.DamageReceivedRegularMult *= 1.2;
			}
			if (weapon.getID() == "weapon.goblin_crossbow")
			{
				_properties.DamageReceivedRegularMult *= 2.0;
			}
			if (weapon.getID() == "weapon.legend_wooden_stake")
			{
				_properties.DamageReceivedRegularMult *= 10.0;
			}
			if (weapon.getID() == "weapon.legend_wooden_spear")
			{
				_properties.DamageReceivedRegularMult *= 5.0;
			}
		}

	}
});

