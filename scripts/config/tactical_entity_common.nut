local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

gt.Const.Tactical.Common <- {
	LastAIBehaviorID = "",
	function getRandomPlayerName()
	{
		return this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
	}
	function getRandomPlayerNameFemale()
	{
		return this.Const.Strings.CharacterNamesFemale[this.Math.rand(0, this.Const.Strings.CharacterNamesFemale.len() - 1)];
	}


	function onSpawnFlies( _tile )
	{
		if (_tile != null && _tile.IsCorpseSpawned && _tile.Properties.has("IsSpawningFlies"))
		{
			for( local i = 0; i < this.Const.FliesDecals.len(); i = ++i )
			{
				_tile.spawnDetail(this.Const.FliesDecals[i], this.Const.Tactical.DetailFlag.Corpse, this.Math.rand(0, 1) == 0);
			}
		}
	}

	function kill( _entity )
	{
		_entity.die();
	}

	function getBlockedTiles( _myTile, _targetTile, _myFaction, _visibleOnly = false )
	{
		local dir = _targetTile.getDirectionTo(_myTile);
		local dist = _myTile.getDistanceTo(_targetTile);
		local ret = [];

		if (_targetTile.hasNextTile(dir))
		{
			local newTile = _targetTile.getNextTile(dir);

			if (!newTile.IsEmpty && newTile.Level - _targetTile.Level > -2 && (!_visibleOnly || newTile.IsVisibleForPlayer))
			{
				if (_myTile.getDistanceTo(newTile) > 1 || !(newTile.IsOccupiedByActor && newTile.getEntity().isAlliedWith(_myFaction)))
				{
					ret.push(newTile);
				}
			}
		}

		if (_targetTile.X != _myTile.X && _targetTile.Y != _myTile.Y && this.Math.abs(_targetTile.X - _myTile.X) != this.Math.abs(_targetTile.Y - _myTile.Y))
		{
			local org_dir = dir;
			dir = org_dir + 1 < this.Const.Direction.COUNT ? org_dir + 1 : 0;

			if (_targetTile.hasNextTile(dir))
			{
				local newTile = _targetTile.getNextTile(dir);

				if (!newTile.IsEmpty && newTile.Level - _targetTile.Level > -2 && newTile.getDistanceTo(_myTile) < dist && (!_visibleOnly || newTile.IsVisibleForPlayer))
				{
					if (_myTile.getDistanceTo(newTile) > 1 || !(newTile.IsOccupiedByActor && newTile.getEntity().isAlliedWith(_myFaction)))
					{
						ret.push(newTile);
					}
				}
			}

			dir = org_dir - 1 >= 0 ? org_dir - 1 : this.Const.Direction.COUNT - 1;

			if (_targetTile.hasNextTile(dir))
			{
				local newTile = _targetTile.getNextTile(dir);

				if (!newTile.IsEmpty && newTile.Level - _targetTile.Level > -2 && newTile.getDistanceTo(_myTile) < dist && (!_visibleOnly || newTile.IsVisibleForPlayer))
				{
					if (_myTile.getDistanceTo(newTile) > 1 || !(newTile.IsOccupiedByActor && newTile.getEntity().isAlliedWith(_myFaction)))
					{
						ret.push(newTile);
					}
				}
			}
		}

		return ret;
	}

	function onApplyMiasma( _tile, _entity )
	{
		if (_entity.getFlags().has("undead"))
		{
			return;
		}

		this.Tactical.spawnIconEffect("status_effect_00", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [];

		if (_entity.getFlags().has("human"))
		{
			sounds = [
				"sounds/humans/human_coughing_01.wav",
				"sounds/humans/human_coughing_02.wav",
				"sounds/humans/human_coughing_03.wav",
				"sounds/humans/human_coughing_04.wav"
			];
		}
		else
		{
			sounds = [
				"sounds/enemies/miasma_appears_01.wav",
				"sounds/enemies/miasma_appears_02.wav",
				"sounds/enemies/miasma_appears_03.wav"
			];
		}

		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(5, 10);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
	}

	function onApplyFire( _tile, _entity )
	{
		if (_entity.getCurrentProperties().IsImmuneToFire)
		{
			return;
		}

		this.Tactical.spawnIconEffect("status_effect_116", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [
			"sounds/combat/dlc6/status_on_fire_01.wav",
			"sounds/combat/dlc6/status_on_fire_02.wav",
			"sounds/combat/dlc6/status_on_fire_03.wav"
		];
		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
		local damageMult = 1.0;

		if (_entity.getType() == this.Const.EntityType.Schrat)
		{
			damageMult = 3.0;
		}

		if (_entity.getSkills().hasSkill("racial.skeleton"))
		{
			damageMult = 0.33;
		}

		if (_entity.getSkills().hasSkill("items.firearms_resistance") || _entity.getSkills().hasSkill("racial.serpent"))
		{
			damageMult = 0.66;
		}

		local damage = this.Math.rand(15, 30);
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damage * damageMult;
		hitInfo.DamageArmor = damage;
		hitInfo.DamageDirect = 0.1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		hitInfo.Injuries = this.Const.Injury.Burning;
		hitInfo.IsPlayingArmorSound = false;
		_entity.onDamageReceived(_entity, null, hitInfo);

		if ((!_entity.isAlive() || _entity.isDying()) && !_entity.isPlayerControlled() && (_tile.Properties.Effect == null || _tile.Properties.Effect.IsByPlayer))
		{
			this.updateAchievement("BurnThemAll", 1, 1);
		}
	}

	function onApplySmoke( _tile, _entity )
	{
		if (_entity.isNonCombatant())
		{
			return;
		}

		local smoke = _entity.getSkills().getSkillByID("effects.smoke");

		if (smoke == null)
		{
			_entity.getSkills().add(this.new("scripts/skills/effects/smoke_effect"));
		}
	}

	function checkDrugEffect( _actor )
	{
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		_actor.getFlags().set("PotionLastUsed", time);
		_actor.getFlags().increment("PotionsUsed", 1);
		local currentDrugEffects = _actor.getSkills().getAllSkillsOfType(this.Const.SkillType.DrugEffect);
		local chance = (currentDrugEffects.len() - 1) * 50;

		if (_actor.getBackground() != null && _actor.getBackground().getID() == "background.wildman")
		{
			chance = chance - 10;
		}

		if (_actor.getSkills().hasSkill("trait.strong"))
		{
			chance = chance - 10;
		}

		if (_actor.getSkills().hasSkill("trait.tough"))
		{
			chance = chance - 10;
		}

		if (_actor.getSkills().hasSkill("trait.athletic"))
		{
			chance = chance - 10;
		}

		if (_actor.getSkills().hasSkill("trait.survivor"))
		{
			chance = chance - 10;
		}

		if (_actor.getSkills().hasSkill("trait.fragile"))
		{
			chance = chance + 10;
		}

		if (_actor.getSkills().hasSkill("trait.gluttunous"))
		{
			chance = chance + 10;
		}

		if (_actor.getSkills().hasSkill("trait.old"))
		{
			chance = chance + 10;
		}

		if (_actor.getSkills().hasSkill("trait.spartan"))
		{
			chance = chance + 10;
		}

		if (_actor.getSkills().hasSkill("trait.ailing"))
		{
			chance = chance + 10;
		}

		if (_actor.getSkills().hasSkill("trait.tiny"))
		{
			chance = chance + 10;
		}

		if (this.Math.rand(1, 100) < chance)
		{
			local effect = this.new("scripts/skills/injury/sickness_injury");
			_actor.getSkills().add(effect);
			this.Sound.play("sounds/vomit_01.wav", this.Const.Sound.Volume.Actor);
		}
	}

	function onApplyFirefield( _tile, _entity )
	{
		this.Tactical.spawnIconEffect("fire_circle", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [
				"sounds/combat/fire_01.wav",
				"sounds/combat/fire_02.wav",
				"sounds/combat/fire_03.wav",
				"sounds/combat/fire_04.wav",
				"sounds/combat/fire_05.wav",
				"sounds/combat/fire_06.wav"
			];

		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(10, 20);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
	}

	function onApplyHolyFlame( _tile, _entity )
	{
		this.Tactical.spawnIconEffect("bluefire_circle", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [
				"sounds/combat/fire_01.wav",
				"sounds/combat/fire_02.wav",
				"sounds/combat/fire_03.wav",
				"sounds/combat/fire_04.wav",
				"sounds/combat/fire_05.wav",
				"sounds/combat/fire_06.wav"
			];

		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());

		if (_entity.isNonCombatant() )
		{
			return;
		}

		if (_entity.getFaction() == this.Const.Faction.Player || _entity.getFaction() == this.Const.Faction.Civilian || _entity.getFaction() == this.Const.Faction.NobleHouse)
		{
			local sanctify = _entity.getSkills().getSkillByID("effects.legend_sanctified_effect");
			if (sanctify != null)
			{
				sanctify.onRefresh();
			}
			else if (_entity.getBackground().isCultist())
			{
				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = this.Math.rand(10, 20);
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
			}
			else
			{

				_entity.getSkills().add(this.new("scripts/skills/effects/legend_sanctified_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/legend_prayer_of_life_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/legend_prayer_of_faith_effect"));
			}
		}

		if (_entity.getFaction() == this.Const.Faction.Undead || _entity.getFaction() == this.Const.Faction.Zombies )
		{
			local consecrate = _entity.getSkills().getSkillByID("effects.legend_consecrated_effect");
			if (consecrate != null)
			{
				consecrate.onRefresh();
				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = this.Math.rand(10, 20);
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
			}
			else
			{
				_entity.getSkills().add(this.new("scripts/skills/effects/legend_consecrated_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/holy_water_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/zombie_poison_effect"));
				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = this.Math.rand(10, 20);
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
			}

		}
	}

};

