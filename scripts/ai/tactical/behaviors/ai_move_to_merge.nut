this.ai_move_to_merge <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		IsWaiting = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.MoveToMerge;
		this.m.Order = this.Const.AI.Behavior.Order.MoveToMerge;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.IsWaiting = false;
		local time = this.Time.getExactTime();
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
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

		if (_entity.getSize() >= 3)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local currentCount = 0;

		for( local j = 0; j < 6; j = ++j )
		{
			if (!myTile.hasNextTile(j))
			{
			}
			else if (myTile.getNextTile(j).IsOccupiedByActor && myTile.getNextTile(j).getEntity().getType() == this.Const.EntityType.SandGolem && myTile.getNextTile(j).getEntity().getSize() == _entity.getSize())
			{
				currentCount = ++currentCount;
			}
		}

		if (currentCount >= 2)
		{
			if (_entity.getActionPoints() < 6 && _entity.isAbleToWait())
			{
				this.m.IsWaiting = true;
				return this.Const.AI.Behavior.Score.MoveToMerge * scoreMult;
			}
			else
			{
				return this.Const.AI.Behavior.Score.Zero;
			}
		}

		local entities = this.Tactical.Entities.getInstancesOfFaction(_entity.getFaction());
		local allies = [];

		foreach( e in entities )
		{
			if (e.getType() == this.Const.EntityType.SandGolem && e.getSize() == _entity.getSize())
			{
				allies.push(e);
			}
		}

		if (allies.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local tiles = [];

		foreach( ally in allies )
		{
			local allyTile = ally.getTile();

			for( local i = 0; i < 6; i = ++i )
			{
				if (!allyTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = allyTile.getNextTile(i);

					if (!tile.IsEmpty || tile.ID == myTile.ID || myTile.getDistanceTo(tile) * 2 > _entity.getActionPoints())
					{
					}
					else
					{
						local count = 0;

						for( local j = 0; j < 6; j = ++j )
						{
							if (!tile.hasNextTile(j))
							{
							}
							else
							{
								local adjacentTile = tile.getNextTile(j);

								if (adjacentTile.ID == myTile.ID)
								{
								}
								else if (adjacentTile.IsOccupiedByActor && adjacentTile.getEntity().getType() == this.Const.EntityType.SandGolem && adjacentTile.getEntity().getSize() == _entity.getSize())
								{
									count = ++count;
								}
							}
						}

						if (count >= 2 && count > currentCount)
						{
							tiles.push({
								Tile = tile,
								Score = count * 3 - myTile.getDistanceTo(tile),
								ScoreBonus = count
							});
						}
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		tiles.sort(function ( _a, _b )
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
		});
		local navigator = this.Tactical.getNavigator();
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
		local attempts = 0;
		local bestTile;
		local bestScore = -9000;

		foreach( tile in tiles )
		{
			attempts = ++attempts;

			if (attempts > this.Const.AI.Behavior.MoveToMergeMaxAttempts)
			{
				if (this.isAllottedTimeReached(time))
				{
					yield null;
					time = this.Time.getExactTime();
				}
			}

			if (navigator.findPath(_entity.getTile(), tile.Tile, settings, 0))
			{
				local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

				if (movementCosts.IsComplete)
				{
					local score = tile.ScoreBonus * 2 - movementCosts.ActionPointsRequired;

					if (score > bestScore)
					{
						bestScore = score;
						bestTile = tile.Tile;
					}
				}
			}
		}

		if (bestTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTile;
		return this.Const.AI.Behavior.Score.MoveToMerge * scoreMult;
	}

	function onBeforeExecute( _entity )
	{
	}

	function onExecute( _entity )
	{
		if (this.m.IsWaiting && this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
			}

			this.m.IsWaiting = false;
			return true;
		}

		if (this.m.TargetTile != null)
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
				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

				if (movement.Tiles == 0)
				{
					return true;
				}

				this.m.Agent.adjustCameraToDestination(movement.End);
				this.m.IsFirstExecuted = false;
				return;
			}

			if (!navigator.travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				this.m.TargetTile = null;
				this.m.IsWaiting = false;
				return true;
			}
		}

		return false;
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

});

