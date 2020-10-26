this.disintegrating_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2,
		Damage = 10,
		LastRoundApplied = 0,
		Actor = null
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function setActor( _a )
	{
		this.m.Actor = (typeof _a == "instance" ? _a.get() : _a);	
	}

	function create()
	{
		this.m.ID = "effects.disintegrating";
		this.m.Name = "Disintegrating";
		this.m.KilledString = "Disintegrated";
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Overlay = "bleed";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is wearing away and falling apart they will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getAttacker()
	{
		if (!this.World.LegendsMod.Configs().LegendBleedKillerEnabled())
		{
			return this.getContainer().getActor();
		}

		if (this.m.Actor == null )
		{
			return this.getContainer().getActor();
		}

		if (this.m.Actor != this.getContainer().getActor())
		{
			if (typeof this.m.Actor == "instance")
			{
				this.m.Actor = this.m.Actor.get();
			}
			// Must be alive to get the credit, to stop crashes
			if (!this.m.Actor.isAlive())
			{
				return this.getContainer().getActor();
			}


			// If Swallowed and not on the map, can't be counted for bleed kills, it crashes the game
			 if (this.m.Actor.isPlacedOnMap())
			 {
		 		return this.getContainer().getActor();
			 }

			 if (this.m.Actor.getFlags().get("Devoured") == true)
			 {
		 		return this.getContainer().getActor();
			 }
		}

		return this.m.Actor;
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getAttacker(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasSkill("trait.bleeder"))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

