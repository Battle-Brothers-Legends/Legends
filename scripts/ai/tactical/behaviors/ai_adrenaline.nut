this.ai_adrenaline <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.adrenaline"
		],
		Skill = null,
		IsWaiting = false,
		UsedAdrenalineLast = -1
	},
	function getUsedLast()
	{
		return this.m.UsedAdrenalineLast;
	}

	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Adrenaline;
		this.m.Order = this.Const.AI.Behavior.Order.Adrenaline;
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

		if (_entity.getActionPoints() == _entity.getActionPointsMax())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local isEngaged = myTile.hasZoneOfOccupationOtherThan(_entity.getAlliedFactions());
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;

		if (_entity.getActionPoints() >= apRequiredForAttack)
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

		if (_entity.getFatigueMax() - (_entity.getFatigue() + this.m.Skill.getFatigueCost()) + _entity.getCurrentProperties().FatigueRecoveryRate < 30)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity) && (_entity.getSkills().hasSkill("effects.shieldwall") || _entity.getSkills().hasSkill("effects.riposte") || _entity.getSkills().hasSkill("effects.spearwall")))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local dotDamage = 0;
		local effects = _entity.getSkills().getAllSkillsOfType(this.Const.SkillType.DamageOverTime);

		foreach( dot in effects )
		{
			dotDamage = dotDamage + dot.getDamage();
		}

		if (dotDamage >= _entity.getHitpoints())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local nextTurnInitiative = _entity.getTurnOrderInitiative();
		local maxRange = this.Math.min(this.getProperties().EngageRangeMax, _entity.getCurrentProperties().Vision) + (!isEngaged && !this.getStrategy().isDefending() ? 2 : 0);
		local targets = this.queryTargetsInMeleeRange(this.Math.min(this.getProperties().EngageRangeMin, _entity.getCurrentProperties().Vision), this.Math.max(_entity.getIdealRange(), maxRange));

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local additionalScore = 0.0;
		local actingBeforeMe = 0;
		local stillToAct = 0;
		local reachable = 0;

		foreach( target in targets )
		{
			if (target.isNonCombatant())
			{
				continue;
			}

			if ((target.getCurrentProperties().IsAttackingOnZoneOfControlAlways || !target.getTile().hasZoneOfControlOtherThan(target.getAlliedFactions())) && target.getSkills().hasSkill("effects.spearwall"))
			{
				continue;
			}

			if (target.getTile().getDistanceTo(myTile) <= _entity.getIdealRange() + (apRequiredForAttack <= 4 ? 2 : 1))
			{
				reachable = ++reachable;
			}

			if (target.isTurnDone() && target.getCurrentProperties().IsStunned || target.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				continue;
			}

			if (nextTurnInitiative <= target.getTurnOrderInitiative() + (target.isTurnDone() || this.Time.getRound() <= 2 ? 0 : target.getCurrentProperties().FatigueToInitiativeRate * -10))
			{
				actingBeforeMe = ++actingBeforeMe;
				additionalScore = additionalScore + this.queryTargetValue(_entity, target);

				if (!target.isTurnDone() && !target.getCurrentProperties().IsStunned)
				{
					stillToAct = ++stillToAct;
				}
			}
		}

		if (actingBeforeMe == 0 || isEngaged && actingBeforeMe <= targets.len() / 6 || !isEngaged && reachable == 0 || !isEngaged && stillToAct >= actingBeforeMe)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score + additionalScore;

		if (this.Time.getRound() <= 2 && !this.getStrategy().isDefending())
		{
			score = score * this.Const.AI.Behavior.AdrenalineFirstRoundMult;
		}

		if (this.getStrategy().getStats().IsBeingKited)
		{
			score = score * this.Const.AI.Behavior.AdrenalineBeingKitedMult;
		}

		score = score * (1.0 + _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.AdrenalineSurrounded);
		score = score * (1.0 + 1.0 - _entity.getHitpointsPct());

		if (_entity.getFatiguePct() < 0.4)
		{
			score = score * (1.0 + (this.Const.AI.Behavior.AdrenalineFresh - _entity.getFatiguePct()));
		}

		if (!isEngaged && myTile.IsBadTerrain)
		{
			score = score * this.Const.AI.Behavior.AdrenalineOnBadTerrainMult;
		}

		if (_entity.getAttackedCount() > 3)
		{
			score = score * (_entity.getAttackedCount() / 3.0);
		}

		if (score < this.Const.AI.Behavior.AdrenalineScoreCutoff)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.isAbleToWait() && this.Tactical.TurnSequenceBar.isOpponentStillToAct(_entity))
		{
			this.m.IsWaiting = true;
		}

		return this.Const.AI.Behavior.Score.Adrenaline * score;
	}

	function onExecute( _entity )
	{
		if (this.m.IsWaiting)
		{
			if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
			{
				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Waiting until using Adrenaline!");
				}

				return true;
			}
			else
			{
				this.m.IsWaiting = false;
			}
		}

		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Adrenaline!");
		}

		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.UsedAdrenalineLast = this.Time.getRound();
		return true;
	}

});

