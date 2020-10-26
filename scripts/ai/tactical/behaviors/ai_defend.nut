this.ai_defend <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetInfo = null,
		IsHoldingPosition = false,
		IsWaitingBeforeMove = false,
		IsWaitingAfterMove = false,
		IsDoneThisTurn = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Defend;
		this.m.Order = this.Const.AI.Behavior.Order.Defend;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.TargetInfo = null;
		this.m.IsHoldingPosition = false;
		this.m.IsWaitingAfterMove = false;
		this.m.IsWaitingBeforeMove = false;
		local score = this.getProperties().BehaviorMult[this.m.ID];

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

		if (_entity.getFaction() == this.Const.Faction.Player || _entity.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getStrategy().isDefending())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.isRangedUnit(_entity) && !_entity.isArmedWithRangedWeapon())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageRanged) != null && (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageRanged).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageRanged).isUsedThisTurn()) || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackBow) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackBow).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackHandgonne) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackHandgonne).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Reload) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Reload).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null && (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Protect).getScore() > 0 || this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Protect).isDoneThisTurn()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.getProperties().EngageRangeMax).len() != 0)
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
				return this.Const.AI.Behavior.Score.Defend * score;
			}
		}

		if (this.getAgent().getIntentions().IsDefendingPosition)
		{
			score = score * this.Const.AI.Behavior.DefendAlreadyDoneMult;
		}

		local targetTile = this.getAgent().getIntentions().IntermediateTargetTile;

		if (targetTile == null)
		{
			targetTile = this.getAgent().getIntentions().TargetTile;
		}

		if (targetTile != null && targetTile.IsBadTerrain)
		{
			score = score * this.Const.AI.Behavior.DefendAvoidBadTerrainMult;
		}

		if (targetTile != null && targetTile.Properties.Effect != null && !targetTile.Properties.Effect.IsPositive && targetTile.Properties.Effect.Applicable(_entity))
		{
			score = score * this.Const.AI.Behavior.DefendAvoidBadTerrainMult;
		}

		local potentialDanger = this.getPotentialDanger(false);
		local func = this.selectBestTargetTile(_entity, targetTile, this.Const.AI.Behavior.DefendMaxSearchRange, potentialDanger);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.IsHoldingPosition = _entity.getTile().isSameTileAs(this.m.TargetTile);

		if (this.m.IsHoldingPosition && this.getAgent().getIntentions().IsRecuperating)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}
		else if (this.m.IsHoldingPosition && _entity.isArmedWithRangedWeapon())
		{
			local item = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item.getAmmoMax() == 0 || item.getAmmo() > 0)
			{
				local targets = this.queryTargetsInMeleeRange(2, this.Math.min(item.getRangeMax(), _entity.getCurrentProperties().Vision));
				score = score * this.Math.pow(this.Const.AI.Behavior.DefendUseRangedWeaponMult, targets.len());
			}
		}

		return this.Const.AI.Behavior.Score.Defend * score;
	}

	function onTurnStarted()
	{
		this.m.IsDoneThisTurn = false;
	}

	function onBeforeExecute( _entity )
	{
		this.getAgent().getOrders().IsEngaging = false;
		this.getAgent().getOrders().IsDefending = true;
		this.getAgent().getIntentions().IsDefendingPosition = true;
		this.getAgent().getIntentions().IsEngaging = false;

		if (this.m.IsWaitingAfterMove)
		{
			this.m.IsDoneThisTurn = true;
		}
	}

	function onExecute( _entity )
	{
		if (this.m.IsWaitingBeforeMove && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
			}

			return true;
		}

		if (!this.m.IsHoldingPosition)
		{
			local navigator = this.Tactical.getNavigator();

			if (this.m.IsFirstExecuted)
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
				navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, 0);

				if (this.Const.AI.PathfindingDebugMode)
				{
					navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				}

				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				this.m.Agent.adjustCameraToDestination(movement.End);

				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Going for defensive position.");
				}

				this.m.IsFirstExecuted = false;
				return;
			}

			if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				this.m.TargetTile = null;
				this.m.TargetInfo = null;
				return true;
			}
		}
		else
		{
			if (this.Tactical.TurnSequenceBar.hasEnemiesLeftToAct(_entity.getFaction()) && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
			{
				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
				}
			}
			else
			{
				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Holding defensive position.");
				}

				this.getAgent().getIntentions().IsRecuperating = true;
			}

			this.m.TargetTile = null;
			this.m.TargetInfo = null;
			return true;
		}

		return false;
	}

	function selectBestTargetTile( _entity, _targetTile, _maxRange, _potentialDanger )
	{
		// Function is a generator.
		local navigator = this.Tactical.getNavigator();
		local settings = navigator.createSettings();
		local myTile = _entity.getTile();
		local myFaction = _entity.getFaction();
		yield null;
		local tiles = {
			Behavior = this,
			Actor = _entity,
			Origin = myTile,
			TargetTile = _targetTile,
			Range = _maxRange,
			Tiles = []
		};
		this.onQueryTargetTile(myTile, tiles);
		this.Tactical.queryTilesInRange(_entity.getTile(), 1, _maxRange, true, this.Const.AI.Behavior.DefendTerrainMinTV, _entity.getAlliedFactions(), this.onQueryTargetTile, tiles);
		yield null;
		local entityIsRangedUnit = this.isRangedUnit(_entity);
		tiles.Tiles.sort(this.onSortByScore);
		local attempts = 0;
		local time = this.Time.getExactTime();
		local bestDestination;
		local bestDestinationInfo;
		local bestScore = 9000;
		local bestIsForNextTurn = false;
		local bestWaitAfterMove = false;
		local myTile = _entity.getTile();
		local targets = [];
		local actors = this.m.Agent.getKnownOpponents();

		foreach( a in actors )
		{
			if (a.Actor.isNull())
			{
				continue;
			}

			if (this.isRangedUnit(a.Actor) || myTile.getDistanceTo(a.Actor.getTile()) <= 8)
			{
				targets.push(a.Actor);
			}
		}

		if (targets.len() == 0)
		{
			foreach( a in actors )
			{
				if (a.Actor.isNull())
				{
					continue;
				}

				targets.push(a.Actor);
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

		foreach( t in tiles.Tiles )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local isForNextTurn = false;
			local apCost = 0;
			local finalTile = t.Tile;
			local waitAfterMove = false;
			attempts = ++attempts;

			if (attempts > this.Const.AI.Behavior.DefendMaxAttempts)
			{
				break;
			}

			if (this.getStrategy().isDefendingCamp())
			{
				local d = t.Tile.getDistanceTo(centerTile);

				for( ; d > this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius + 1;  )
				{
				}
			}

			local movementCosts;

			if (!t.Tile.isSameTileAs(myTile))
			{
				settings.ActionPointCosts = _entity.getActionPointCosts();
				settings.FatigueCosts = _entity.getFatigueCosts();
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();

				if (navigator.findPath(myTile, t.Tile, settings, 0))
				{
					movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
					apCost = apCost + movementCosts.ActionPointsRequired;
					finalTile = movementCosts.End;
					isForNextTurn = false;
					waitAfterMove = false;

					if (!movementCosts.IsComplete)
					{
						if (movementCosts.Tiles == 0)
						{
							isForNextTurn = true;
						}
						else
						{
							waitAfterMove = true;
						}
					}

					if (!movementCosts.IsComplete)
					{
						local inDanger = false;

						foreach( d in _potentialDanger )
						{
							if (this.isAllottedTimeReached(time))
							{
								yield null;
								time = this.Time.getExactTime();
							}

							if (this.queryActorTurnsNearTarget(d, finalTile, _entity).Turns <= 1.0)
							{
								inDanger = true;
								break;
							}
						}

						if (inDanger)
						{
							local dist = finalTile.getDistanceTo(myTile);
							local scoreBonus = finalTile.TVTotal * this.Const.AI.Behavior.DefendTerrainValueMult;
							t.ScoreBonus = scoreBonus;
						}
					}
				}
				else
				{
					continue;
				}
			}

			if (entityIsRangedUnit)
			{
				foreach( d in _potentialDanger )
				{
					if (this.queryActorTurnsNearTarget(d, finalTile, _entity).Turns <= 1.0)
					{
						t.ScoreBonus -= this.Const.AI.Behavior.DefendRangedWeaponDanger;
						break;
					}
				}
			}

			local dirs = [
				0,
				0,
				0,
				0,
				0,
				0
			];

			foreach( opponent in targets )
			{
				local dir = t.Tile.getDirection8To(opponent.getTile());
				local mult = this.isRangedUnit(opponent) ? 2 : 1;
				mult = mult * (7.0 / t.Tile.getDistanceTo(opponent.getTile()));

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
					local dir = t.Tile.getDirectionTo(opponent.getTile());
					local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
					local dir_right = dir + 1 < 6 ? dir + 1 : 0;
					dirs[dir] += 4 * mult;
					dirs[dir_left] += 3 * mult;
					dirs[dir_right] += 3 * mult;
					break;
				}
			}

			local coverBonus = 0.0;

			if (entityIsRangedUnit || _entity.isArmedWithMeleeWeapon() && !_entity.isArmedWithShield())
			{
				for( local i = 0; i < 6; i = ++i )
				{
					if (!t.Tile.hasNextTile(i))
					{
					}
					else
					{
						local adjacentTile = t.Tile.getNextTile(i);

						if (dirs[i] >= 8 && !adjacentTile.IsEmpty && adjacentTile.getEntity().getID() != _entity.getID() && (!adjacentTile.IsOccupiedByActor || !this.isRangedUnit(adjacentTile.getEntity())))
						{
							coverBonus = coverBonus + dirs[i] / targets.len() * this.Const.AI.Behavior.DefendSeekCoverMult;
						}
					}
				}
			}

			local allyDefendBonus = 0.0;

			if (!entityIsRangedUnit && _entity.getCurrentProperties().TargetAttractionMult <= 1.0)
			{
				local importantAllies = [];
				local secondaryAllies = [];

				for( local i = 0; i < 6; i = ++i )
				{
					if (!t.Tile.hasNextTile(i))
					{
					}
					else
					{
						local adjacentTile = t.Tile.getNextTile(i);

						if (!adjacentTile.IsOccupiedByActor)
						{
						}
						else
						{
							local entity = adjacentTile.getEntity();

							if (entity.getFaction() == _entity.getFaction())
							{
								if (entity.getCurrentProperties().TargetAttractionMult > 1.0 || this.isRangedUnit(entity))
								{
									importantAllies.push(entity);
								}
								else if (_entity.isArmedWithShield() && !entity.isArmedWithShield())
								{
									secondaryAllies.push(entity);
								}
							}
						}
					}
				}

				if (importantAllies.len() == 0)
				{
					importantAllies = secondaryAllies;
				}

				foreach( a in importantAllies )
				{
					local tile = a.getTile();
					local checkDirs = [];
					checkDirs.push(tile.getDirectionTo(t.Tile));
					checkDirs.push(checkDirs[0] - 1 >= 0 ? checkDirs[0] - 1 : this.Const.Direction.COUNT - 1);
					checkDirs.push(checkDirs[0] + 1 < this.Const.Direction.COUNT ? checkDirs[0] + 1 : 0);
					local hasCover = false;

					foreach( d in checkDirs )
					{
						if (!tile.hasNextTile(d))
						{
							continue;
						}

						local next = tile.getNextTile(d);

						if (next.IsEmpty || myTile.isSameTileAs(next))
						{
							continue;
						}

						if (next.IsOccupiedByActor)
						{
							local occupant = next.getEntity();

							if (occupant.isAlliedWith(_entity) && (occupant.getCurrentProperties().TargetAttractionMult > 1.0 || this.isRangedUnit(occupant)))
							{
								continue;
							}
						}

						hasCover = true;
						break;
					}

					allyDefendBonus = allyDefendBonus + dirs[checkDirs[0]] / targets.len() * this.Const.AI.Behavior.DefendImportantAllyPosMult * (!hasCover ? this.Const.AI.Behavior.DefendImportantAllyPosMult : 1.0) * a.getCurrentProperties().TargetAttractionMult;
				}
			}

			if (this.getStrategy().isDefendingCamp())
			{
				if (movementCosts != null && !movementCosts.IsComplete)
				{
					local d = movementCosts.End.getDistanceTo(centerTile);

					if (d > this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius + 1)
					{
						t.ScoreBonus -= this.Const.AI.Behavior.DefendAtPalisadeBonus;
					}
				}

				local d = t.Tile.getDistanceTo(centerTile);

				if (d == this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius || d == this.Const.Tactical.Settings.CampRadius + this.Tactical.State.getStrategicProperties().LocationTemplate.AdditionalRadius - 1)
				{
					t.ScoreBonus += this.Const.AI.Behavior.DefendAtPalisadeBonus;
				}
			}

			local score = apCost - t.ScoreBonus - allyDefendBonus - coverBonus;

			if (score < bestScore)
			{
				bestDestination = t.Tile;
				bestDestinationInfo = t;
				bestIsForNextTurn = isForNextTurn;
				bestWaitAfterMove = waitAfterMove;
				bestScore = score;
			}
		}

		if (bestDestination != null && bestIsForNextTurn == false)
		{
			this.m.TargetInfo = bestDestinationInfo;
			this.m.TargetTile = bestDestination;
			this.m.IsWaitingAfterMove = bestWaitAfterMove;
			return true;
		}

		return false;
	}

	function onQueryTargetTile( _tile, _tag )
	{
		local dist = _tile.getDistanceTo(_tag.Origin);
		local score = _tile.Level * 2.0 + _tile.TVTotal - dist * 2.0;
		local scoreBonus = _tile.Level + _tile.TVTotal * this.Const.AI.Behavior.DefendTerrainValueMult;

		if (_tile.Properties.Effect != null && !_tile.Properties.Effect.IsPositive && _tile.Properties.Effect.Applicable(_tag.Actor))
		{
			score = score - this.Const.AI.Behavior.DefendAvoidTileEffectPenalty;
			scoreBonus = scoreBonus - this.Const.AI.Behavior.DefendAvoidTileEffectPenalty;
		}

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else if (!_tile.getNextTile(i).IsEmpty)
			{
				score = score + 1;
			}
		}

		_tag.Tiles.push({
			Tile = _tile,
			Score = score,
			ScoreBonus = scoreBonus,
			Allies = 0.0,
			Opponents = 0.0
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

	function onSortByLowestScore( _d1, _d2 )
	{
		if (_d1.Score > _d2.Score)
		{
			return 1;
		}
		else if (_d1.Score < _d2.Score)
		{
			return -1;
		}

		return 0;
	}

});

