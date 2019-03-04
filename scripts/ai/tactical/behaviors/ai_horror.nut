this.ai_horror <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetScore = 0,
		PossibleSkills = [
			"actives.horror"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Horror;
		this.m.Order = this.Const.AI.Behavior.Order.Horror;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.TargetScore = 0;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local opponents = this.getAgent().getKnownOpponents();
		local func = this.findBestTarget(_entity, opponents);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.Horror * score + this.m.TargetScore;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;

			if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	function findBestTarget( _entity, _targets )
	{
		// Function is a generator.
		local myTile = _entity.getTile();
		local bestScore = -9000.0;
		local bestTarget;
		local knownAllies = this.getAgent().getKnownAllies();
		local time = this.Time.getExactTime();

		foreach( o in _targets )
		{
			local opponentTile = o.Actor.getTile();

			if (myTile.getDistanceTo(opponentTile) > this.m.Skill.getMaxRange())
			{
				continue;
			}

			if (!this.m.Skill.isUsableOn(opponentTile))
			{
				continue;
			}

			if (o.Actor.getCurrentProperties().IsStunned)
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 0.0;
			local targets = [
				o.Actor
			];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!opponentTile.hasNextTile(i))
				{
				}
				else
				{
					local adjacentTile = opponentTile.getNextTile(i);

					if (!adjacentTile.IsOccupiedByActor)
					{
					}
					else
					{
						local entity = adjacentTile.getEntity();

						if (entity.getCurrentProperties().IsStunned)
						{
						}
						else if (entity.isAlliedWith(_entity))
						{
						}
						else
						{
							targets.push(entity);
						}
					}
				}
			}

			local numAffected = 0;

			foreach( target in targets )
			{
				if (target.getMoraleState() == this.Const.MoraleState.Ignore || target.getMoraleState() == this.Const.MoraleState.Fleeing)
				{
					continue;
				}

				local target_score = this.m.Skill.getMaxRange() - myTile.getDistanceTo(opponentTile);

				if (myTile.getDistanceTo(opponentTile) <= target.getIdealRange())
				{
					target_score = target_score + this.Const.AI.Behavior.HorrorAttackingMeBonus;
				}

				target_score = target_score + this.Const.AI.Behavior.HorrorZOCBonus * target.getTile().getZoneOfControlCountOtherThan(target.getAlliedFactions());

				if (target.getMoraleState() == this.Const.MoraleState.Breaking)
				{
					target_score = target_score + this.Const.AI.Behavior.HorrorAlmostFleeingBonus;
				}

				target_score = target_score * (1.0 - this.Math.minf(1.0, target.getCurrentProperties().getBravery() * 0.01));
				target_score = target_score * (1.0 / target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack]);
				target_score = target_score * target.getCurrentProperties().TargetAttractionMult;

				if (!target.isTurnDone())
				{
					target_score = target_score * this.Const.AI.Behavior.HorrorStillToActMult;
				}

				score = score + target_score;
				numAffected = ++numAffected;
			}

			if (numAffected > 1)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, numAffected - 1);
			}

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = o.Actor;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget.getTile();
			this.m.TargetScore = bestScore;
		}

		return true;
	}

});

