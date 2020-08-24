this.ai_defend_shieldwall <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.shieldwall",
			"actives.grow_shield"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Shieldwall;
		this.m.Order = this.Const.AI.Behavior.Order.Shieldwall;
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

		if (this.Tactical.State.isAutoRetreat())
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

		if (_entity.getAttackedCount() >= this.Const.AI.Behavior.ShieldwallMinOverwhelmCount)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.ShieldwallOverwhelmMult, _entity.getAttackedCount());
		}

		if (this.getAgent().getIntentions().IsDefendingPosition)
		{
			score = score * this.Const.AI.Behavior.ShieldwallDefendPositionMult;
		}

		local targets = this.queryTargetsInMeleeRange();
		local isInMelee = targets.len() != 0;
		local isBadPosition = _entity.getTile().IsBadTerrain && targets.len() != 0;
		local myTile = _entity.getTile();
		local dontUseShieldwallCount = 0;

		if (targets.len() != 0)
		{
			local count = 0;

			foreach( t in targets )
			{
				if (t.isNonCombatant())
				{
					continue;
				}

				if (this.isRangedUnit(t) && t.isArmedWithRangedWeapon() || t.getCurrentProperties().IsStunned || !t.getCurrentProperties().IsAbleToUseWeaponSkills || t.getSkills().hasSkill("effects.dazed") || t.getSkills().hasSkill("effects.distracted") || t.getMoraleState() == this.Const.MoraleState.Fleeing || t.isFatigued())
				{
					dontUseShieldwallCount = ++dontUseShieldwallCount;
					continue;
				}
				else
				{
					for( local j = 0; j < 6; j = ++j )
					{
						if (!t.getTile().hasNextTile(j))
						{
						}
						else
						{
							local tile = t.getTile().getNextTile(j);

							if (tile.IsOccupiedByActor && tile.getEntity().isAlliedWith(_entity) && tile.getEntity().getCurrentProperties().TargetAttractionMult > 1.0)
							{
								dontUseShieldwallCount = ++dontUseShieldwallCount;
							}
							else
							{
							}
						}
					}
				}

				local item = t.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

				if (item != null && item.hasProperty(this.Const.Items.Property.IgnoresShieldwall))
				{
					score = score * this.Const.AI.Behavior.ShieldwallInMeleeWithFlailMult;
					continue;
				}

				count = ++count;
				isBadPosition = isBadPosition || t.getTile().Level > _entity.getTile().Level || t.getSkills().hasSkill("effects.riposte");
			}

			if (count > 1)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.ShieldwallOpponentsInMeleeMult, count - 1);
			}

			if (dontUseShieldwallCount > 0)
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.ShieldwallInMeleeWithRangedUnitMult, dontUseShieldwallCount);
			}
		}
		else
		{
			score = score * this.Const.AI.Behavior.ShieldwallNoOpponentsInMeleeMult;
		}

		if (isBadPosition)
		{
			score = score * this.Const.AI.Behavior.ShieldwallInBadPositionMult;
		}

		local adjacentBonus = 0;

		if (this.getAgent().getIntentions().IsDefendingPosition || isInMelee)
		{
			for( local i = 0; i != 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = myTile.getNextTile(i);

					if (!tile.IsOccupiedByActor)
					{
					}
					else if (!tile.getEntity().isAlliedWith(_entity))
					{
					}
					else if (tile.getEntity().isArmedWithShield())
					{
						adjacentBonus = adjacentBonus + 1;

						if (tile.getEntity().getSkills().hasSkill("effects.shieldwall"))
						{
							adjacentBonus = adjacentBonus + 2;
						}
					}
				}
			}
		}

		score = score * (1.0 + adjacentBonus / 18.0 * this.Const.AI.Behavior.ShieldwallAdjacentBonus);
		local isEngagingGoodTarget = false;
		local declaredTargetTile = this.getAgent().getIntentions().TargetTile;

		if (!isInMelee && declaredTargetTile != null)
		{
			local willRunIntoSpearwalls = 0;

			for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
			{
				if (!declaredTargetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = declaredTargetTile.getNextTile(i);

					if (!tile.IsOccupiedByActor || this.Math.abs(tile.Level - declaredTargetTile.Level) > 1)
					{
					}
					else if (!tile.getEntity().isAlliedWith(_entity) && (tile.getEntity().getCurrentProperties().IsAttackingOnZoneOfControlAlways || !tile.hasZoneOfControlOtherThan(tile.getEntity().getAlliedFactions())) && tile.getEntity().getSkills().hasSkill("effects.spearwall"))
					{
						willRunIntoSpearwalls = ++willRunIntoSpearwalls;
					}
				}
			}

			if (willRunIntoSpearwalls != 0)
			{
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

				if (navigator.findPath(_entity.getTile(), declaredTargetTile, settings, 0))
				{
					if (_entity.getActionPoints() <= this.m.Skill.getActionPointCost() || navigator.getTurnsRequiredForPath(_entity, settings, _entity.getActionPoints() - this.m.Skill.getActionPointCost()) <= 1.0)
					{
						score = score * (willRunIntoSpearwalls * this.Const.AI.Behavior.ShieldwallAgainstSpearwallMult);
					}
				}
			}
			else
			{
				if (this.getProperties().EngageTileLimit != 0 && _entity.getActionPoints() == _entity.getActionPointsMax() && !this.getStrategy().getStats().IsEngaged)
				{
					return this.Const.AI.Behavior.Score.Zero;
				}

				if (_entity.getActionPoints() >= this.m.Skill.getActionPointCost() * 2)
				{
					score = score * this.Const.AI.Behavior.ShieldwallLowPriorityMult;
				}

				if (declaredTargetTile.Level > myTile.Level || declaredTargetTile.TVTotal >= myTile.TVTotal + this.Const.AI.Behavior.ShieldwallTVImprovementPrefered || !declaredTargetTile.IsBadTerrain && myTile.IsBadTerrain)
				{
					score = score * this.Const.AI.Behavior.ShieldwallLowPriorityMult;
				}

				if (this.getAgent().getIntentions().Target != null)
				{
					local targetValue = this.queryTargetValue(_entity, this.getAgent().getIntentions().Target, null);

					if (targetValue >= this.Const.AI.Behavior.ShieldwallMinTargetPrefValue)
					{
						score = score * this.Math.maxf(0.0, 1.0 - targetValue);

						if (_entity.getActionPoints() < this.m.Skill.getActionPointCost() + this.getAgent().getIntentions().APToReachTarget)
						{
							score = score * this.Const.AI.Behavior.ShieldwallPrefEngageGoodTargetMult;
							isEngagingGoodTarget = true;
						}
					}
				}
			}
		}

		if (targets.len() != 0)
		{
			score = score * (1.0 + (1.0 - (_entity.getHitpoints() + _entity.getArmor(this.Const.BodyPart.Body) + _entity.getArmor(this.Const.BodyPart.Head)) / (_entity.getHitpointsMax() + _entity.getArmorMax(this.Const.BodyPart.Body) + _entity.getArmorMax(this.Const.BodyPart.Head))) * this.Const.AI.Behavior.ShieldwallHeavilyWoundedMult);
		}

		local opponentCount = 0;
		local opponentRangedCount = 0;
		targets = this.getAgent().getKnownOpponents();

		foreach( t in targets )
		{
			if (t.Actor.isNull())
			{
				continue;
			}

			if (t.Actor.getMoraleState() == this.Const.MoraleState.Fleeing || t.Actor.getCurrentProperties().IsStunned || t.Actor.isNonCombatant())
			{
				continue;
			}

			local dist = t.Actor.getTile().getDistanceTo(myTile);

			if (t.Actor.getTile().getZoneOfControlCountOtherThan(t.Actor.getAlliedFactions()) == 0 && this.isRangedUnit(t.Actor))
			{
				local rangedInfo = t.Actor.getRangedWeaponInfo();

				if (dist <= rangedInfo.RangeWithLevel)
				{
					opponentRangedCount = ++opponentRangedCount;
				}
			}
			else if ((dist <= 4 || dist <= 6 && this.getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Shieldwall] >= 2.0) && t.Actor.getHitpointsPct() > 0.25)
			{
				local item = t.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

				if (item != null && item.hasProperty(this.Const.Items.Property.IgnoresShieldwall))
				{
					continue;
				}

				if (t.Actor.getCurrentProperties().IsRooted && dist > t.Actor.getIdealRange())
				{
					continue;
				}

				local danger = this.queryActorTurnsNearTarget(t.Actor, myTile, _entity);

				if (dist <= t.Actor.getIdealRange() || danger.TurnsWithAttack < 1.0 && danger.InZonesOfControl <= (this.getProperties().OverallDefensivenessMult <= 1.5 ? 0 : 1))
				{
					opponentCount = ++opponentCount;
				}
			}
		}

		if (opponentCount == 0 && opponentRangedCount == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (opponentCount > 0)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.ShieldwallMeleeOpponentsBase, opponentCount);
		}

		if (opponentRangedCount > 0 && opponentRangedCount > dontUseShieldwallCount)
		{
			score = score * this.Math.pow(this.Const.AI.Behavior.ShieldwallRangedOpponentsBase, opponentRangedCount);
		}

		local weapon = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.RangedWeapon) && weapon.isItemType(this.Const.Items.ItemType.Ammo) && weapon.getRangeIdeal() <= 4)
		{
			score = score * this.Const.AI.Behavior.ShieldwallWithThrowingWeaponMult;
		}

		return this.Const.AI.Behavior.Score.Shieldwall * this.Math.maxf(0.25, this.getProperties().OverallDefensivenessMult) * score;
	}

	function onExecute( _entity )
	{
		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Shieldwall!");
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

