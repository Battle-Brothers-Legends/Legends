this.spider_eggs <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Count = 0
	},
	function create()
	{
		this.m.IsActingEachTurn = false;
		this.m.IsNonCombatant = true;
		this.m.IsShakingOnHit = false;
		this.m.Type = this.Const.EntityType.SpiderEggs;
		this.m.BloodType = this.Const.BloodType.None;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.SpiderEggs.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc2/giant_spider_egg_spawn_01.wav",
			"sounds/enemies/dlc2/giant_spider_egg_spawn_02.wav",
			"sounds/enemies/dlc2/giant_spider_egg_spawn_03.wav",
			"sounds/enemies/dlc2/giant_spider_egg_spawn_04.wav"
		];
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("ScrambledEggs", 1, 1);
		}

		local flip = this.Math.rand(0, 100) < 50;

		if (_tile != null)
		{
			_tile.spawnDetail("nest_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			this.spawnTerrainDropdownEffect(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SpiderEggs);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local flip = this.Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("nest_01");
		body.setHorizontalFlipping(flip);
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.update();
	}

	function onPlacedOnMap()
	{
		this.actor.onPlacedOnMap();
		this.registerSpawnEvent();
	}

	function registerSpawnEvent()
	{
		this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 2), this.onSpawn.bindenv(this), this.getTile());
	}

	function onSpawn( _tile )
	{
		if (_tile.IsEmpty)
		{
			return;
		}

		if (!_tile.IsOccupiedByActor || _tile.getEntity().getType() != this.Const.EntityType.SpiderEggs)
		{
			return;
		}

		if (this.Tactical.Entities.isEnemyRetreating())
		{
			return;
		}

		local tile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _tile.getNextTile(i);

				if (!nextTile.IsEmpty || this.Math.abs(nextTile.Level - _tile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					break;
				}
			}
		}

		if (tile != null)
		{
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", tile.Coords);
			spawn.setSize(this.Math.rand(60, 75) * 0.01);
			spawn.setFaction(this.getFaction());
			spawn.m.XP = spawn.m.XP / 2;
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			foreach( a in allies )
			{
				if (a.getType() == this.Const.EntityType.Hexe)
				{
					spawn.getSkills().add(this.new("scripts/skills/effects/fake_charmed_effect"));
					break;
				}
			}

			++this.m.Count;
		}

		if (this.m.Count < 4)
		{
			this.registerSpawnEvent();
		}
		else
		{
			this.killSilently();
		}
	}

});

