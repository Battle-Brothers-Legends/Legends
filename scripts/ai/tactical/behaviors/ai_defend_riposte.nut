this.ai_defend_riposte <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.riposte",
			"actives.return_favor"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Riposte;
		this.m.Order = this.Const.AI.Behavior.Order.Riposte;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
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

		if (_entity.getSkills().hasSkill("effects.adrenaline"))
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

		if (_entity.getAttackedCount() > 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.RiposteOverwhelmMult, _entity.getAttackedCount());
		}
		else
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange();

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local isInMelee = targets.len() != 0;
		local isBadPosition = _entity.getTile().IsBadTerrain && targets.len() != 0;
		local myTile = _entity.getTile();
		local count = 0;
		local meleeOpponents = 0;

		foreach( t in targets )
		{
			if (t.isNonCombatant() || t.isArmedWithRangedWeapon() || t.getMoraleState() == this.Const.MoraleState.Fleeing || t.getCurrentProperties().IsStunned || t.isFatigued() || !t.getCurrentProperties().IsAbleToUseWeaponSkills)
			{
				continue;
			}

			isBadPosition = isBadPosition || t.getTile().Level > _entity.getTile().Level;
			local otherTargets = 0;

			for( local i = 0; i != 6; i = ++i )
			{
				if (!t.getTile().hasNextTile(i))
				{
				}
				else
				{
					local tile = t.getTile().getNextTile(i);

					if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(t))
					{
						otherTargets = ++otherTargets;
					}
				}
			}

			meleeOpponents = ++meleeOpponents;
			count = count + (50.0 / t.getCurrentProperties().getMeleeSkill() - otherTargets * 0.5);
		}

		if (meleeOpponents < 2)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (count > 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.RiposteOpponentsInMeleeMult, count);
		}
		else if (count < 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.RiposteManyOtherTargetsMult, this.Math.abs(-count));
		}

		if (isBadPosition)
		{
			score = score * this.Const.AI.Behavior.RiposteInBadPositionMult;
		}

		if (_entity.getSkills().hasSkill("effects.shieldwall"))
		{
			score = score * this.Const.AI.Behavior.RiposteWithShieldwallMult;
		}

		if (this.getAgent().getIntentions().IsDefendingPosition)
		{
			score = score * this.Const.AI.Behavior.RiposteDefendPositionMult;
		}

		return this.Const.AI.Behavior.Score.Riposte * this.getProperties().OverallDefensivenessMult * score;
	}

	function onExecute( _entity )
	{
		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Riposte!");
		}

		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}

});

