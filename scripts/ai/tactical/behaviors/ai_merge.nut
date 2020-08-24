this.ai_merge <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.merge_golem"
		],
		Skill = null,
		IsWaiting = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Merge;
		this.m.Order = this.Const.AI.Behavior.Order.Merge;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.IsWaiting = false;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getCurrentProperties().IsStunned)
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

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			local engagedInMelee = this.queryTargetsInMeleeRange(1, 1).len() != 0;

			if (!engagedInMelee && _entity.isAbleToWait())
			{
				local myTile = _entity.getTile();

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
						else
						{
							local other = nextTile.getEntity();

							if (other.getType() == this.Const.EntityType.SandGolem && other.getSize() == _entity.getSize() && !other.isTurnDone() && other.getMoraleState() != this.Const.MoraleState.Fleeing && !other.getCurrentProperties().IsStunned)
							{
								local surrounding = 0;

								for( local j = 0; j < 6; j = ++j )
								{
									if (!nextTile.hasNextTile(j))
									{
									}
									else
									{
										local checkTile = nextTile.getNextTile(j);

										if (!checkTile.IsOccupiedByActor)
										{
										}
										else
										{
											local check = checkTile.getEntity();

											if (check.getType() == this.Const.EntityType.SandGolem && other.getSize() == check.getSize())
											{
												surrounding = ++surrounding;
											}
										}
									}
								}

								if (surrounding >= 2)
								{
									this.m.IsWaiting = true;
									return this.Const.AI.Behavior.Score.Merge * score;
								}
							}
						}
					}
				}
			}
			else if (!engagedInMelee && _entity.isAbleToWait() && _entity.getActionPoints() <= 2)
			{
				local currentCount = 0;

				for( local j = 0; j < 6; j = ++j )
				{
					if (!this.myTile.hasNextTile(j))
					{
					}
					else if (this.myTile.getNextTile(j).IsOccupiedByActor && this.myTile.getNextTile(j).getEntity().getType() == this.Const.EntityType.SandGolem && this.myTile.getNextTile(j).getEntity().getSize() == _entity.getSize())
					{
						currentCount = ++currentCount;
					}
				}

				if (currentCount >= 2)
				{
					this.m.IsWaiting = true;
					return this.Const.AI.Behavior.Score.Merge * score;
				}
			}

			return this.Const.AI.Behavior.Score.Zero;
		}
		else
		{
			score = score * this.getFatigueScoreMult(this.m.Skill);
			return this.Const.AI.Behavior.Score.Merge * score;
		}
	}

	function onExecute( _entity )
	{
		if (this.m.IsWaiting)
		{
			if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
			{
				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Waiting for others to act!");
				}

				return true;
			}
			else
			{
				this.m.IsWaiting = false;
			}
		}
		else
		{
			this.m.Skill.use(_entity.getTile());

			if (_entity.isAlive())
			{
				this.getAgent().declareAction();

				if (this.m.Skill.getDelay() != 0)
				{
					this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
				}
			}

			this.m.Skill = null;
		}

		return true;
	}

});

