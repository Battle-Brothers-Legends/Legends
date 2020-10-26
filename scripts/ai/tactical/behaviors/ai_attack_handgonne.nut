this.ai_attack_handgonne <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		Skill = null,
		PossibleSkills = [
			"actives.fire_handgonne"
		],
		SelectedSkill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.AttackHandgonne;
		this.m.Order = this.Const.AI.Behavior.Order.AttackHandgonne;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
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
		score = score * this.selectBestTarget(_entity.getTile(), _entity, this.m.Skill);

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsChangingWeapons)
		{
			score = score * this.Const.AI.Behavior.AttackAfterSwitchWeaponMult;
		}

		return this.Const.AI.Behavior.Score.Attack * score;
	}

	function onBeforeExecute( _entity )
	{
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.getEntity().isPlayerControlled() && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			this.getAgent().adjustCameraToTarget(this.m.TargetTile, this.m.Skill.getDelay());
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null)
		{
			if (this.Const.AI.VerboseMode && this.m.TargetTile.IsOccupiedByActor)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive())
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
			}

			this.m.TargetTile = null;
			this.m.Skill = null;
		}

		return true;
	}

	function selectBestTarget( _myTile, _entity, _skill )
	{
		local tiles = [];
		this.Tactical.queryTilesInRange(_myTile, _skill.getMinRange(), _skill.getMaxRange() + this.Math.min(_myTile.Level, _skill.getMaxRangeBonus()), false, [], this.onQueryTargetTile, tiles);
		local bestTarget;
		local bestScore = 0.0;

		foreach( tile in tiles )
		{
			if (this.m.Skill != null)
			{
				if (!_skill.isUsableOn(tile, _myTile))
				{
					continue;
				}
			}
			else if (!_skill.onVerifyTarget(_myTile, tile) || !_skill.isInRange(tile, _myTile) || !_myTile.hasLineOfSightTo(tile, _entity.getCurrentProperties().getVision()))
			{
				continue;
			}

			local score = 0.0;
			local opponentsHit = 0;
			local alliesHit = 0;
			local targets = _skill.getAffectedTiles(tile);

			foreach( t in targets )
			{
				if (!t.IsOccupiedByActor)
				{
					continue;
				}

				local e = t.getEntity();

				if (e.getID() == _entity.getID())
				{
					continue;
				}

				if (_entity.isAlliedWith(e))
				{
					if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
					{
						score = score - 1.0 / 6.0 * 4.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * e.getCurrentProperties().TargetAttractionMult;
					}

					alliesHit = ++alliesHit;

					if (e.isPlayerControlled())
					{
						alliesHit = ++alliesHit;
					}
				}
				else
				{
					score = score + this.queryTargetValue(_entity, e, _skill);

					if (t.getZoneOfControlCount(_entity.getFaction()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
					{
						score = score + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(e, _myTile, _entity).Turns));
					}

					opponentsHit = ++opponentsHit;
				}
			}

			if (opponentsHit > 1)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneOpponentsHitMult, opponentsHit);
			}

			if (alliesHit > 0)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneAlliesHitMult, alliesHit);
			}

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = tile;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget;
			return this.Math.maxf(0.1, bestScore);
		}
		else
		{
			return 0.0;
		}
	}

	function onQueryTargetTile( _tile, _tag )
	{
		_tag.push(_tile);
	}

});

