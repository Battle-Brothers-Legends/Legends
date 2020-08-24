this.ai_mortar <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.fire_mortar"
		],
		Skill = null,
		Target = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Mortar;
		this.m.Order = this.Const.AI.Behavior.Order.Mortar;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.Skill.isWaitingOnImpact())
		{
			return this.Const.AI.Behavior.Score.Mortar;
		}

		local myTile = _entity.getTile();
		local hasEngineer = false;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(i);

				if (!nextTile.IsOccupiedByActor)
				{
				}
				else if (_entity.isAlliedWith(nextTile.getEntity()) && nextTile.getEntity().getType() == this.Const.EntityType.Engineer && !nextTile.hasZoneOfControlOtherThan(nextTile.getEntity().getAlliedFactions()))
				{
					hasEngineer = true;
					break;
				}
			}
		}

		if (!hasEngineer)
		{
			_entity.getSprite("body").setBrush("mortar_01");
			return this.Const.AI.Behavior.Score.Zero;
		}
		else
		{
			_entity.getSprite("body").setBrush("mortar_02");
		}

		local targets = this.getAgent().getKnownOpponents();
		this.m.Target = this.selectBestTarget(_entity, targets);

		if (this.m.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.Mortar;
	}

	function onExecute( _entity )
	{
		if (this.m.Target == null)
		{
			this.m.Skill.updateImpact();
		}
		else
		{
			this.m.Skill.use(this.m.Target);
		}

		if (_entity.isAlive())
		{
			this.getAgent().declareAction();

			if (this.m.Skill.getDelay() != 0)
			{
				this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
			}
		}

		this.m.Skill = null;
		this.m.Target = null;
		return true;
	}

	function selectBestTarget( _entity, _targets )
	{
		local myTile = _entity.getTile();
		local bestTile;
		local bestTargets = 0;
		local tiles = [];

		foreach( target in _targets )
		{
			if (target.Actor.getTile().IsHidingEntity)
			{
				continue;
			}

			tiles.push(target.Actor.getTile());

			for( local i = 0; i < 6; i = ++i )
			{
				if (!target.Actor.getTile().hasNextTile(i))
				{
				}
				else
				{
					tiles.push(target.Actor.getTile());
				}
			}
		}

		foreach( tile in tiles )
		{
			if (myTile.getDistanceTo(tile) < this.m.Skill.getMinRange())
			{
				continue;
			}

			local numTargets = 0;

			if (tile.IsOccupiedByActor)
			{
				local e = tile.getEntity();

				if (!_entity.isAlliedWith(e))
				{
					numTargets = numTargets + 10;

					if (e.getCurrentProperties().IsStunned || e.getCurrentProperties().IsRooted || tile.hasZoneOfControlOtherThan(e.getAlliedFactions()))
					{
						numTargets = numTargets + 5;
					}
				}
				else if (e.getType() == this.Const.EntityType.Slave)
				{
					numTargets = numTargets - 10;
				}
				else
				{
					numTargets = numTargets - 20;
				}
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = tile.getNextTile(i);

					if (!nextTile.IsOccupiedByActor)
					{
					}
					else
					{
						local e = nextTile.getEntity();

						if (!_entity.isAlliedWith(e))
						{
							numTargets = numTargets + 10;

							if (e.getCurrentProperties().IsStunned || e.getCurrentProperties().IsRooted || tile.hasZoneOfControlOtherThan(e.getAlliedFactions()))
							{
								numTargets = numTargets + 5;
							}
						}
						else if (e.getType() == this.Const.EntityType.Slave)
						{
							numTargets = numTargets - 10;
						}
						else
						{
							numTargets = numTargets - 20;
						}
					}
				}
			}

			if (numTargets <= 0)
			{
				continue;
			}

			if (numTargets > bestTargets)
			{
				bestTile = tile;
				bestTargets = numTargets;
			}
		}

		return bestTile;
	}

});

