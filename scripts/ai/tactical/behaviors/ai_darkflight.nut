this.ai_darkflight <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		SelectedSkill = null,
		PossibleSkills = [
			"actives.darkflight"
		],
		Inertia = 0,
		LastEvaluateTime = 0,
		LastExecuteTime = 0,
		UnlockTime = 0
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Darkflight;
		this.m.Order = this.Const.AI.Behavior.Order.Darkflight;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
		this.m.UnlockTime = 0;
		local time = this.Time.getExactTime();

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

		if (this.getAgent().getIntentions().IsDefendingPosition)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				this.m.SelectedSkill = skill;
				break;
			}
		}

		if (this.m.SelectedSkill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.LastEvaluateTime == this.m.LastExecuteTime)
		{
			this.m.Inertia = this.Math.maxf(0, this.m.Inertia - 1);
		}
		else
		{
			this.m.Inertia = 0;
		}

		this.m.LastEvaluateTime = this.Tactical.TurnSequenceBar.getCurrentRound();

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score - this.Math.min(this.Const.AI.Behavior.DarkflightMaxInertia, this.m.Inertia) * this.Const.AI.Behavior.DarkflightInertiaMult;
		local targetsInMelee = this.queryTargetsInMeleeRange();

		if (targetsInMelee.len() != 0)
		{
			foreach( t in targetsInMelee )
			{
				if (t.getMoraleState() == this.Const.MoraleState.Fleeing || t.getCurrentProperties().IsStunned)
				{
					continue;
				}

				local mult = 1.0;

				if (this.isRangedUnit(t))
				{
					mult = 0.33;
				}

				local hitpoints = t.getHitpoints() + t.getArmor(this.Const.BodyPart.Body) + t.getArmor(this.Const.BodyPart.Head);
				local hitpointsMax = t.getHitpointsMax() + t.getArmorMax(this.Const.BodyPart.Body) + t.getArmorMax(this.Const.BodyPart.Head);
				score = score + hitpoints / hitpointsMax * this.Const.AI.Behavior.DarkflightMeleeHitpointsMult * mult;
				score = score + (t.getArmor(this.Const.BodyPart.Body) + t.getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult;
				score = score + t.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult * 5.0;

				if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == t.getID())
				{
					score = score + 100.0;
				}
			}
		}

		local targets = this.getAgent().getKnownOpponents();
		local potentialDestinations = [];
		local lastResortPotentialDestinations = [];
		local myTile = _entity.getTile();
		local myTileScore;

		foreach( t in targets )
		{
			if (t.Actor.isNull())
			{
				continue;
			}

			local targetTile = t.Actor.getTile();
			local collection = potentialDestinations;

			if (myTile.getDistanceTo(targetTile) > this.m.SelectedSkill.getMaxRange() + 1)
			{
				local betweenTile = myTile.getTileBetweenThisAnd(targetTile);

				for( ; myTile.getDistanceTo(betweenTile) > this.m.SelectedSkill.getMaxRange() + 1;  )
				{
				}

				targetTile = betweenTile;
				collection = lastResortPotentialDestinations;
			}

			for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (!tile.IsEmpty && !tile.isSameTileAs(myTile) || tile.Type == this.Const.Tactical.TerrainType.Impassable)
					{
					}
					else
					{
						local dist = myTile.getDistanceTo(tile);

						if (dist > this.m.SelectedSkill.getMaxRange())
						{
						}
						else
						{
							local levelDifference = tile.Level - targetTile.Level;

							if (this.Math.abs(levelDifference) > 1)
							{
							}
							else
							{
								collection.push({
									Tile = tile,
									LevelDifference = levelDifference,
									UltimateTile = collection == potentialDestinations ? tile : t.Actor.getTile(),
									Score = 0,
									ScoreMult = 1.0,
									DebugTargets = 0.0,
									DebugDanger = 0.0,
									DebugTV = 0.0
								});
							}
						}
					}
				}
			}
		}

		if (potentialDestinations.len() == 0)
		{
			if (lastResortPotentialDestinations.len() == 0)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			potentialDestinations = lastResortPotentialDestinations;
		}

		foreach( dest in potentialDestinations )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local tileScore = 0.0;
			local tileScoreMult = 1.0;
			local before = 0;

			for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
			{
				if (!dest.Tile.hasNextTile(i))
				{
				}
				else
				{
					local tile = dest.Tile.getNextTile(i);
					local levelDifference = dest.Tile.Level - tile.Level;
					local distToMe = myTile.getDistanceTo(tile);

					if (this.Math.abs(levelDifference) > 1)
					{
					}
					else if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(_entity))
					{
						local actor = tile.getEntity();
						local zoc = tile.getZoneOfControlCountOtherThan(actor.getAlliedFactions());
						local isTargetInEnemyZoneOfControl = distToMe > 1 && zoc != 0 || distToMe == 1 && zoc > 1;
						local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(actor);

						if (isTargetArmedWithRangedWeapon)
						{
							tileScore = tileScore + this.Const.AI.Behavior.DarkflightRangedTargetBonus * this.getProperties().EngageTargetArmedWithRangedWeaponMult;
							tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightRangedTargetMult;
						}

						if (actor.getMoraleState() != this.Const.MoraleState.Fleeing && !actor.getCurrentProperties().IsStunned)
						{
							tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightMultipleOpponentsMult;
							local hitpoints = actor.getHitpoints() + actor.getArmor(this.Const.BodyPart.Body) + actor.getArmor(this.Const.BodyPart.Head);
							local hitpointsMax = actor.getHitpointsMax() + actor.getArmorMax(this.Const.BodyPart.Body) + actor.getArmorMax(this.Const.BodyPart.Head);

							if (!isTargetArmedWithRangedWeapon)
							{
								tileScore = tileScore - hitpoints / hitpointsMax * this.Const.AI.Behavior.DarkflightHitpointsScoreMult;
							}
						}
						else
						{
							tileScore = tileScore + this.Const.AI.Behavior.DarkflightFleeingBonus;
						}

						tileScore = tileScore - (actor.getArmor(this.Const.BodyPart.Body) + actor.getArmor(this.Const.BodyPart.Head)) * this.Const.AI.Behavior.DarkflightHatredForArmorMult * this.Const.AI.Behavior.DarkflightHatredForArmorMult;
						tileScore = tileScore - actor.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.DarkflightHatredForMeleeDefenseMult;
						tileScore = tileScore + levelDifference * this.Const.AI.Behavior.DarkflightTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;

						if (levelDifference > 0)
						{
							tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightTerrainLevelMult;
						}
						else if (levelDifference < 0)
						{
							tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightBadTerrainMult;
						}

						if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == actor.getID())
						{
							tileScore = tileScore + 100.0;
						}
					}
					else if (!tile.IsEmpty && !tile.IsOccupiedByActor)
					{
						tileScore = tileScore + this.Const.AI.Behavior.DarkflightTileBlockedBonus;
					}
				}
			}

			dest.DebugTargets = tileScore - before;
			before = tileScore;
			local dangerTotal = 0.0;
			local dangerCount = 0.0;

			foreach( d in targets )
			{
				if (d.Actor.isNull())
				{
					continue;
				}

				if (this.isRangedUnit(d.Actor))
				{
					continue;
				}

				if (d.Actor.getMoraleState() == this.Const.MoraleState.Fleeing || d.Actor.getCurrentProperties().IsStunned)
				{
					continue;
				}

				local danger = this.queryActorTurnsNearTarget(d.Actor, dest.Tile, _entity);
				local localDanger = 1.0 - this.Math.minf(1.0, danger.Turns);
				dangerTotal = dangerTotal + localDanger;

				if (danger.Turns <= 1.0)
				{
					dangerCount = ++dangerCount;
				}
			}

			tileScore = tileScore - this.Math.maxf(0.0, dangerTotal) * this.Const.AI.Behavior.DarkflightDangerDestMult;
			dest.DebugDanger = tileScore - before;
			before = tileScore;

			if (dest.Tile.IsBadTerrain)
			{
				tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
				tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightBadTerrainMult;
			}

			if (this.hasNegativeTileEffect(dest.Tile, _entity))
			{
				tileScore = tileScore - this.Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
				tileScoreMult = tileScoreMult * this.Const.AI.Behavior.DarkflightBadTerrainMult;
			}

			tileScore = tileScore + dest.Tile.TVTotal * this.Const.AI.Behavior.DarkflightTacticalValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;
			tileScoreMult = tileScoreMult + dest.Tile.TVTotal * this.Const.AI.Behavior.DarkflightTacticalValueMult * this.Const.AI.Behavior.DarkflightTacticalValueMult;
			dest.DebugTV = tileScore - before;

			if (dest.Tile.isSameTileAs(myTile))
			{
				tileScore = tileScore + this.Const.AI.Behavior.DarkflightStayOnTileBonus;
				myTileScore = dest;
			}

			dest.Score = tileScore;
			dest.ScoreMult = tileScoreMult;
		}

		potentialDestinations.sort(this.onSortByScore);

		if (myTileScore != null && (potentialDestinations[0].Tile.isSameTileAs(myTile) || potentialDestinations[0].Score <= myTileScore.Score))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (myTile.getDistanceTo(potentialDestinations[0].Tile) == 1 && targetsInMelee.len() == 0 && this.Math.abs(myTile.Level - potentialDestinations[0].Tile.Level) < 2 && this.getProperties().BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] != 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local distToDest = myTile.getDistanceTo(potentialDestinations[0].UltimateTile);

		if (distToDest > 4)
		{
			score = score * this.Math.minf(this.Const.AI.Behavior.DarkflightScaleByDistMaxMult, distToDest / 4.0);
		}
		else if (distToDest < 2 && (potentialDestinations[0].Tile.Level <= myTile.Level || potentialDestinations[0].Tile.IsBadTerrain && !myTile.IsBadTerrain || potentialDestinations[0].Tile.IsBadTerrain && myTile.IsBadTerrain || this.hasNegativeTileEffect(potentialDestinations[0].Tile, _entity) && !this.hasNegativeTileEffect(myTile, _entity) || this.hasNegativeTileEffect(potentialDestinations[0].Tile, _entity) && this.hasNegativeTileEffect(myTile, _entity)))
		{
			score = score * (distToDest / 2.0);
		}
		else if (distToDest == 2 && myTileScore != null && potentialDestinations[0].Score <= myTileScore.Score + this.Const.AI.Behavior.DarkflightStayOnTileBonus)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = potentialDestinations[0].Tile;
		this.getAgent().getIntentions().TargetTile = this.m.TargetTile;
		return this.Const.AI.Behavior.Score.Darkflight * score * potentialDestinations[0].ScoreMult;
	}

	function onBeforeExecute( _entity )
	{
		this.getAgent().getOrders().IsEngaging = true;
		this.getAgent().getOrders().IsDefending = false;
		this.getAgent().getIntentions().IsDefendingPosition = false;
		this.m.LastExecuteTime = this.Tactical.TurnSequenceBar.getCurrentRound();
		this.m.Inertia += 2;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.m.IsFirstExecuted = false;

			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using Darkflight to engage.");
			}

			this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
			this.m.SelectedSkill.use(this.m.TargetTile);
		}
		else if (!_entity.isStoringColor())
		{
			return true;
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

