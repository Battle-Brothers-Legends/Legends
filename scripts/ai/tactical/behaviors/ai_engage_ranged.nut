this.ai_engage_ranged <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetScore = 0.0,
		ValidTargets = [],
		PotentialDanger = [],
		CurrentDanger = 0.0,
		TargetDist = 0,
		TargetDanger = 0.0,
		TargetAPCost = 0,
		Skill = null,
		IsTakingCover = false,
		IsTargetForNextTurn = false,
		IsTargetNextToUs = false,
		IsInDangerThisRound = false,
		IsWaiting = false,
		IsDoneThisTurn = false,
		IsWaitingAfterMove = false,
		IsUsedThisTurn = false,
		PossibleSkills = [
			"actives.quick_shot",
			"actives.aimed_shot",
			"actives.shoot_bolt",
			"actives.shoot_stake",
			"actives.sling_stone",
			"actives.fire_handgonne",
			"actives.miasma",
			"actives.horror",
			"actives.root",
			"actives.insects",
			"actives.charm",
			"actives.raise_undead"
		]
	},
	function isUsedThisTurn()
	{
		return this.m.IsUsedThisTurn;
	}

	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.EngageRanged;
		this.m.Order = this.Const.AI.Behavior.Order.EngageRanged;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onTurnStarted()
	{
		this.m.IsInDangerThisRound = false;
		this.m.IsDoneThisTurn = false;
		this.m.IsUsedThisTurn = false;
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.TargetScore = 0.0;
		this.m.ValidTargets = [];
		this.m.TargetDist = 0;
		this.m.TargetAPCost = 0;
		this.m.TargetDanger = 0;
		this.m.Skill = null;
		this.m.IsTargetNextToUs = false;
		this.m.IsTargetForNextTurn = false;
		this.m.IsWaiting = false;
		this.m.IsWaitingAfterMove = false;
		this.m.IsTakingCover = false;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.IsDoneThisTurn && _entity.getActionPoints() < _entity.getActionPointsMax())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsRooted)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local retreat = this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat);

		if (retreat != null && retreat.getScore() != 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local zoc = _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions());

		if (zoc > 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local maxRange = 0;
		local considerLineOfFire = true;
		local visibleTileNeeded = true;
		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.getMaxRange() > maxRange)
			{
				maxRange = skill.getMaxRange();
				considerLineOfFire = skill.isRanged();
				visibleTileNeeded = skill.isVisibleTileNeeded();
				this.m.Skill = skill;
			}
		}

		if (maxRange == 0)
		{
			maxRange = this.Const.AI.Behavior.RangedEngageDefaultMaxRange;
		}

		maxRange = this.Math.min(this.Const.AI.Behavior.RangedEngageAbsoluteMaxRange, this.Math.min(maxRange, visibleTileNeeded ? _entity.getCurrentProperties().getVision() : maxRange));
		local targets = this.getAgent().getKnownOpponents();
		local myTile = _entity.getTile();
		local func = this.compileTargets(_entity, this.getAgent().getKnownOpponents(), maxRange);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.ValidTargets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.IsInDangerThisRound = this.m.CurrentDanger != 0;

		if (this.m.Skill != null && this.m.Skill.getMaxRange() == 99 && !this.m.IsInDangerThisRound)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		yield null;
		local func = this.selectBestTargetTile(_entity, maxRange, considerLineOfFire, visibleTileNeeded);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.TargetTile == null || this.m.IsTargetForNextTurn || this.m.TargetTile.isSameTileAs(_entity.getTile()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsDefendingPosition && this.m.TargetDanger > this.m.CurrentDanger)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.CurrentDanger > 1.0 && this.m.TargetDanger < this.m.CurrentDanger && this.getProperties().OverallDefensivenessMult != 0)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": It\'s important that I get some distance from my opponents...");
			}

			scoreMult = scoreMult * this.Math.maxf(this.getProperties().OverallDefensivenessMult * 0.5, this.m.CurrentDanger / this.Math.maxf(1.0, this.m.TargetDanger));
		}

		if ((this.m.IsTargetNextToUs || _entity.getActionPoints() - this.m.TargetAPCost >= 4) && this.m.TargetTile.Level > _entity.getTile().Level)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Considering improving position since a clearly better one is right next to me...");
			}

			scoreMult = scoreMult * this.Const.AI.Behavior.RangedEngageImprovePosNearbyMult;
		}

		if (_entity.isAbleToWait() && (scoreMult < 0.5 || this.m.TargetDanger > this.m.CurrentDanger || this.getStrategy().isDefending && this.getStrategy().isDefendingCamp() && this.m.TargetAPCost > 9))
		{
			this.m.IsWaiting = true;
		}

		local distToTarget = this.m.TargetTile.getDistanceTo(myTile);

		if (this.m.IsTakingCover)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Taking cover...");
			}

			scoreMult = scoreMult * this.Math.maxf(1.0, this.Const.AI.Behavior.RangedEngageTakeCoverMult * this.Math.minf(3.0, (1.0 + this.getStrategy().getStats().EnemyRangedFiring) / (1.0 + this.getStrategy().getStats().AllyRangedFiring)) * this.getProperties().OverallDefensivenessMult);
		}

		return (this.Const.AI.Behavior.Score.EngageRanged + this.m.TargetScore) * scoreMult;
	}

	function onBeforeExecute( _entity )
	{
		if (this.m.IsWaitingAfterMove)
		{
			this.m.IsDoneThisTurn = true;
		}

		this.m.IsUsedThisTurn = true;
		this.getAgent().getOrders().IsEngaging = true;
		this.getAgent().getOrders().IsDefending = false;
		this.getAgent().getIntentions().IsDefendingPosition = false;
		this.getAgent().getIntentions().IsEngaging = true;
	}

	function onExecute( _entity )
	{
		local navigator = this.Tactical.getNavigator();

		if (this.m.IsFirstExecuted)
		{
			if (this.m.IsWaiting)
			{
				if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
				{
					if (this.Const.AI.VerboseMode)
					{
						this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
					}

					this.m.TargetTile = null;
					return true;
				}
				else
				{
					this.m.IsWaiting = false;
				}
			}

			local settings = navigator.createSettings();
			settings.ActionPointCosts = _entity.getActionPointCosts();
			settings.FatigueCosts = _entity.getFatigueCosts();
			settings.FatigueCostFactor = 0.0;
			settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
			settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
			settings.AllowZoneOfControlPassing = false;
			settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
			settings.AlliedFactions = _entity.getAlliedFactions();
			settings.Faction = _entity.getFaction();
			navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, this.m.TargetDist);

			if (this.Const.AI.PathfindingDebugMode)
			{
				navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
			}

			local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

			if (movement.Tiles == 0)
			{
				return true;
			}

			this.m.Agent.adjustCameraToDestination(movement.End);

			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Engaging into firing range over " + movement.Tiles + " tiles");
			}

			this.m.IsFirstExecuted = false;
			return;
		}

		if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
		{
			this.m.TargetTile = null;
			return true;
		}

		return false;
	}

	function getDangerFromActor( _actor, _target, _entity )
	{
		local d = this.queryActorTurnsNearTarget(_actor, _target, _entity);

		if (d.Turns <= this.Const.AI.Behavior.RangedEngageKeepMinTurnsAway && d.InZonesOfControl < 2)
		{
			if (d.InZonesOfOccupation != 0 || _actor.getCurrentProperties().IsRooted)
			{
				return 1.0;
			}
			else
			{
				return (1.0 - d.Turns) * 6.0;
			}
		}
		else
		{
			return 0.0;
		}
	}

	function selectBestTargetTile( _entity, _maxRange, _considerLineOfFire, _visibleTileNeeded )
	{
		// Function is a generator.
		local navigator = this.Tactical.getNavigator();
		local myTile = _entity.getTile();
		local myFaction = _entity.getFaction();
		local allies = this.getAgent().getKnownAllies();
		local useCoverMult = this.Math.minf(10.0, (1.0 + this.getStrategy().getStats().EnemyRangedFiring) / (1.0 + this.getStrategy().getStats().AllyRangedFiring));
		local myTileScore = -9000;
		local origin = myTile;
		local minDistance = 9000;

		foreach( target in this.m.ValidTargets )
		{
			local d = target.Tile.getDistanceTo(origin);

			if (d < minDistance)
			{
				minDistance = d;
			}
		}

		if (_maxRange < 99 && minDistance >= _maxRange)
		{
			local x = 0;
			local y = 0;

			foreach( target in this.m.ValidTargets )
			{
				x = x + target.Tile.SquareCoords.X;
				y = y + target.Tile.SquareCoords.Y;
			}

			x = this.Math.round(myTile.SquareCoords.X * 0.75 + x / this.m.ValidTargets.len() * 0.25);
			y = this.Math.round(myTile.SquareCoords.Y * 0.75 + y / this.m.ValidTargets.len() * 0.25);

			if (!this.Tactical.isValidTile(x, y))
			{
				x = myTile.SquareCoords.X;
				y = myTile.SquareCoords.Y;
			}

			origin = this.Tactical.getTileSquare(x, y);

			if (origin.getDistanceTo(myTile) > this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange)) / 2)
			{
				origin = myTile;
			}
			else
			{
				minDistance = 9000;

				foreach( target in this.m.ValidTargets )
				{
					local d = target.Tile.getDistanceTo(origin);

					if (d < minDistance)
					{
						minDistance = d;
					}
				}
			}
		}

		if (minDistance > this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange)))
		{
			local settings = navigator.createSettings();
			settings.ActionPointCosts = _entity.getActionPointCosts();
			settings.FatigueCosts = _entity.getFatigueCosts();
			settings.FatigueCostFactor = 0.0;
			settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
			settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
			settings.AllowZoneOfControlPassing = false;
			settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
			settings.AlliedFactions = _entity.getAlliedFactions();
			settings.Faction = _entity.getFaction();
			this.m.ValidTargets.sort(this.onSortByDistance);

			foreach( target in this.m.ValidTargets )
			{
				if (navigator.findPath(myTile, target.Tile, settings, this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange))))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.Tiles != 0)
					{
						this.m.TargetDist = this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange));
						this.m.TargetTile = target.Tile;
						this.m.TargetDanger = 0;
						this.logDebug("No good tile in range, engaging in the general direction of the enemy!");
						return true;
					}
				}
			}
		}

		local size = this.Tactical.getMapSize();
		local centerTile;

		if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().LocationTemplate != null)
		{
			centerTile = this.Tactical.getTileSquare(size.X / 2 + this.Tactical.State.getStrategicProperties().LocationTemplate.ShiftX, size.Y / 2 + this.Tactical.State.getStrategicProperties().LocationTemplate.ShiftY);
		}
		else
		{
			centerTile = this.Tactical.getTileSquare(size.X / 2, size.Y / 2);
		}

		local time = this.Time.getExactTime();
		yield null;
		time = this.Time.getExactTime();
		local tiles = {
			AI = this,
			Actor = _entity,
			Origin = myTile,
			ValidTargets = this.m.ValidTargets,
			Range = _maxRange,
			IsAlliedWithPlayer = _entity.isAlliedWithPlayer(),
			Faction = myFaction,
			Tiles = [],
			MapSize = this.Tactical.getMapSize()
		};
		this.onQueryTargetTile(myTile, tiles);
		this.Tactical.queryTilesInRange(origin, 1, this.Math.min(12, this.Math.max(this.Const.AI.Behavior.RangedEngageMinQueryRadius, _maxRange)), true, _entity.getAlliedFactions(), this.onQueryTargetTile, tiles);

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		tiles.Tiles.sort(this.onSortByScore);
		local handgonneBehavior = this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackHandgonne);
		local miasmaBehavior = this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Miasma);
		local horrorBehavior = this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Horror);
		local attempts = 0;
		local candidates = [];

		foreach( t in tiles.Tiles )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			if (this.getStrategy().isDefending() && this.getStrategy().isDefendingCamp() && !this.m.IsInDangerThisRound && this.getStrategy().getStats().EnemyRangedFiring < this.getStrategy().getStats().AllyRangedFiring)
			{
				local radius = this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius;

				for( ; t.Tile.getDistanceTo(centerTile) > radius;  )
				{
				}
			}

			attempts = ++attempts;

			if (attempts > this.Const.AI.Behavior.RangedEngageFilterMaxAttempts && candidates.len() != 0)
			{
				break;
			}

			local score = 0.0;
			local takingCover = false;
			local tooClose = false;

			foreach( target in this.m.ValidTargets )
			{
				local d = t.Tile.getDistanceTo(target.Tile);

				if (d <= 1)
				{
					tooClose = true;
					  // [608]  OP_JMP            0     26    0    0
				}
				else if (d <= target.Actor.getIdealRange() && !target.Actor.getCurrentProperties().IsStunned && target.Actor.isArmedWithMeleeWeapon())
				{
					score = score + this.Const.AI.Behavior.RangedEngageInRangeOfPolearmBonus;
				}
			}

			if (tooClose)
			{
				continue;
			}

			if (this.m.Skill != null && this.m.Skill.getID() == "actives.fire_handgonne")
			{
				local c = handgonneBehavior.selectBestTarget(t.Tile, _entity, this.m.Skill);
				score = score + c * this.Const.AI.Behavior.RangedEngageTargetScoreMult;
			}
			else if (this.m.Skill != null && this.m.Skill.getID() == "actives.miasma")
			{
				local c = miasmaBehavior.selectBestTarget(t.Tile, _entity, this.m.Skill);
				score = score + c * this.Const.AI.Behavior.RangedEngageTargetScoreMult;
			}
			else if (this.m.Skill != null && this.m.Skill.getID() == "actives.horror")
			{
				local c = horrorBehavior.selectBestTarget(t.Tile, _entity, this.m.Skill);
				score = score + c * this.Const.AI.Behavior.RangedEngageTargetScoreMult;
			}
			else
			{
				local avgLevel = 0;
				local validTargets = 0;

				foreach( target in this.m.ValidTargets )
				{
					if ((this.m.Skill != null && this.m.Skill.onVerifyTarget(t.Tile, target.Tile)) && target.Tile.getDistanceTo(t.Tile) <= _maxRange + (_considerLineOfFire ? this.Math.max(0, t.Tile.Level - target.Tile.Level) : 0) && (!_considerLineOfFire || t.Tile.hasLineOfSightTo(target.Tile, _entity.getCurrentProperties().getVision())))
					{
						avgLevel = avgLevel + target.Tile.Level;
						validTargets = ++validTargets;
						local targetScore = target.Score;
						local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(t.Tile, target.Tile, myFaction);

						if (blockedTiles.len() != 0)
						{
							targetScore = targetScore * this.Const.AI.Behavior.RangedEngageBlockedMult;
						}

						foreach( tile in blockedTiles )
						{
							if (tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(_entity))
							{
								targetScore = targetScore * (this.Const.AI.Behavior.RangedEngageBlockedByAllyMult * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult));
								break;
							}
						}

						score = score + targetScore * this.Const.AI.Behavior.RangedEngageTargetScoreMult;
					}
				}

				if (validTargets > 0)
				{
					avgLevel = avgLevel / validTargets;

					if (t.Tile.Level > avgLevel)
					{
						score = score + (t.Tile.Level - avgLevel) * this.Const.AI.Behavior.RangedEngageLevelAdvantageMult;
					}
				}
			}

			if (score <= 0)
			{
				continue;
			}

			if (this.getStrategy().getStats().RangedAlliedVSEnemies <= 3.0)
			{
				local dirs = [
					0,
					0,
					0,
					0,
					0,
					0
				];
				local numRangedOpponentsInRange = 0;

				foreach( opponent in this.m.ValidTargets )
				{
					if (!opponent.IsRangedUnit || opponent.Tile.getDistanceTo(t.Tile) > 10)
					{
						continue;
					}

					numRangedOpponentsInRange = ++numRangedOpponentsInRange;
					local dir = t.Tile.getDirection8To(opponent.Tile);
					local mult = 7.0 / t.Tile.getDistanceTo(opponent.Tile);

					switch(dir)
					{
					case this.Const.Direction8.W:
						dirs[this.Const.Direction.NW] += 4 * mult;
						dirs[this.Const.Direction.SW] += 4 * mult;
						break;

					case this.Const.Direction8.E:
						dirs[this.Const.Direction.NE] += 4 * mult;
						dirs[this.Const.Direction.SE] += 4 * mult;
						break;

					default:
						local dir = t.Tile.getDirectionTo(opponent.Tile);
						local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
						local dir_right = dir + 1 < 6 ? dir + 1 : 0;
						dirs[dir] += 4 * mult;
						dirs[dir_left] += 3 * mult;
						dirs[dir_right] += 3 * mult;
						break;
					}
				}

				if (numRangedOpponentsInRange != 0)
				{
					for( local i = 0; i < 6; i = ++i )
					{
						if (dirs[i] <= 1)
						{
						}
						else if (!t.Tile.hasNextTile(i))
						{
						}
						else
						{
							local tile = t.Tile.getNextTile(i);

							if (tile.IsEmpty || tile.ID == myTile.ID)
							{
							}
							else
							{
								local cover = tile.getEntity();

								if (!tile.IsOccupiedByActor && !cover.isBlockingSight() || tile.IsOccupiedByActor && cover.isAlliedWith(_entity) && !this.isRangedUnit(cover))
								{
									local protectorMult = 1.0;

									if (this.getStrategy().isDefendingCamp() && t.Tile.getDistanceTo(centerTile) == this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius - 1)
									{
										protectorMult = protectorMult * 1.25;
									}

									if (tile.IsOccupiedByActor && cover.isAlliedWith(_entity) && cover.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= 1.0 && cover.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null)
									{
										protectorMult = protectorMult * 1.25;
									}

									score = score + this.Const.AI.Behavior.RangedEngageCoverMult * (dirs[i] / (numRangedOpponentsInRange * 1.0)) * (this.getStrategy().isDefending() ? 2.0 : 1.0) * useCoverMult * protectorMult * this.getProperties().OverallDefensivenessMult;
									takingCover = true;
								}
							}
						}
					}
				}
			}

			candidates.push({
				Tile = t.Tile,
				Score = score - myTile.getDistanceTo(t.Tile) + (myTile.ID == t.Tile.ID ? 1000.0 : 0.0),
				TileScore = score,
				IsTakingCover = takingCover
			});
		}

		if (candidates.len() == 0)
		{
			return true;
		}

		tiles = [];
		candidates.sort(this.onSortByScore);
		local bestDestination;
		local bestScore = -9000;
		local bestDanger = 0;
		local bestIsNextToUs = false;
		local bestIsForNextTurn = false;
		local bestAPCost = 0;
		local bestTakingCover = false;
		attempts = 0;

		foreach( t in candidates )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			attempts = ++attempts;

			if (attempts > this.Const.AI.Behavior.RangedEngageMaxAttempts && bestDestination != null)
			{
				break;
			}

			local IsNextToUs = false;
			local IsForNextTurn = false;
			local apCost = 0;
			local finalTile = t.Tile;
			local danger = 0;

			if (!t.Tile.isSameTileAs(_entity.getTile()))
			{
				local settings = navigator.createSettings();
				settings.ActionPointCosts = _entity.getActionPointCosts();
				settings.FatigueCosts = _entity.getFatigueCosts();
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();

				if (navigator.findPath(_entity.getTile(), t.Tile, settings, 0))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
					apCost = apCost + movementCosts.ActionPointsRequired;
					finalTile = movementCosts.End;

					if (!movementCosts.IsComplete && this.hasNegativeTileEffect(finalTile, _entity))
					{
						apCost = apCost + this.Const.AI.Behavior.RangedEngageNegativeEffecAtStop;
					}

					if (!movementCosts.IsComplete && movementCosts.Tiles == 0)
					{
						IsForNextTurn = true;
					}
					else if (movementCosts.IsComplete && movementCosts.Tiles <= 2)
					{
						IsNextToUs = true;
					}
					else
					{
						IsNextToUs = false;
					}
				}
				else
				{
					continue;
				}

				local dangerAtTarget = 0.0;
				local dangerAtStop = 0.0;

				foreach( d in this.m.PotentialDanger )
				{
					if (finalTile.isSameTileAs(t.Tile))
					{
						local d = this.getDangerFromActor(d, finalTile, _entity);
						dangerAtTarget = dangerAtTarget + d;
						dangerAtStop = dangerAtStop + d;
					}
					else
					{
						dangerAtTarget = dangerAtTarget + this.getDangerFromActor(d, t.Tile, _entity);
						dangerAtStop = dangerAtStop + this.getDangerFromActor(d, finalTile, _entity);
					}
				}

				danger = this.Math.maxf(dangerAtTarget, dangerAtStop);
			}
			else
			{
				danger = this.m.CurrentDanger;
			}

			if (danger > this.m.CurrentDanger + 2 + this.getProperties().EngageDangerTolerance)
			{
				continue;
			}

			local score = 0 - apCost + t.TileScore - danger * this.Const.AI.Behavior.RangedEngageDangerMult;

			if (t.Tile.isSameTileAs(_entity.getTile()))
			{
				myTileScore = score;
			}

			if (score > bestScore || score == bestScore && danger < bestDanger)
			{
				bestDestination = t.Tile;
				bestIsNextToUs = IsNextToUs;
				bestIsForNextTurn = IsForNextTurn;
				bestAPCost = apCost;
				bestDanger = danger;
				bestTakingCover = t.IsTakingCover;
				bestScore = score;
			}
		}

		if (bestDestination != null && (bestScore <= myTileScore || bestDestination.isSameTileAs(_entity.getTile())))
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": In fact, I would prefer to remain where I am (new)");
			}

			this.m.TargetDist = 0;
			this.m.TargetTile = _entity.getTile();
			this.m.TargetDanger = this.m.CurrentDanger;
			this.m.TargetAPCost = 0;
			this.m.IsTargetNextToUs = false;
			this.m.IsTargetForNextTurn = false;
			return true;
		}
		else if (bestDestination != null)
		{
			this.m.TargetScore = bestScore;
			this.m.TargetDist = 0;
			this.m.TargetTile = bestDestination;
			this.m.TargetDanger = bestDanger;
			this.m.TargetAPCost = bestAPCost;
			this.m.IsTargetNextToUs = bestIsNextToUs;
			this.m.IsTargetForNextTurn = bestIsForNextTurn;
			this.m.IsTakingCover = bestTakingCover;
			return true;
		}

		return true;
	}

	function onQueryTargetTile( _tile, _tag )
	{
		if (_tile.SquareCoords.X >= _tag.MapSize.X - 1 || _tile.SquareCoords.X <= 0 || _tile.SquareCoords.Y >= _tag.MapSize.Y - 1 || _tile.SquareCoords.Y <= 0)
		{
			return;
		}

		local score = 0.0;
		local targetDist = _tile.getDistanceTo(_tag.Origin);
		score = score - targetDist;
		score = score + _tile.Level * 2.5;

		if (_tile.IsHidingEntity)
		{
			score = score + this.Const.AI.Behavior.RangedEngageTileHiddenBonus * _tag.AI.getProperties().OverallHideMult;
		}

		if (!_tag.IsAlliedWithPlayer && _tag.AI.getProperties().OverallHideMult >= 1.0 && !_tile.IsVisibleForPlayer)
		{
			score = score + this.Const.AI.Behavior.RangedEngageTileNotVisibleBonus * _tag.AI.getProperties().OverallHideMult;
		}

		score = score - (_tile.Properties.Effect != null && !_tile.Properties.Effect.IsPositive && _tile.Properties.Effect.Applicable(_tag.Actor) ? this.Const.AI.Behavior.RangedEngageNegativeTileEffectBonus : 0);
		score = score - (_tile.Properties.IsMarkedForImpact ? this.Const.AI.Behavior.RangedEngageNegativeTileEffectBonus : 0);
		_tag.Tiles.push({
			Tile = _tile,
			Score = score
		});
	}

	function onSortByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
		{
			return -1;
		}
		else if (_a.Score < _b.Score)
		{
			return 1;
		}

		return 0;
	}

	function onSortByDistance( _a, _b )
	{
		if (_a.Distance < _b.Distance)
		{
			return -1;
		}
		else if (_a.Distance > _b.Distance)
		{
			return 1;
		}

		return 0;
	}

	function compileTargets( _entity, _targets, _maxRange )
	{
		// Function is a generator.
		this.m.ValidTargets = [];
		this.m.PotentialDanger = [];
		this.m.CurrentDanger = 0.0;
		local myTile = _entity.getTile();
		local time = this.Time.getExactTime();

		foreach( target in _targets )
		{
			if (target.Actor.isNull())
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local targetTile = target.Actor.getTile();
			local realDist = myTile.getDistanceTo(targetTile);

			if (realDist <= this.Const.AI.Behavior.RangedEngageMaxDangerDist && target.Actor.getMoraleState() != this.Const.MoraleState.Fleeing && !this.isRangedUnit(target.Actor) && !target.Actor.isNonCombatant() && target.Actor.getHitpoints() / target.Actor.getHitpointsMax() >= this.Const.AI.Behavior.RangedEngageMinDangerHitpointsPct && targetTile.getZoneOfControlCountOtherThan(target.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				this.m.PotentialDanger.push(target.Actor);
				local danger = this.getDangerFromActor(target.Actor, myTile, _entity);
				this.m.CurrentDanger += danger;
			}

			local alliesAdjacent = 0;
			local opponentsAdjacent = 0;
			local score = this.queryTargetValue(_entity, target.Actor, null);

			for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.IsEmpty)
					{
					}
					else if (tile.IsOccupiedByActor)
					{
						if (tile.getEntity().isAlliedWith(_entity))
						{
							if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
							{
								score = score - 1.0 / 6.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * tile.getEntity().getCurrentProperties().TargetAttractionMult;
							}

							alliesAdjacent = ++alliesAdjacent;
						}
						else
						{
							score = score + 1.0 / 6.0 * this.queryTargetValue(_entity, tile.getEntity(), null) * this.Const.AI.Behavior.AttackRangedHitBystandersMult;
							opponentsAdjacent = ++opponentsAdjacent;
						}
					}
				}
			}

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				score = score * (1.0 + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(target.Actor, myTile, _entity).Turns)) * this.Const.AI.Behavior.AttackDangerMult);
			}

			this.m.ValidTargets.push({
				Actor = target.Actor,
				Tile = targetTile,
				Distance = realDist,
				IsRangedUnit = this.isRangedUnit(target.Actor),
				Score = this.Math.maxf(0.01, score),
				OpponentsAdjacent = opponentsAdjacent,
				AlliesAdjacent = alliesAdjacent
			});
		}

		return true;
	}

});

