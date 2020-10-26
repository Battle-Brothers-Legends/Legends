this.zombie_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.zombie_bite";
		this.m.Name = "Wiederganger Bite";
		this.m.Description = "A vicious bite with a 15% increased chance to hit the head. Infects on legendary difficulty";
		this.m.KilledString = "Bitten";
		this.m.Icon = "skills/active_24.png";
		this.m.IconDisabled = "skills/active_24_bw.png";
		this.m.Overlay = "active_24";
		this.m.SoundOnUse = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav",
			"sounds/enemies/zombie_bite_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUpdate( _properties )
	{
		if (this.isUsable())
		{
			if ( _properties.DamageRegularMin < 15)
				{
					_properties.DamageRegularMin = 15;
				}
			if ( _properties.DamageRegularMin < 15)
				{
				_properties.DamageRegularMax = 35;
				}

		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
				_properties.HitChance[this.Const.BodyPart.Head] += 15;
				}
		}
	}

	function onUse( _user, _targetTile )
	{

		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			if (!target.getCurrentProperties().IsImmuneToPoison && "Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary && hp - target.getHitpoints() >= this.Const.Combat.PoisonEffectMinDamage)
				{
					local effect = this.new("scripts/skills/effects/zombie_poison_effect");
					target.getSkills().add(effect);
				}

		return success;
		}
	}

function onDamageDealt( _target, _skill, _hitInfo )
	{
		if (!target.getCurrentProperties().IsImmuneToPoison && "Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.weapon.onDamageDealt(_target, _skill, _hitInfo);

			if (!this.isKindOf(_target, "player") && !this.isKindOf(_target, "human"))
			{
				return;
			}

			if (_target.getHitpoints() > 0)
			{
				return;
			}

			if (_hitInfo.Tile.IsCorpseSpawned && _hitInfo.Tile.Properties.get("Corpse").IsResurrectable)
			{
				local corpse = _hitInfo.Tile.Properties.get("Corpse");
				corpse.Faction = this.Const.Faction.PlayerAnimals;
				corpse.Hitpoints = 1.0;
				corpse.Items = _target.getItems();
				corpse.IsConsumable = false;
				corpse.IsResurrectable = false;
				this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
			}
		}
	}

});

