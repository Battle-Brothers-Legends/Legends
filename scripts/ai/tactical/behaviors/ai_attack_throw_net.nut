this.ai_attack_throw_net <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.throw_net",
			"actives.web",
			"actives.kraken_ensnare"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.ThrowNet;
		this.m.Order = this.Const.AI.Behavior.Order.ThrowNet;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
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

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = {
			Target = null,
			Score = 0.0
		};
		local func = this.findBestTarget(_entity, targets, bestTarget);

		while (resume func == null)
		{
			yield null;
		}

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		return this.Const.AI.Behavior.Score.Attack * bestTarget.Score * score;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);
			this.getAgent().declareEvaluationDelay(800);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
			}

			this.m.TargetTile = null;
		}

		return true;
	}

	function findBestTarget( _entity, _targets, _bestTarget )
	{
		// Function is a generator.
		local bestTarget;
		local bestScore = -9000.0;
		local knownAllies = this.getAgent().getKnownAllies();
		local time = this.Time.getExactTime();

		foreach( target in _targets )
		{
			local score = 1.0;

			if (target.getCurrentProperties().IsRooted || target.getCurrentProperties().IsImmuneToRoot)
			{
				continue;
			}

			if (target.getHitpoints() <= this.Const.AI.Behavior.ThrowNetMinHitpoints)
			{
				continue;
			}

			if (target.getCurrentProperties().TargetAttractionMult < this.Const.AI.Behavior.ThrowNetMinAttaction)
			{
				continue;
			}

			local tile = target.getTile();

			if (!this.m.Skill.isUsableOn(target.getTile()))
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			score = score - tile.TVTotal * this.Const.AI.Behavior.ThrowNetTVMult;

			if (tile.IsBadTerrain)
			{
				score = score + this.Const.AI.Behavior.ThrowNetBadTerrainBonus;
			}

			if (this.hasNegativeTileEffect(tile, target))
			{
				score = score + this.Const.AI.Behavior.ThrowNetBadTerrainBonus;
			}

			score = score + target.getCurrentProperties().getMeleeDefense() / 2;

			if (!target.hasRangedWeapon())
			{
				score = score + this.Const.AI.Behavior.ThrowNetNoRangedWeaponBonus;
			}

			local canHit = false;

			foreach( ally in knownAllies )
			{
				if (tile.getDistanceTo(ally.getTile()) <= target.getIdealRange())
				{
					canHit = true;
					break;
				}
			}

			if (!canHit)
			{
				score = score + this.Const.AI.Behavior.ThrowNetCantAttackAnyoneBonus;
			}

			if (tile.getZoneOfControlCount(_entity.getFaction()) == 0)
			{
				foreach( ally in knownAllies )
				{
					if (ally.getCurrentProperties().TargetAttractionMult <= 1.0 && !this.isRangedUnit(ally))
					{
						continue;
					}

					local d = this.queryActorTurnsNearTarget(target, ally.getTile(), target);

					if (d.Turns <= 1.0)
					{
						score = score + this.Const.AI.Behavior.ThrowNetProtectPriorityTargetBonus;
					}
				}
			}

			score = score * target.getCurrentProperties().TargetAttractionMult;

			if (!canHit && target.isTurnDone() && target.getSkills().hasSkill("effects.adrenaline"))
			{
				score = score * this.Const.AI.Behavior.ThrowNetVSAdrenalineMult;
			}

			if (target.getType() == this.Const.EntityType.Wardog || target.getType() == this.Const.EntityType.Warhound)
			{
				score = score * this.Const.AI.Behavior.ThrowNetVSWardogsMult;
			}

			if (target.isTurnDone())
			{
				for( local i = 0; i < 6; i = ++i )
				{
					if (!tile.hasNextTile(i))
					{
					}
					else
					{
						local adjacent = tile.getNextTile(i);

						if (adjacent.IsOccupiedByActor && adjacent.getEntity().isAlliedWith(_entity))
						{
							if (adjacent.getEntity().getSkills().hasSkill("actives.deathblow"))
							{
								score = score * this.Const.AI.Behavior.ThrowNetToSetupDeathblowMult;
							}
						}
					}
				}
			}

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = target;
			}
		}

		_bestTarget.Target = bestTarget;
		_bestTarget.Score = bestScore * 0.1;
		return true;
	}

});

