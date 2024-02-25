this.zombie_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.zombie_bite";
		this.m.Name = "Wiederganger Bite";
		this.m.Description = "A vicious bite with a 15% increased chance to hit the head. Infects on legendary difficulty. Will revive humanoid enemies as allied Wiedergangers if dealt as a killing blow.";
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
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+2;
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

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			if (!target.getCurrentProperties().IsImmuneToPoison && ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary && hp - target.getHitpoints() >= this.Const.Combat.PoisonEffectMinDamage)
			{
				local effect = this.new("scripts/skills/effects/zombie_poison_effect");
				target.getSkills().add(effect);
			}

			return success;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local items = this.m.Container.getActor().getItems();
			local mhand = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
				_properties.DamageDirectAdd -= mhand.m.DirectDamageAdd;
			}

			_properties.DamageRegularMin += 15;
			_properties.DamageRegularMax += 35;
			_properties.DamageArmorMult = 0.5;
			_properties.HitChance[this.Const.BodyPart.Head] += 15;
			
			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (_skill != this)
		{
			return;
		}

		if (!this.isKindOf(_targetEntity, "player") && !this.isKindOf(_targetEntity, "human"))
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!this.isKindOf(actor.get(), "player"))
		{
			return;
		}

		if (_targetEntity.getTile().IsCorpseSpawned && _targetEntity.getTile().Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _targetEntity.getTile().Properties.get("Corpse");
			corpse.Faction = actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction();
			corpse.Hitpoints = 1.0;
			corpse.Items = _targetEntity.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
		}
	}

	function canDoubleGrip()
	{
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return main != null && off == null && main.isDoubleGrippable();
	}
});

