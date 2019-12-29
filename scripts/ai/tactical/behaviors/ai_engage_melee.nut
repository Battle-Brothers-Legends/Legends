this.ai_engage_melee <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		OriginTile = null,
		TargetTile = null,
		TargetActor = null,
		TargetDistance = 0,
		Skill = null,
		Inertia = 0,
		PossibleSkills = [
			"actives.charge",
			"actives.unstoppable_charge",
			"actives.gore"
		],
		IsDoneThisTurn = false,
		IsEngagedThisTurn = false,
		IsWaitingAfterMove = false,
		IsWaitingBeforeMove = false,
		IsIgnoringZOC = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.EngageMelee;
		this.m.Order = this.Const.AI.Behavior.Order.EngageMelee;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.OriginTile = null;
		this.m.TargetTile = null;
		this.m.TargetActor = null;
		this.m.TargetDistance = 0;
		this.m.IsIgnoringZOC = _entity.getCurrentProperties().IsImmuneToZoneOfControl;
		this.m.IsWaitingBeforeMove = false;
		local time = this.Time.getExactTime();

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

		if (this.getAgent().getIntentions().IsDefendingPosition || this.getAgent().getIntentions().IsRecuperating)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getFaction() != this.Const.Faction.PlayerAnimals && this.getStrategy().isDefending())
		{
			if (this.getStrategy().isEscortedByPlayer() || this.getStrategy().getStats().EnemyRangedFiring == 0 && !_entity.isArmedWithRangedWeapon())
			{
				return this.Const.AI.Behavior.Score.Zero;
			}
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getStrategy().getStats().IsEngaged && _entity.getIdealRange() == 2 && !this.getProperties().IgnoreTargetValueOnEngage && _entity.isAbleToWait() && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity) && !this.isKindOf(_entity.get(), "lindwurm"))
		{
			local allies = this.getAgent().getKnownAllies();
			local someoneStillToMove = false;

			foreach( ally in allies )
			{
				if (!ally.isTurnDone() && ally.isArmedWithMeleeWeapon() && ally.getIdealRange() == 1 && ally.getActionPoints() >= 4)
				{
					someoneStillToMove = true;
					break;
				}
			}

			if (someoneStillToMove)
			{
				this.m.IsWaitingBeforeMove = true;
				return this.Const.AI.Behavior.Score.Engage * score;
			}
		}

		if (!this.getStrategy().getStats().IsEngaged && this.getStrategy().isDelayedAttack() && _entity.isAbleToWait() && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity))
		{
			this.m.IsWaitingBeforeMove = true;
			return this.Const.AI.Behavior.Score.Engage * score;
		}

		local myTile = _entity.getTile();
		local targetsInMelee = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax));
		local AlreadyEngagedWithNum = targetsInMelee.len();
		local inZonesOfControl = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		local knownAllies = this.getAgent().getKnownAllies();
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (inZonesOfControl > 1 && (this.m.Skill == null || !this.m.Skill.isDisengagement()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (targetsInMelee.len() > 0 && this.getProperties().EngageWhenAlreadyEngagedMult == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (inZonesOfControl != 0 && targetsInMelee.len() > 0)
		{
			if (this.m.Skill != null && this.m.Skill.isDisengagement())
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.EngageWithSkillToDisengagePOW, inZonesOfControl);
			}
			else
			{
				if (targetsInMelee[0].getMoraleState() == this.Const.MoraleState.Fleeing)
				{
					score = score * this.Const.AI.Behavior.EngageWhenAlreadyEngagedSafeMult;
				}
				else if (targetsInMelee[0].getCurrentProperties().IsStunned)
				{
					score = score * this.Const.AI.Behavior.EngageWhenAlreadyEngagedSafeMult;
				}
				else
				{
					local skill = 1.0 - this.Math.max(1.0, (targetsInMelee[0].getCurrentProperties().getMeleeSkill() - _entity.getCurrentProperties().getMeleeDefense()) / 100.0);
					score = score * (1.0 - this.Const.AI.Behavior.EngageWhenAlreadyEngagedDefenseMult + skill * this.Const.AI.Behavior.EngageWhenAlreadyEngagedDefenseMult);
				}

				score = score * (targetsInMelee[0].getHitpoints() / targetsInMelee[0].getHitpointsMax() * this.Const.AI.Behavior.EngageWhenAlreadyEngagedHPMult);
				score = score * (_entity.getHitpoints() / _entity.getHitpointsMax() * this.Const.AI.Behavior.EngageWhenAlreadyEngagedHPMult);
				score = score * this.getProperties().EngageWhenAlreadyEngagedMult;
			}
		}
		else if (AlreadyEngagedWithNum != 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.EngageWhenAlreadyInRangeMult, targetsInMelee.len());
		}

		local targets = this.getAgent().getKnownOpponents();
		local potentialDestinations = [];
		local bestValue = 0;
		local bestTarget;

		foreach( target in targetsInMelee )
		{
			local v = this.queryTargetValue(_entity, target);

			if (v > bestValue)
			{
				bestValue = v;
				bestTarget = target;
			}
		}

		foreach( t in targets )
		{
			if (t.Actor.isNull())
			{
				continue;
			}

			if (this.m.Skill != null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost && t.Actor.getTile().getDistanceTo(myTile) > this.m.Skill.getMaxRange() + 1)
			{
				continue;
			}

			local targetTile = t.Actor.getTile();
			local isTargetInEnemyZoneOfControl = targetTile.hasZoneOfControlOtherThan(t.Actor.getAlliedFactions());
			local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(t.Actor);
			local isTargetFleeing = t.Actor.getMoraleState() == this.Const.MoraleState.Fleeing;
			local engagementsDeclared = (t.Actor.getAIAgent().getEngagementsDeclared(_entity) + t.Actor.getTile().getZoneOfControlCount(_entity.getFaction()) * 2) * this.Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult * this.getProperties().EngageTargetAlreadyBeingEngagedMult;
			local letOthersGoScore = 0.0;
			local targetValue = this.getProperties().IgnoreTargetValueOnEngage ? 0.5 : this.queryTargetValue(_entity, t.Actor);
			local lockDownValue = 1.0;

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) == 0 && !isTargetArmedWithRangedWeapon && !isTargetFleeing && engagementsDeclared == 0)
			{
				foreach( ally in knownAllies )
				{
					if (ally.getCurrentProperties().TargetAttractionMult <= 1.0 && !this.isRangedUnit(ally))
					{
						continue;
					}

					local d = this.queryActorTurnsNearTarget(t.Actor, ally.getTile(), t.Actor);

					if (d.Turns <= 1.0)
					{
						lockDownValue = lockDownValue * (this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult);
					}
				}
			}

			if (this.getProperties().IgnoreTargetValueOnEngage)
			{
				letOthersGoScore = letOthersGoScore + this.Math.abs(myTile.SquareCoords.Y - targetTile.SquareCoords.Y) * 20.0;
				local myDistanceToTarget = myTile.getDistanceTo(targetTile);
				local targets = this.getAgent().getKnownAllies();

				foreach( ally in targets )
				{
					if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
					{
						letOthersGoScore = letOthersGoScore + 2.0;
					}
				}
			}
			else
			{
				local myDistanceToTarget = myTile.getDistanceTo(targetTile);
				local targets = this.getAgent().getKnownAllies();

				foreach( ally in targets )
				{
					if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
					{
						letOthersGoScore = letOthersGoScore + 0.5;
					}
				}
			}

			local potentialTiles = this.queryDestinationsInMeleeRange(targetTile, this.getProperties().EngageRangeMin, this.getProperties().EngageRangeMax);

			foreach( tile in potentialTiles )
			{
				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}

				if (tile.isSameTileAs(myTile) || tile.Type == this.Const.Tactical.TerrainType.Impassable)
				{
					continue;
				}

				local levelDifference = tile.Level - targetTile.Level;
				local distance = tile.getDistanceTo(myTile);
				local distanceFromTarget = tile.getDistanceTo(targetTile);
				local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
				local tileScore = -distance * this.Const.AI.Behavior.EngageDistancePenaltyMult * (1.0 + this.Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult) - letOthersGoScore;
				local scoreBonus = 0 - letOthersGoScore;
				local scoreMult = 1.0;
				local isSkillUsable = false;

				if (AlreadyEngagedWithNum != 0)
				{
					if (tile.Level < myTile.Level || tile.IsBadTerrain && !myTile.IsBadTerrain)
					{
						continue;
					}

					/*for( ; tile.getDistanceTo(myTile) > 4;  )
					{
					}

					for( ; zocs > inZonesOfControl;  )
					{
					}*/

					if (tile.Level <= myTile.Level && tile.IsBadTerrain == myTile.IsBadTerrain && (this.m.Skill == null || !this.m.Skill.isDisengagement()))
					{
						continue;
					}

					if (bestTarget != null && tile.Level <= myTile.Level && tile.IsBadTerrain == myTile.IsBadTerrain && (t.Actor.getID() == bestTarget.getID() || !(this.m.Skill != null && this.m.Skill.isDisengagement() && targetValue >= bestValue * this.Const.AI.Behavior.DisengageMinBetterTargetPct) || targetValue < bestValue * this.Const.AI.Behavior.EngageBestValueMult))
					{
						continue;
					}
				}

				tileScore = tileScore + targetValue * this.Const.AI.Behavior.EngageTargetValueMult;
				scoreBonus = scoreBonus + targetValue * this.Const.AI.Behavior.EngageTargetValueMult;

				if (this.m.Skill != null && distanceFromTarget == 1 && this.m.Skill.isUsableOn(tile))
				{
					isSkillUsable = true;
					tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillBonus;
				}
				else if (this.m.Skill != null && _entity.getActionPointCostsRaw() == this.Const.ImmobileMovementAPCost)
				{
					continue;
				}
				else if (inZonesOfControl > 0 && this.m.Skill != null && this.m.Skill.isDisengagement())
				{
					isSkillUsable = true;
					tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillBonus;
				}
				else if (this.m.Skill != null && distanceFromTarget > 1)
				{
					local canEngage = false;

					for( local i = 0; i != 6; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else if (this.m.Skill.isUsableOn(tile.getNextTile(i), tile))
						{
							canEngage = true;
							tileScore = tileScore + this.Const.AI.Behavior.EngageWithSkillNextTimeBonus;
							break;
						}
					}

					if (!canEngage)
					{
						tileScore = tileScore - this.Const.AI.Behavior.EngageWithSkillBonus;
					}
				}

				if (!isSkillUsable && distanceFromTarget != this.getProperties().EngageRangeIdeal)
				{
					tileScore = tileScore - this.Math.abs(distanceFromTarget - this.getProperties().EngageRangeIdeal) * this.Const.AI.Behavior.EngageNotIdealRangePenalty;
					scoreBonus = scoreBonus - this.Math.abs(distanceFromTarget - this.getProperties().EngageRangeIdeal) * this.Const.AI.Behavior.EngageNotIdealRangePenalty;
				}

				if (engagementsDeclared != 0)
				{
					tileScore = tileScore - engagementsDeclared;
					scoreBonus = scoreBonus - engagementsDeclared;
				}

				if ((this.m.Skill != null || distanceFromTarget == 1) && !isTargetInEnemyZoneOfControl)
				{
					scoreMult = scoreMult * (this.Const.AI.Behavior.EngageLockdownMult * lockDownValue);
					scoreBonus = scoreBonus + this.Const.AI.Behavior.EngageLockOpponentBonus * lockDownValue;
				}

				if (!tile.IsVisibleForEntity)
				{
					tileScore = tileScore - this.Const.AI.Behavior.EngageNotVisiblePenalty;
				}

				tileScore = tileScore + levelDifference * this.Const.AI.Behavior.EngageTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;
				tileScore = tileScore + tile.TVTotal * this.Const.AI.Behavior.EngageTVValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;
				scoreBonus = scoreBonus + (levelDifference * this.Const.AI.Behavior.EngageTerrainLevelBonus + tile.TVTotal * this.Const.AI.Behavior.EngageTVValueMult) * this.getProperties().EngageOnGoodTerrainBonusMult;

				if (zocs > 0)
				{
					tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;
					scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;

					if (zocs > 1 && this.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
					{
						scoreMult = scoreMult * this.Math.pow(1.0 / (this.Const.AI.Behavior.EngageTargetMultipleOpponentsMult * this.getProperties().EngageTargetMultipleOpponentsMult), zocs);
					}

					if (_entity.getIdealRange() > 1)
					{
						tileScore = tileScore - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
						scoreBonus = scoreBonus - zocs * this.Const.AI.Behavior.EngageIntoZocWithReachWeaponPenalty;
					}
				}

				local spearwallMult = this.querySpearwallValueForTile(_entity, tile);

				if (this.m.Skill == null || this.m.Skill.isSpearwallRelevant())
				{
					tileScore = tileScore - this.Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
					scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
				}

				if (this.getProperties().EngageEnemiesInLinePreference > 1)
				{
					for( local d = 0; d < 6; d = ++d )
					{
						if (!tile.hasNextTile(d))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(d);

							for( local k = 0; k < this.getProperties().EngageEnemiesInLinePreference - 1; k = ++k )
							{
								if (!nextTile.hasNextTile(d))
								{
									break;
								}

								nextTile = nextTile.getNextTile(d);

								if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && !nextTile.getEntity().isAlliedWith(_entity))
								{
									local v = this.queryTargetValue(_entity, nextTile.getEntity());
									tileScore = tileScore + v * this.Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
									scoreBonus = scoreBonus + v * this.Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
								}
							}
						}
					}
				}

				if (tile.IsBadTerrain)
				{
					local mult = isTargetArmedWithRangedWeapon ? 0.5 : 1.0;
					tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult * mult;
					scoreBonus = scoreBonus - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult * mult;
				}

				if (this.getProperties().OverallFormationMult != 0)
				{
					local allies = this.queryAllyMagnitude(tile, this.Const.AI.Behavior.EngageAllyFormationMaxDistance);
					local formationValue = 0.0;

					if (allies.Allies != 0)
					{
						formationValue = this.Math.pow(allies.Allies * allies.AverageDistanceScore * (allies.Magnetism / allies.Allies) * this.getProperties().OverallFormationMult * 0.5, this.getProperties().OverallFormationMult * 0.5) * this.Const.AI.Behavior.EngageFormationBonus;
					}

					tileScore = tileScore + formationValue;
					scoreBonus = scoreBonus + formationValue;
				}

				potentialDestinations.push({
					Tile = tile,
					IsSkillUsable = isSkillUsable,
					Actor = t.Actor,
					LevelDifference = levelDifference,
					IsTargetLocked = isTargetInEnemyZoneOfControl,
					IsTargetLockable = distanceFromTarget == 1,
					TargetValue = targetValue,
					LockDownMult = distanceFromTarget == 1 ? lockDownValue : 1.0,
					ScoreBonus = scoreBonus,
					TileScore = tileScore,
					ScoreMult = scoreMult,
					Distance = distance,
					DistanceFromTarget = distanceFromTarget
				});
			}
		}

		if (potentialDestinations.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		local hasShieldWall = _entity.getSkills().hasSkill("effects.shieldwall");
		local canUseShieldWall = !hasShieldWall && _entity.getSkills().hasSkill("actives.shieldwall");
		local hasAdrenaline = _entity.getSkills().hasSkill("actives.adrenaline");
		local bestTarget;
		local bestIntermediateTile;
		local bestTargetDistance = 0;
		local actorTargeted;
		local bestCost = -9999;
		local bestTiles = 0;
		local bestScoreMult = 1.0;
		local bestAP = 0;
		local bestLocked = false;
		local bestLockable = false;
		local bestWaitAfterMove = false;
		local bestWithSkill = false;
		local bestComplete = false;
		local bestWaitBeforeMove = false;
		local bestAttackAfterMove = false;
		local n = 0;
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local navigator = this.Tactical.getNavigator();

		if (potentialDestinations[0].IsSkillUsable && (!this.m.Skill.isDisengagement() || potentialDestinations[0].Distance == 1))
		{
			bestWithSkill = true;
			bestTarget = potentialDestinations[0].Tile;
			bestTargetDistance = 0;
			bestTiles = 1;
			bestAP = this.m.Skill.getActionPointCost();
			bestWaitAfterMove = false;
			bestIntermediateTile = null;
			bestLocked = potentialDestinations[0].IsTargetLocked;
			bestLockable = potentialDestinations[0].IsTargetLockable;
			bestScoreMult = potentialDestinations[0].ScoreMult;
			bestComplete = true;
			actorTargeted = potentialDestinations[0].Actor;
		}
		else
		{
			local entityActionPointCosts = _entity.getActionPointCosts();
			local entityFatiguePointCosts = _entity.getFatigueCosts();
			local hasRangedWeapon = _entity.hasRangedWeapon();

			foreach( t in potentialDestinations )
			{
				n = ++n;

				if (n > this.Const.AI.Behavior.EngageMaxAttempts && bestTarget != null)
				{
					break;
				}

				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}

				local acceptableDistanceFromDest = 0;
				local score = t.ScoreBonus;
				local localScoreMult = 1.0;
				local tiles = 0;
				local intermediateTile = t.Tile;
				local waitAfterMove = false;
				local apCost = 0;
				local useSkill = false;
				local isComplete = false;
				local waitBeforeMove = false;
				local attackAfterMove = false;
				local settings = navigator.createSettings();
				settings.ActionPointCosts = entityActionPointCosts;
				settings.FatigueCosts = entityFatiguePointCosts;
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.MaxLevelDifference = _entity.getMaxTraversibleLevels();
				settings.AllowZoneOfControlPassing = this.m.IsIgnoringZOC;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();
				settings.HiddenCost = this.getProperties().OverallHideMult >= 1 ? -1 : 0;
				settings.HeatCost = this.getAgent().isUsingHeat() && t.Distance >= this.Const.AI.Behavior.EngageMinHeatDistance && this.getProperties().EngageFlankingMult > 1.0 ? this.Const.AI.Behavior.EngageHeatCost : 0;

				if (navigator.findPath(myTile, t.Tile, settings, acceptableDistanceFromDest))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.Tiles == 0 || movementCosts.End.ID == myTile.ID)
					{
						continue;
					}

					score = score - movementCosts.ActionPointsRequired * (1.0 + this.Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult);

					if (this.getProperties().EngageTileLimit != 0 && navigator.NumPathWaypoints > this.getProperties().EngageTileLimit && !this.getStrategy().getStats().IsEngaged)
					{
						local intoFormation = false;
						intoFormation = movementCosts.End.hasNextTile(this.Const.Direction.S) && movementCosts.End.getNextTile(this.Const.Direction.S).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.S).getEntity().getFaction() == _entity.getFaction() && movementCosts.End.getNextTile(this.Const.Direction.S).hasNextTile(this.Const.Direction.S) && movementCosts.End.getNextTile(this.Const.Direction.S).getNextTile(this.Const.Direction.S).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.S).getNextTile(this.Const.Direction.S).getEntity().getFaction() == _entity.getFaction();
						intoFormation = intoFormation || movementCosts.End.hasNextTile(this.Const.Direction.N) && movementCosts.End.getNextTile(this.Const.Direction.N).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.N).getEntity().getFaction() == _entity.getFaction() && movementCosts.End.getNextTile(this.Const.Direction.N).hasNextTile(this.Const.Direction.N) && movementCosts.End.getNextTile(this.Const.Direction.N).getNextTile(this.Const.Direction.N).IsOccupiedByActor && movementCosts.End.getNextTile(this.Const.Direction.N).getNextTile(this.Const.Direction.N).getEntity().getFaction() == _entity.getFaction();

						if (!intoFormation)
						{
							navigator.clipPathToDistance(myTile, this.getProperties().EngageTileLimit);
							waitAfterMove = true;
							movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
							movementCosts.IsComplete = false;
							intermediateTile = movementCosts.End;
						}
					}

					if (AlreadyEngagedWithNum != 0 && !movementCosts.IsComplete)
					{
						continue;
					}

					if (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat() && (hasAdrenaline || _entity.getTurnOrderInitiative() >= 125) && _entity.isAbleToWait() && !this.getStrategy().getStats().IsEngaged && !movementCosts.IsComplete && movementCosts.End.getDistanceTo(t.Tile) == 1 && movementCosts.Tiles > 1 && movementCosts.LastBeforeEnd.IsEmpty)
					{
						navigator.clipPathToDistance(myTile, myTile.getDistanceTo(movementCosts.End) - 1);
						waitAfterMove = true;
						movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
						movementCosts.IsComplete = false;
						intermediateTile = movementCosts.End;
					}

					apCost = movementCosts.ActionPointsRequired;

					if (movementCosts.IsComplete && acceptableDistanceFromDest == 0 && !t.IsTargetLocked && t.IsTargetLockable && !t.Actor.getCurrentProperties().IsImmuneToZoneOfControl && t.LevelDifference >= 0 && (!t.Tile.IsBadTerrain || t.Actor.getTile().IsBadTerrain))
					{
						score = score + this.Const.AI.Behavior.EngageLockOpponentBonus * this.getProperties().EngageLockDownTargetMult * t.LockDownMult;
					}

					if (_entity.getActionPoints() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
					{
						score = score + this.Const.AI.Behavior.EngageReachAndAttackBonus;
						attackAfterMove = true;
					}

					local willRunIntoSpearwall = this.querySpearwallValueForTile(_entity, movementCosts.End) != 0;

					if (inZonesOfControl > 0 && t.IsSkillUsable && this.m.Skill != null && this.m.Skill.isDisengagement())
					{
						if (this.m.Skill.isUsableOn(movementCosts.First))
						{
							useSkill = true;
							intermediateTile = movementCosts.First;
						}
						else
						{
							for( ; inZonesOfControl > 1;  )
							{
							}
						}
					}
					else if ((this.m.Skill == null || this.m.Skill.isSpearwallRelevant()) && (canUseShieldWall || hasRangedWeapon) && _entity.getActionPoints() < movementCosts.ActionPointsRequired + 4 && willRunIntoSpearwall && this.getProperties().EngageAgainstSpearwallMult != 0.0)
					{
						if (movementCosts.LastBeforeEnd.IsEmpty)
						{
							intermediateTile = movementCosts.LastBeforeEnd;
							waitAfterMove = true;
						}
						else if (_entity.isAbleToWait())
						{
							intermediateTile = myTile;
							waitAfterMove = true;
						}
					}
					else if (movementCosts.IsComplete && this.getProperties().EngageRangeMax == 1 && (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat()) && !this.getStrategy().getStats().IsBeingKited && !this.getProperties().IgnoreTargetValueOnEngage && (!useSkill || !this.m.Skill.isAttack()) && _entity.getActionPointsMax() >= 8 && _entity.getActionPoints() - movementCosts.ActionPointsRequired < apRequiredForAttack && !t.Actor.isTurnDone() && t.Actor.getActionPoints() >= 6 && t.Actor.getIdealRange() < 2 && (hasAdrenaline || _entity.getTurnOrderInitiative() * t.Actor.getCurrentProperties().InitiativeAfterWaitMult > t.Actor.getTurnOrderInitiative()) && !t.IsTargetLocked && t.TargetValue <= 1.0 && t.LockDownMult < this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult && _entity.isAbleToWait() && inZonesOfControl == 0)
					{
						waitBeforeMove = true;
					}
					else if (movementCosts.IsComplete && this.getProperties().EngageRangeMax == 1 && this.getStrategy().getStats().EnemyRangedReadyRatio <= this.getStrategy().getStats().AllyRangedReadyRatio + 0.5 && !this.getStrategy().getStats().IsBeingKited && (this.getProperties().PreferCarefulEngage && !this.Tactical.State.isAutoRetreat()) && !this.getProperties().IgnoreTargetValueOnEngage && (!useSkill || !this.m.Skill.isAttack()) && _entity.getActionPointsMax() >= 8 && _entity.getActionPoints() - movementCosts.ActionPointsRequired < apRequiredForAttack && (!willRunIntoSpearwall || useSkill && !this.m.Skill.isSpearwallRelevant()) && !t.IsTargetLocked && t.TargetValue <= 1.0 && t.LockDownMult < this.Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult && !this.isEngageRecommended(_entity, t.Tile))
					{
						local alternative;
						local nextToLastAlternative;

						for( local i = 0; i < 6; i = ++i )
						{
							if (!movementCosts.LastBeforeEnd.hasNextTile(i))
							{
							}
							else
							{
								local h = movementCosts.LastBeforeEnd.getNextTile(i);

								if (!h.IsEmpty)
								{
								}
								else if (h.getDistanceTo(movementCosts.End) > movementCosts.End.getDistanceTo(movementCosts.LastBeforeEnd))
								{
								}
								else if (entityActionPointCosts[h.Type] > entityActionPointCosts[movementCosts.End.Type])
								{
								}
								else if (h.hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
								{
								}
								else if (h.IsEmpty && (nextToLastAlternative == null || h.TVLevelDisadvantage < nextToLastAlternative.TVLevelDisadvantage || nextToLastAlternative.IsBadTerrain && !h.IsBadTerrain))
								{
									nextToLastAlternative = h;
								}
							}
						}

						if (movementCosts.Tiles == 1 && _entity.getActionPointsMax() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
						{
							alternative = myTile;
						}
						else if (movementCosts.LastBeforeEnd.IsEmpty && movementCosts.Tiles > 1 && movementCosts.LastBeforeEnd.ID != movementCosts.End.ID)
						{
							alternative = movementCosts.LastBeforeEnd;
						}
						else if (nextToLastAlternative != null)
						{
							alternative = nextToLastAlternative;
						}
						else if (movementCosts.Tiles == 2 && !movementCosts.LastBeforeEnd.IsEmpty && _entity.getActionPointsMax() - movementCosts.ActionPointsRequired >= apRequiredForAttack)
						{
							alternative = myTile;
						}
						else if (movementCosts.SecondLastBeforeEnd.IsEmpty && !movementCosts.LastBeforeEnd.IsEmpty && movementCosts.Tiles > 2 && _entity.getActionPointsMax() - (entityActionPointCosts[movementCosts.End.Type] + entityActionPointCosts[movementCosts.LastBeforeEnd.Type]) >= apRequiredForAttack)
						{
							alternative = movementCosts.SecondLastBeforeEnd;
						}

						if (alternative != null && alternative.ID == myTile.ID)
						{
							intermediateTile = myTile;
						}
						else if (alternative != null && alternative.ID != myTile.ID && (!alternative.IsBadTerrain || t.Tile.IsBadTerrain) && alternative.Level >= t.Tile.Level)
						{
							if (navigator.findPath(myTile, alternative, settings, 0))
							{
								intermediateTile = alternative;
								waitAfterMove = true;
							}
						}
					}
					else if (this.getProperties().EngageRangeIdeal > 1 && t.DistanceFromTarget < this.getProperties().EngageRangeIdeal && movementCosts.IsComplete && this.getProperties().PreferCarefulEngage && _entity.getActionPointsMax() >= 8 && !willRunIntoSpearwall)
					{
						local alternative;

						if (movementCosts.SecondLastBeforeEnd.IsEmpty && movementCosts.LastBeforeEnd.IsOccupiedByActor && movementCosts.Tiles > 2 && !movementCosts.LastBeforeEnd.hasZoneOfControlOtherThan(movementCosts.LastBeforeEnd.getEntity().getAlliedFactions()) && !movementCosts.LastBeforeEnd.getEntity().getCurrentProperties().IsRooted)
						{
							alternative = movementCosts.SecondLastBeforeEnd;
						}

						if (alternative != null && t.TargetValue <= 0.9 && (!alternative.IsBadTerrain || t.Tile.IsBadTerrain))
						{
							intermediateTile = alternative;
							waitAfterMove = true;
						}
					}
					else if (!movementCosts.IsComplete && !this.getProperties().IgnoreTargetValueOnEngage && movementCosts.End.IsEmpty)
					{
						intermediateTile = movementCosts.End;

						if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0 && !movementCosts.End.isSameTileAs(movementCosts.LastBeforeEnd) && !movementCosts.LastBeforeEnd.isSameTileAs(myTile))
						{
							local actualDanger = false;

							for( local i = 0; i < 6; i = ++i )
							{
								if (!movementCosts.End.hasNextTile(i))
								{
								}
								else
								{
									local h = movementCosts.End.getNextTile(i);

									if (h.IsEmpty && (h.Level > movementCosts.End.Level || movementCosts.End.IsBadTerrain && !h.IsBadTerrain))
									{
										actualDanger = true;
										break;
									}
								}
							}

							if (actualDanger)
							{
								local alternateDest = movementCosts.End;
								local fallBackToLastBeforeEnd = false;

								if (movementCosts.LastBeforeEnd.IsEmpty && (movementCosts.End.TVLevelDisadvantage > movementCosts.LastBeforeEnd.TVLevelDisadvantage || movementCosts.End.IsBadTerrain && !movementCosts.LastBeforeEnd.IsBadTerrain))
								{
									alternateDest = movementCosts.LastBeforeEnd;
									fallBackToLastBeforeEnd = true;
								}

								for( local i = 0; i < 6; i = ++i )
								{
									if (!movementCosts.LastBeforeEnd.hasNextTile(i))
									{
									}
									else
									{
										local h = movementCosts.LastBeforeEnd.getNextTile(i);

										if (!h.IsEmpty)
										{
										}
										else if (h.getDistanceTo(movementCosts.End) > movementCosts.End.getDistanceTo(movementCosts.LastBeforeEnd))
										{
										}
										else if (h.hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
										{
										}
										else if (h.IsEmpty && h.TVLevelDisadvantage < alternateDest.TVLevelDisadvantage || alternateDest.IsBadTerrain && !h.IsBadTerrain)
										{
											alternateDest = h;
										}
									}
								}

								if (navigator.findPath(myTile, alternateDest, settings, 0))
								{
									intermediateTile = alternateDest;
									score = score + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus;
									waitAfterMove = true;
								}
								else if (fallBackToLastBeforeEnd)
								{
									intermediateTile = movementCosts.LastBeforeEnd;
									score = score + this.Const.AI.Behavior.EngageAvoidDisadvantageBonus;
									waitAfterMove = true;
								}
							}
						}

						if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
						{
							score = score - this.Const.AI.Behavior.EngageLevelDisadvantagePenalty * intermediateTile.TVLevelDisadvantage;

							if (movementCosts.LastBeforeEnd.TVLevelDisadvantage > 0)
							{
								localScoreMult = localScoreMult * this.Math.pow(this.Const.AI.Behavior.EngageLevelDisadvantageMult, intermediateTile.TVLevelDisadvantage);
							}

							if (intermediateTile.IsBadTerrain)
							{
								score = score - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
							}
						}
					}

					tiles = movementCosts.Tiles;
					isComplete = intermediateTile.ID == t.Tile.ID;
				}
				else
				{
					continue;
				}

				if (intermediateTile.IsHidingEntity)
				{
					score = score + this.Const.AI.Behavior.EngageEndTurnHiddenBonus * this.getProperties().OverallHideMult;
				}

				if (score > bestCost)
				{
					bestCost = score;
					bestTarget = intermediateTile;
					bestTargetDistance = 0;
					bestWaitAfterMove = waitAfterMove;
					bestTiles = tiles;
					bestIntermediateTile = useSkill || t.Tile.isSameTileAs(intermediateTile) ? null : intermediateTile;
					bestLocked = t.IsTargetLocked;
					bestLockable = t.IsTargetLockable;
					bestScoreMult = t.ScoreMult * localScoreMult;
					bestAP = apCost;
					bestWithSkill = useSkill;
					bestComplete = isComplete;
					bestWaitBeforeMove = waitBeforeMove;
					bestAttackAfterMove = attackAfterMove;
					actorTargeted = t.Actor;
				}
			}
		}

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		if (bestTarget != null && bestTiles != 0 && bestTarget.ID != myTile.ID)
		{
			if (this.m.IsEngagedThisTurn && !bestComplete)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			if ((this.m.Skill == null || this.m.Skill.isSpearwallRelevant()) && this.getProperties().PreferCarefulEngage && this.getProperties().EngageAgainstSpearwallMult != 0.0 && !hasShieldWall && !canUseShieldWall && _entity.isAbleToWait() && this.querySpearwallValueForTile(_entity, bestTarget) != 0.0)
			{
				local allies = this.getAgent().getKnownAllies();

				foreach( ally in allies )
				{
					if (ally.isTurnDone())
					{
						continue;
					}

					if (ally.getMoraleState() == this.Const.MoraleState.Fleeing || ally.getCurrentProperties().IsRooted || ally.getCurrentProperties().IsStunned)
					{
						continue;
					}

					if (ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(bestTarget) > 5)
					{
						continue;
					}

					if (ally.isArmedWithShield())
					{
						return this.Const.AI.Behavior.Score.Zero;
					}
				}
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			this.m.TargetTile = bestTarget;
			this.m.TargetActor = actorTargeted;
			this.m.TargetDistance = bestTargetDistance;
			this.m.IsWaitingAfterMove = bestWaitAfterMove;
			this.m.IsWaitingBeforeMove = bestWaitBeforeMove;

			if (!this.getProperties().IgnoreTargetValueOnEngage && bestComplete)
			{
				score = score * (1.0 + this.queryTargetValue(_entity, actorTargeted));
			}

			if (bestWaitBeforeMove)
			{
				this.logInfo("Waiting before move!");
			}

			score = score * bestScoreMult;
			this.getAgent().getIntentions().Target = actorTargeted;
			this.getAgent().getIntentions().TargetTile = bestTarget;
			this.getAgent().getIntentions().IntermediateTargetTile = bestIntermediateTile;
			this.getAgent().getIntentions().APToReachTarget = bestAP;
			local actorTile = actorTargeted.getTile();

			if (bestWithSkill)
			{
				score = score * this.Const.AI.Behavior.EngageWithSkillMult;
			}
			else
			{
				this.m.Skill = null;
			}

			if (bestAttackAfterMove)
			{
				score = score * this.Const.AI.Behavior.EngageAndAttackMult;
			}

			if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
			{
				if (bestTarget.Level - actorTile.Level > 0)
				{
					score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
				}
				else if (bestTarget.Level - actorTile.Level < 0)
				{
					score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
				}

				if (!bestLocked && bestLockable && bestTarget.Level - myTile.Level < 0)
				{
					score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
				}
				else if (!bestLocked && bestLockable && bestTarget.Level - myTile.Level > 0)
				{
					score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
				}

				if (bestIntermediateTile != null)
				{
					if (bestIntermediateTile.Level - actorTargeted.getTile().Level > 0)
					{
						score = score * this.Const.AI.Behavior.EngageOnLevelDifferenceMult;
					}
					else if (bestIntermediateTile.Level - actorTargeted.getTile().Level < 0)
					{
						score = score * (1.0 / this.Const.AI.Behavior.EngageOnLevelDifferenceMult);
					}
				}
			}

			if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
			{
				if (bestTarget.IsBadTerrain)
				{
					score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
				}

				if (bestIntermediateTile != null && bestTarget.IsBadTerrain)
				{
					score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
				}

				if (!myTile.IsBadTerrain && (bestTarget.IsBadTerrain || bestIntermediateTile != null && bestIntermediateTile.IsBadTerrain))
				{
					score = score * this.Const.AI.Behavior.EngageOnBadTerrainMult;
				}
			}

			if (this.getProperties().EngageOnGoodTerrainBonusMult != 0.0)
			{
				if (!this.m.TargetTile.IsBadTerrain && this.m.TargetActor.getTile().IsBadTerrain && bestIntermediateTile == null)
				{
					score = score * this.Const.AI.Behavior.EngageOnTerrainAdvantage;
				}

				if (myTile.IsBadTerrain && (!bestTarget.IsBadTerrain || bestIntermediateTile != null && !bestIntermediateTile.IsBadTerrain))
				{
					score = score * this.Const.AI.Behavior.EngageOnTerrainAdvantage;
				}
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			if (this.m.Skill == null || this.m.Skill.isSpearwallRelevant())
			{
				local spearwallMult = this.querySpearwallValueForTile(_entity, this.m.TargetTile);

				if (spearwallMult == 0.0 && bestIntermediateTile != null)
				{
					spearwallMult = this.querySpearwallValueForTile(_entity, bestIntermediateTile);
				}

				score = score * this.Math.maxf(0.1, 1.0 - spearwallMult * 0.5);
			}

			if (AlreadyEngagedWithNum == 0)
			{
				local allyMag = this.queryAllyMagnitude(bestTarget, this.Const.AI.Behavior.EngageAllyOpponentToAllyDistance);
				local opponentMag = this.queryOpponentMagnitude(bestTarget, this.Const.AI.Behavior.EngageAllyOpponentToAllyDistance);
				local allyVSopponent = this.Math.maxf(1.0, allyMag.Allies * allyMag.AverageDistanceScore) / this.Math.maxf(1.0, opponentMag.Opponents * opponentMag.AverageDistanceScore);
				score = score * (1.0 - this.Const.AI.Behavior.EngageAllyVsOpponentMult + allyVSopponent * this.Const.AI.Behavior.EngageAllyVsOpponentMult);

				if (allyMag.Allies != 0)
				{
					score = this.Math.maxf(score, this.interpolate(score, allyMag.AverageEngaged, 0.5));
				}

				score = score * this.Math.maxf(1.0, this.Math.minf(this.Const.AI.Behavior.EngageInertiaMaxMult, this.m.Inertia * this.Const.AI.Behavior.EngageInertiaMult));
			}

			return this.Const.AI.Behavior.Score.Engage * score * this.Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
		}
		else if (AlreadyEngagedWithNum == 0 && bestTarget != null && bestTarget.ID == myTile.ID && bestWaitAfterMove && _entity.isAbleToWait() && (_entity.getActionPoints() >= 4 || _entity.getActionPoints() >= 2 && this.Tactical.TurnSequenceBar.isAllyStillToAct(_entity)))
		{
			this.m.IsWaitingBeforeMove = true;
			return this.Const.AI.Behavior.Score.Engage * score * this.Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
		}

		return this.Const.AI.Behavior.Score.Zero;
	}

	function onTurnStarted()
	{
		this.m.Inertia = this.Math.maxf(0, this.m.Inertia - 1);
		this.m.IsDoneThisTurn = false;
		this.m.IsEngagedThisTurn = false;
	}

	function onTurnResumed()
	{
		this.m.IsDoneThisTurn = false;
		this.m.IsEngagedThisTurn = false;
	}

	function onBeforeExecute( _entity )
	{
		this.getAgent().getOrders().IsEngaging = true;
		this.getAgent().getOrders().IsDefending = false;
		this.getAgent().getIntentions().IsDefendingPosition = false;
		this.getAgent().getIntentions().IsEngaging = true;
		this.m.Inertia += 2;

		if (this.m.IsWaitingAfterMove)
		{
			this.m.IsDoneThisTurn = true;
		}
	}

	function onExecute( _entity )
	{
		if ((this.getProperties().PreferWait || this.m.IsWaitingBeforeMove) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
			}

			return true;
		}

		if (this.m.TargetTile != null)
		{
			local navigator = this.Tactical.getNavigator();

			if (this.m.IsFirstExecuted)
			{
				if (this.m.Skill != null)
				{
					this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
					this.m.Skill.use(this.m.TargetTile);
				}
				else
				{
					this.m.OriginTile = _entity.getTile();
					local settings = navigator.createSettings();
					settings.ActionPointCosts = _entity.getActionPointCosts();
					settings.FatigueCosts = _entity.getFatigueCosts();
					settings.FatigueCostFactor = 0.0;
					settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
					settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
					settings.MaxLevelDifference = _entity.getMaxTraversibleLevels();
					settings.AllowZoneOfControlPassing = this.m.IsIgnoringZOC;
					settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
					settings.AlliedFactions = _entity.getAlliedFactions();
					settings.Faction = _entity.getFaction();
					settings.HiddenCost = this.getProperties().OverallHideMult >= 1 ? -1 : 0;
					settings.HeatCost = this.getAgent().isUsingHeat() && this.m.OriginTile.getDistanceTo(this.m.TargetTile) >= this.Const.AI.Behavior.EngageMinHeatDistance && this.getProperties().EngageFlankingMult > 1.0 ? this.Const.AI.Behavior.EngageHeatCost : 0;

					if (this.Const.AI.VerboseMode)
					{
						this.logInfo("* " + _entity.getName() + ": Engaging to melee range with " + this.m.TargetActor.getName() + " (" + (this.m.TargetActor.getTile().IsVisibleForEntity ? "visible" : "not visible") + "), accepted_distance=" + this.m.TargetDistance + ", value=" + this.queryTargetValue(_entity, this.m.TargetActor));
					}

					if (!navigator.findPath(this.m.OriginTile, this.m.TargetTile, settings, this.m.TargetDistance))
					{
						this.logWarning("* " + _entity.getName() + ": Failed to execute path for Melee Engage - No path found");
						return true;
					}

					if (this.Const.AI.PathfindingDebugMode)
					{
						navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
					}

					local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
					this.m.Agent.adjustCameraToDestination(movement.End);
					this.m.IsFirstExecuted = false;
					return false;
				}
			}

			if (this.m.Skill != null)
			{
				if (!this.Tactical.getNavigator().isTravelling(_entity))
				{
					this.m.TargetTile = null;
					this.m.TargetActor = null;
					this.m.OriginTile = null;
					this.m.Skill = null;
					return true;
				}
			}
			else if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				if (_entity.isAlive())
				{
					if (this.m.TargetActor != null && this.m.TargetActor.getAIAgent() != null && _entity.getTile().getDistanceTo(this.m.TargetTile) < this.Const.AI.Behavior.EngageMaxDistance)
					{
						this.m.TargetActor.getAIAgent().declareEngagement(_entity);
					}

					if (!_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
					{
						this.m.IsEngagedThisTurn = true;
					}
				}

				if (_entity.isAlive() && !_entity.isHiddenToPlayer() && _entity.getActionPoints() >= this.Const.Movement.AutoEndTurnBelowAP)
				{
					this.getAgent().declareAction();
				}

				if (this.Const.AI.VerboseMode)
				{
					if (_entity.getTile().ID == this.m.TargetTile.ID)
					{
						this.logInfo("* " + _entity.getName() + ": Reached engage destination");
					}
					else
					{
						this.logInfo("* " + _entity.getName() + ": Stopped before reaching destination");
					}
				}

				this.m.TargetTile = null;
				this.m.TargetActor = null;
				this.m.OriginTile = null;
				this.m.TargetDistance = 0;
				return true;
			}
			else
			{
				return false;
			}
		}

		return true;
	}

	function onSortByScore( _a, _b )
	{
		if (_a.TileScore > _b.TileScore)
		{
			return -1;
		}
		else if (_a.TileScore < _b.TileScore)
		{
			return 1;
		}

		return 0;
	}

	function isEngageRecommended( _entity, _tile )
	{
		for( local i = 0; i < 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else
			{
				local t = _tile.getNextTile(i);

				if (!t.IsOccupiedByActor)
				{
				}
				else
				{
					local target = t.getEntity();

					if (target.isNonCombatant() || target.isAlliedWith(_entity))
					{
					}
					else if (target.getCurrentProperties().IsStunned || !target.getCurrentProperties().IsAbleToUseWeaponSkills || target.isTurnDone() || target.getActionPoints() <= 5)
					{
					}
					else if (target.getIdealRange() >= 2)
					{
					}
					else
					{
						return false;
					}
				}
			}
		}

		return true;
	}

});

