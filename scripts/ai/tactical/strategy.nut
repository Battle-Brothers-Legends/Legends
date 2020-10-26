this.strategy <- {
	m = {
		Faction = 0,
		KnownOpponents = [],
		AveragePlayerLevel = 0,
		AveragePlayerArmor = 0,
		Stats = {
			AlliesVSEnemiesRatio = 1.0,
			EnemiesVSAlliesRatio = 1.0,
			RangedAlliedVSEnemies = 1.0,
			DefensiveAllies = 0.0,
			DefensiveEnemies = 0.0,
			DefensiveAlliesRatio = 0.0,
			DefensiveEnemiesRatio = 0.0,
			DefensiveBiasAverage = 0.0,
			EngagedAlliesRatio = 0.0,
			FleeingAlliesRatio = 0.0,
			FleeingEnemiesRatio = 0.0,
			EnemyRangedReadyRatio = 0.0,
			AllyRangedReadyRatio = 0.0,
			AllyVSEnemyOutrange = 0.0,
			EnemyOutranging = 0,
			AllyOutranging = 0,
			EnemyRangedFiring = 0,
			AllyRangedFiring = 0,
			AllyRangedTotal = 0,
			EnemyRangedTotal = 0,
			ShortestDistanceToEnemy = 0,
			ShortestDistanceToEnemyNotMoved = 0,
			LongestDistanceToEnemy = 0,
			IsOutrangedByEnemy = false,
			IsOutrangingEnemy = false,
			IsEngaged = false,
			IsOwnFactionEngaged = false,
			IsBeingKited = false
		},
		IsDefending = false,
		IsEscortedByPlayer = false,
		IsDelayedAttack = false,
		IsOffensiveLastTurn = false,
		IsAttackingOnWorldmap = false
	},
	function setFaction( _f )
	{
		this.m.Faction = _f;
	}

	function setIsAttackingOnWorldmap( _f )
	{
		this.m.IsAttackingOnWorldmap = _f;
	}

	function getAlliesRanged()
	{
		return this.m.AlliedRanged;
	}

	function getAlliesMelee()
	{
		return this.m.AlliesMelee;
	}

	function getEnemiesRanged()
	{
		return this.m.EnemiesRanged;
	}

	function getEnemiesMelee()
	{
		return this.m.EnemiesMelee;
	}

	function getAllyVSEnemyRange()
	{
		return this.m.AllyVSEnemyRange;
	}

	function getStats()
	{
		return this.m.Stats;
	}

	function getKnownOpponents()
	{
		return this.m.KnownOpponents;
	}

	function getAveragePlayerLevel()
	{
		return this.m.AveragePlayerLevel;
	}

	function getAveragePlayerArmor()
	{
		return this.m.AveragePlayerArmor;
	}

	function isDefending()
	{
		return this.m.IsDefending;
	}

	function isDelayedAttack()
	{
		return this.m.IsDelayedAttack;
	}

	function isEscortedByPlayer()
	{
		return this.m.IsEscortedByPlayer;
	}

	function create()
	{
	}

	function clear()
	{
		this.m.IsDefending = false;
	}

	function update()
	{
		// Function is a generator.
		this.clear();
		this.m.Stats.IsOwnFactionEngaged = false;
		local allyRanged = 0.0;
		local enemyRanged = 0.0;
		local allyEngaged = 0;
		local allyFleeing = 0;
		local enemyFleeing = 0;
		local allyDefensive = 0;
		local enemyDefensive = 0;
		local defensiveBias = 0.0;
		local enemyRangedWeaponsReady = 0.0;
		local allyRangedWeaponsReady = 0.0;
		local allyOutranging = 0.0;
		local enemyOutranging = 0.0;
		local allyRangedFiring = 0.0;
		local enemyRangedFiring = 0.0;
		local allyRangedTotal = 0;
		local enemyRangedTotal = 0;
		local shortestDistToEnemy = 9000;
		local shortestDistToEnemyNotMoved = 9000;
		local longestDistToEnemy = 0;
		local allies = [];
		local enemies = [];
		local time = this.Time.getExactTime();
		local all = this.Tactical.Entities.getAllInstances();

		foreach( faction in all )
		{
			foreach( entity in faction )
			{
				if (!entity.isAlive() || !entity.isPlacedOnMap() || entity.isDying())
				{
					continue;
				}

				local rangedInfo = entity.getRangedWeaponInfo();
				rangedInfo.Entity <- entity;

				if (entity.isAlliedWith(this.m.Faction))
				{
					allies.push(rangedInfo);
					local isInZoc = entity.getTile().hasZoneOfControlOtherThan(entity.getAlliedFactions());

					if (entity.getMoraleState() == this.Const.MoraleState.Fleeing)
					{
						allyFleeing = ++allyFleeing;
					}

					if (this.isDefensive(entity))
					{
						allyDefensive = ++allyDefensive;
					}

					if (rangedInfo.HasRangedWeapon)
					{
						allyRanged = allyRanged + rangedInfo.RangeWithLevel * entity.getCurrentProperties().getRangedSkill();

						if (!isInZoc && (entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.RangedWeapon) || entity.getSkills().hasSkill("perk.quickhands")))
						{
							allyRangedWeaponsReady = allyRangedWeaponsReady + 1.0;
						}
					}

					defensiveBias = defensiveBias + entity.getAIAgent().getProperties().OverallDefensivenessMult;
				}
				else
				{
					enemies.push(rangedInfo);

					if (entity.getMoraleState() == this.Const.MoraleState.Fleeing)
					{
						enemyFleeing = ++enemyFleeing;
					}

					if (this.isDefensive(entity))
					{
						enemyDefensive = ++enemyDefensive;
					}

					if (rangedInfo.HasRangedWeapon)
					{
						enemyRanged = enemyRanged + rangedInfo.RangeWithLevel * entity.getCurrentProperties().getRangedSkill();

						if (!entity.getTile().hasZoneOfControlOtherThan(entity.getAlliedFactions()) && (entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.RangedWeapon) || entity.getSkills().hasSkill("perk.quickhands")))
						{
							enemyRangedWeaponsReady = enemyRangedWeaponsReady + 1.0;
						}
					}
				}
			}
		}

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		foreach( rangedInfo in enemies )
		{
			if (!rangedInfo.HasRangedWeapon)
			{
				continue;
			}

			if (rangedInfo.IsTrueRangedWeapon)
			{
				enemyRangedTotal = ++enemyRangedTotal;
			}

			local entityTile = rangedInfo.Entity.getTile();
			local canHit = false;
			local canBeHit = false;

			foreach( ally in allies )
			{
				local allyTile = ally.Entity.getTile();
				local d = entityTile.getDistanceTo(allyTile);

				if (d <= this.Math.min(rangedInfo.Range + this.Math.max(0, entityTile.Level - allyTile.Level), rangedInfo.RangeWithLevel))
				{
					canHit = true;
				}

				if (d <= this.Math.min(ally.Range + this.Math.max(0, allyTile.Level - entityTile.Level), ally.RangeWithLevel))
				{
					canBeHit = true;
				}

				if (canHit && canBeHit)
				{
					break;
				}
			}

			if (canHit && !canBeHit)
			{
				enemyOutranging = enemyOutranging + 1.0;
			}

			if (canHit)
			{
				enemyRangedFiring = enemyRangedFiring + (rangedInfo.IsTrueRangedWeapon ? 1.0 : 0.5);
			}
		}

		foreach( rangedInfo in allies )
		{
			if (!rangedInfo.HasRangedWeapon)
			{
				continue;
			}

			if (rangedInfo.IsTrueRangedWeapon)
			{
				allyRangedTotal = ++allyRangedTotal;
			}

			local entityTile = rangedInfo.Entity.getTile();
			local canHit = false;
			local canBeHit = false;

			foreach( enemy in enemies )
			{
				local enemyTile = enemy.Entity.getTile();
				local d = entityTile.getDistanceTo(enemyTile);

				if (d <= this.Math.min(rangedInfo.Range + this.Math.max(0, entityTile.Level - enemyTile.Level), rangedInfo.RangeWithLevel))
				{
					canHit = true;
				}

				if (d <= this.Math.min(enemy.Range + this.Math.max(0, enemyTile.Level - entityTile.Level), enemy.RangeWithLevel))
				{
					canBeHit = true;
				}

				if (canHit && canBeHit)
				{
					break;
				}
			}

			if (canHit && !canBeHit)
			{
				allyOutranging = allyOutranging + 1.0;
			}

			if (canHit)
			{
				allyRangedFiring = allyRangedFiring + (rangedInfo.IsTrueRangedWeapon ? 1.0 : 0.5);
			}
		}

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		foreach( ally in allies )
		{
			local allyTile = ally.Entity.getTile();

			if (allyTile.hasZoneOfControlOtherThan(ally.Entity.getAlliedFactions()))
			{
				allyEngaged = ++allyEngaged;
				shortestDistToEnemy = 1;
				shortestDistToEnemyNotMoved = 1;
				longestDistToEnemy = 1;

				if (ally.Entity.getFaction() == this.m.Faction)
				{
					this.m.Stats.IsOwnFactionEngaged = true;
				}

				continue;
			}

			local isEngaged = false;
			local shortestDist = 9999;
			local shortestDistNotMoved = 9999;

			foreach( enemy in enemies )
			{
				local enemyTile = enemy.Entity.getTile();
				local d = allyTile.getDistanceTo(enemyTile);

				if (!isEngaged && this.Math.abs(enemyTile.Level - allyTile.Level) <= 1 && (d <= this.Math.min(2, ally.Entity.getIdealRange()) || d <= this.Math.min(2, enemy.Entity.getIdealRange())))
				{
					allyEngaged = ++allyEngaged;
					isEngaged = true;

					if (ally.Entity.getFaction() == this.m.Faction)
					{
						this.m.Stats.IsOwnFactionEngaged = true;
					}
				}

				if (d < shortestDist)
				{
					shortestDist = d;
				}

				if (d < shortestDistNotMoved && ally.Entity.getActionPoints() == ally.Entity.getActionPointsMax())
				{
					shortestDistNotMoved = d;
				}
			}

			if (shortestDist < shortestDistToEnemy)
			{
				shortestDistToEnemy = shortestDist;
			}

			if (shortestDistNotMoved < shortestDistToEnemyNotMoved)
			{
				shortestDistToEnemyNotMoved = shortestDistNotMoved;
			}

			if (shortestDist > longestDistToEnemy)
			{
				longestDistToEnemy = shortestDist;
			}
		}

		local defendingCamp = this.isDefendingCamp();
		this.m.Stats.AlliesVSEnemiesRatio = this.Math.maxf(1.0, allies.len()) / this.Math.maxf(1.0, enemies.len());
		this.m.Stats.EnemiesVSAlliesRatio = this.Math.maxf(1.0, enemies.len()) / this.Math.maxf(1.0, allies.len());
		this.m.Stats.RangedAlliedVSEnemies = (allyRanged / 7.0 + 0.5) / (enemyRanged / 7.0 + 0.5);
		this.m.Stats.EngagedAlliesRatio = allyEngaged / this.Math.maxf(1.0, allies.len());
		this.m.Stats.FleeingAlliesRatio = allyFleeing / this.Math.maxf(1.0, allies.len());
		this.m.Stats.FleeingEnemiesRatio = enemyFleeing / this.Math.maxf(1.0, enemies.len());
		this.m.Stats.DefensiveAlliesRatio = this.Math.max(1, allyDefensive) / this.Math.maxf(1.0, allies.len());
		this.m.Stats.DefensiveEnemiesRatio = enemyDefensive / this.Math.maxf(1.0, enemies.len());
		this.m.Stats.DefensiveBiasAverage = defensiveBias / this.Math.maxf(1.0, allies.len()) * (defendingCamp ? 2.0 : 1.0);
		this.m.Stats.EnemyRangedReadyRatio = enemyRangedWeaponsReady / this.Math.maxf(1.0, enemies.len());
		this.m.Stats.AllyRangedReadyRatio = allyRangedWeaponsReady / this.Math.maxf(1.0, allies.len());
		this.m.Stats.AllyVSEnemyOutrange = (allyOutranging + 2.0) / (enemyOutranging + 2.0);
		this.m.Stats.IsOutrangedByEnemy = (!defendingCamp && enemyOutranging > allyOutranging || defendingCamp && enemyOutranging - 1 > allyOutranging) && (!defendingCamp && enemyRangedFiring >= allyRangedFiring || defendingCamp && enemyRangedFiring > allyRangedFiring);
		this.m.Stats.IsOutrangingEnemy = allyOutranging > enemyOutranging && allyRangedFiring > enemyRangedFiring;
		this.m.Stats.EnemyOutranging = enemyOutranging;
		this.m.Stats.AllyOutranging = allyOutranging;
		this.m.Stats.EnemyRangedFiring = enemyRangedFiring;
		this.m.Stats.AllyRangedFiring = allyRangedFiring;
		this.m.Stats.EnemyRangedTotal = enemyRangedTotal;
		this.m.Stats.AllyRangedTotal = allyRangedTotal;
		this.m.Stats.IsEngaged = this.m.Stats.EngagedAlliesRatio > 0.1;
		this.m.Stats.ShortestDistanceToEnemy = shortestDistToEnemy;
		this.m.Stats.ShortestDistanceToEnemyNotMoved = shortestDistToEnemyNotMoved;
		this.m.Stats.LongestDistanceToEnemy = longestDistToEnemy;
		local players = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		local levels = 0;
		local armors = 0;

		foreach( p in players )
		{
			levels = levels + p.getLevel();
			armors = armors + (p.getArmorMax(this.Const.BodyPart.Body) + p.getArmorMax(this.Const.BodyPart.Head));
		}

		this.m.AveragePlayerLevel = levels / (players.len() * 1.0);
		this.m.AveragePlayerArmor = armors / (players.len() * 1.0);
		this.m.IsEscortedByPlayer = false;
		this.m.IsDefending = this.updateDefending();
		this.m.Stats.IsBeingKited = false;

		if (!this.m.IsDefending && !this.m.Stats.IsEngaged && enemyRangedFiring >= 2 && (this.Tactical.State.getStrategicProperties() == null || this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line))
		{
			local notKiting = false;

			foreach( p in players )
			{
				if (p.getTile().SquareCoords.X >= 12)
				{
					notKiting = true;
					break;
				}
			}

			if (!notKiting)
			{
				this.m.Stats.IsBeingKited = true;
			}
		}

		return true;
	}

	function isDefensive( _entity )
	{
		return _entity.getItems().hasDefensiveItem();
	}

	function isAllottedTimeReached( _t )
	{
		return this.Time.getExactTime() - _t > this.Const.AI.AllottedTimePerEvaluationRun && (!this.Const.AI.ParallelizationMode || this.Root.isBackgroundTaskSuspended());
	}

	function updateDefending()
	{
		if (this.Const.AI.NoDefendMode || !this.Tactical.State.isScenarioMode() && this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			return false;
		}

		if (!this.m.Stats.IsOwnFactionEngaged && !this.Tactical.State.isScenarioMode() && this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull() && this.World.State.getEscortedEntity().getFaction() == this.m.Faction && this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()) != null && this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement)
		{
			this.m.IsEscortedByPlayer = true;
			return true;
		}

		if (this.m.Stats.EngagedAlliesRatio > this.Const.AI.Behavior.DefendMaxEngagedAlliesRatio)
		{
			this.m.IsOffensiveLastTurn = true;
			return false;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return false;
		}

		if (this.m.IsAttackingOnWorldmap && (1.0 + this.m.Stats.AllyRangedFiring) / (1.0 + this.m.Stats.EnemyRangedFiring) < 4.0 && (1.0 + this.m.Stats.AllyOutranging) / (1.0 + this.m.Stats.EnemyOutranging) < 4.0)
		{
			this.m.IsOffensiveLastTurn = true;
			return false;
		}

		if (this.m.Stats.AlliesVSEnemiesRatio >= 3.0 * this.m.Stats.DefensiveBiasAverage)
		{
			this.m.IsOffensiveLastTurn = true;
			return false;
		}

		local enemiesVSallies = this.m.Stats.EnemiesVSAlliesRatio;
		local rangedAlliesVSEnemies = this.m.Stats.DefensiveBiasAverage >= 1.0 ? this.m.Stats.RangedAlliedVSEnemies : this.Math.minf(1.0, this.m.Stats.RangedAlliedVSEnemies);
		local defensiveAlliesRatio = this.m.Stats.DefensiveAlliesRatio * 4.0;
		local fleeingEnemiesRatio = 1.0 - this.m.Stats.FleeingEnemiesRatio;
		local engagedAlliesRatio = 1.0 - this.m.Stats.EngagedAlliesRatio;
		local outrangeRatio = this.m.Stats.AllyVSEnemyOutrange;
		local defensiveScore = enemiesVSallies * engagedAlliesRatio * rangedAlliesVSEnemies * defensiveAlliesRatio * fleeingEnemiesRatio * outrangeRatio;
		local defensiveThreshold = 3.0 * (1.0 / this.Math.maxf(0.1, this.m.Stats.DefensiveBiasAverage));

		if (this.m.Stats.IsOutrangedByEnemy)
		{
			defensiveThreshold = defensiveThreshold * 10.0;
		}
		else if (this.m.Stats.IsOutrangingEnemy && this.m.Stats.DefensiveBiasAverage >= 1.0)
		{
			defensiveThreshold = defensiveThreshold * 0.5;
		}

		if (defensiveScore < defensiveThreshold)
		{
			this.m.IsOffensiveLastTurn = true;
			return false;
		}
		else
		{
			if (this.m.IsOffensiveLastTurn)
			{
				this.m.IsOffensiveLastTurn = false;
				return false;
			}

			return true;
		}
	}

	function isDefendingCamp()
	{
		return !this.m.IsAttackingOnWorldmap && !this.Tactical.State.isScenarioMode() && this.Tactical.State.getStrategicProperties().LocationTemplate != null && this.Tactical.State.getStrategicProperties().LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && this.World.FactionManager.isAllied(this.m.Faction, this.Tactical.State.getStrategicProperties().LocationTemplate.OwnedByFaction);
	}

	function compileKnownOpponents()
	{
		local instances = this.Tactical.Entities.getAllInstances();

		for( local f = 0; f != instances.len(); f = ++f )
		{
			if (this.Tactical.State.isScenarioMode())
			{
				if (this.Const.FactionAlliance[this.m.Faction].find(f) != null)
				{
					continue;
				}
			}
			else if (this.World.FactionManager.isAllied(this.m.Faction, f))
			{
				continue;
			}

			for( local p = 0; p != instances[f].len(); p = ++p )
			{
				if (!instances[f][p].isAttackable())
				{
				}
				else if (instances[f][p].getTile().IsHidingEntity && !instances[f][p].isVisibleToEntity())
				{
				}
				else
				{
					this.onOpponentSighted(instances[f][p]);
				}
			}
		}
	}

	function cleanUpKnownOpponents()
	{
		local garbage = [];

		foreach( i, o in this.m.KnownOpponents )
		{
			if (o.Actor == null || o.Actor.isNull() || !o.Actor.isAlive() || !o.Actor.isPlacedOnMap() || this.Tactical.State.isScenarioMode() && this.Const.FactionAlliance[this.m.Faction].find(o.Actor.getFaction()) != null || !this.Tactical.State.isScenarioMode() && this.World.FactionManager.isAllied(this.m.Faction, o.Actor.getFaction()))
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( i in garbage )
		{
			this.m.KnownOpponents.remove(i);
		}
	}

	function onOpponentSighted( _entity )
	{
		if (!_entity.isAlive() || !_entity.isAttackable())
		{
			return;
		}

		if (typeof _entity != "instance")
		{
			_entity = this.WeakTableRef(_entity);
		}

		foreach( o in this.m.KnownOpponents )
		{
			if (!o.Actor.isNull() && o.Actor.getID() == _entity.getID())
			{
				o.Tile = _entity.getTile();
				o.TTL = this.Const.AI.Agent.DefaultOpponentTTL;
				return;
			}
		}

		this.m.KnownOpponents.push({
			Actor = _entity,
			Tile = _entity.getTile(),
			TTL = this.Const.AI.Agent.DefaultOpponentTTL
		});
	}

};

