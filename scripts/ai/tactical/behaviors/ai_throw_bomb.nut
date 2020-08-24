this.ai_throw_bomb <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.throw_daze_bomb",
			"actives.throw_fire_bomb",
			"actives.throw_smoke_bomb"
		],
		Selection = null,
		Skill = null,
		BombsUsed = 0,
		BombsMax = 2,
		IsFireBombAvailable = true,
		IsDazeBombAvailable = true,
		IsSmokeBombAvailable = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.ThrowBomb;
		this.m.Order = this.Const.AI.Behavior.Order.ThrowBomb;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Selection = null;
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

		if (this.m.Skill == null && this.getAgent().getID() == this.Const.AI.Agent.ID.CharmedPlayer)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;

		if (this.m.Skill == null)
		{
			if (this.m.BombsUsed >= this.m.BombsMax || !_entity.getItems().hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			if (_entity.getTile().hasZoneOfOccupationOtherThan(_entity.getAlliedFactions()) && _entity.getActionPoints() < 5 && _entity.getActionPoints() >= apRequiredForAttack)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			local ret = this.evaluateBombs(_entity);

			if (ret == null)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}
			else
			{
				this.m.Selection = ret;
				return this.Const.AI.Behavior.Score.ThrowBomb * ret.Score * score;
			}
		}
		else
		{
			score = score * this.getFatigueScoreMult(this.m.Skill);
			this.m.Selection = this.evaluateBombs(_entity, this.m.Skill);

			if (this.m.Selection == null || this.m.Selection.Score == 0)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			return this.Const.AI.Behavior.Score.ThrowBomb * this.m.Selection.Score * score;
		}
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(_entity.getTile());
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.Skill != null)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + "!");
			}

			this.m.Skill.use(this.m.Selection.Target);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.Selection.Target.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay();
			}

			this.m.Selection = null;
			this.m.Skill = null;
		}
		else
		{
			_entity.getItems().payForAction([]);
			_entity.getItems().equip(this.new(this.m.Selection.Item));
			++this.m.BombsUsed;
		}

		return true;
	}

	function evaluateBombs( _entity, _skill = null )
	{
		local myTile = _entity.getTile();
		local tiles = [];
		this.Tactical.queryTilesInRange(myTile, 2, 3, false, [], this.onQueryTile, tiles);

		if (_skill == null)
		{
			local possibilities = [];

			if (this.m.IsFireBombAvailable)
			{
				possibilities.push(this.evaluateFireBomb(_entity, tiles));
			}

			if (this.m.IsDazeBombAvailable)
			{
				possibilities.push(this.evaluateDazeBomb(_entity, tiles));
			}

			if (this.m.IsSmokeBombAvailable)
			{
				possibilities.push(this.evaluateSmokeBomb(_entity, tiles));
			}

			possibilities.sort(this.onSortByScore);

			if (possibilities[0].Score > 0)
			{
				return possibilities[0];
			}
			else
			{
				return null;
			}
		}
		else
		{
			if (_skill.getID() == "actives.throw_fire_bomb")
			{
				return this.evaluateFireBomb(_entity, tiles, _skill);
			}

			if (_skill.getID() == "actives.throw_daze_bomb")
			{
				return this.evaluateDazeBomb(_entity, tiles, _skill);
			}

			if (_skill.getID() == "actives.throw_smoke_bomb")
			{
				return this.evaluateSmokeBomb(_entity, tiles, _skill);
			}

			return null;
		}
	}

	function evaluateFireBomb( _entity, _tiles, _skill = null )
	{
		local ret = {
			Score = 0,
			Target = null,
			Item = "scripts/items/tools/fire_bomb_item"
		};
		local myTile = _entity.getTile();

		foreach( tile in _tiles )
		{
			if (myTile.Level + 1 < tile.Level)
			{
				continue;
			}

			if (_skill != null && !_skill.isUsableOn(tile))
			{
				continue;
			}

			local score = 0.0;
			local targets = [];
			local alliesHit = 0;
			local opponentsHit = 0;

			if (tile.IsOccupiedByActor)
			{
				targets.push(tile.getEntity());
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else if (tile.getNextTile(i).IsOccupiedByActor)
				{
					targets.push(tile.getNextTile(i).getEntity());
				}
			}

			foreach( target in targets )
			{
				local targetTile = target.getTile();

				if (targetTile.Properties.Effect != null && !targetTile.Properties.Effect.IsPositive)
				{
					continue;
				}

				if (targetTile.Type == this.Const.Tactical.TerrainType.ShallowWater || targetTile.Type == this.Const.Tactical.TerrainType.DeepWater)
				{
					continue;
				}

				if (target.isAlliedWith(_entity))
				{
					score = score - 1.0 * target.getCurrentProperties().TargetAttractionMult;
					alliesHit = ++alliesHit;

					if (target.isPlayerControlled())
					{
						alliesHit = ++alliesHit;
					}
				}
				else
				{
					local s = this.queryTargetValue(_entity, target, null);

					if (target.getCurrentProperties().IsStunned || target.getCurrentProperties().IsRooted)
					{
						s = s * this.Const.AI.Behavior.ThrowBombStunnedMult;
					}

					if (targetTile.hasZoneOfControlOtherThan(target.getAlliedFactions()))
					{
						s = s * (targetTile.getZoneOfControlCountOtherThan(target.getAlliedFactions()) * this.Const.AI.Behavior.ThrowBombZOCMult);
					}

					if (target.getHitpoints() + target.getArmor(this.Const.BodyPart.Body) <= 20)
					{
						s = s * this.Const.AI.Behavior.ThrowBombInstakillMult;
					}

					score = score + s;
					opponentsHit = ++opponentsHit;
				}
			}

			if (score > ret.Score && alliesHit <= 1 && opponentsHit > 1)
			{
				ret.Score = score;
				ret.Target = tile;
			}
		}

		return ret;
	}

	function evaluateDazeBomb( _entity, _tiles, _skill = null )
	{
		local ret = {
			Score = 0,
			Target = null,
			Item = "scripts/items/tools/daze_bomb_item"
		};
		local myTile = _entity.getTile();

		foreach( tile in _tiles )
		{
			if (myTile.Level + 1 < tile.Level)
			{
				continue;
			}

			if (_skill != null && !_skill.isUsableOn(tile))
			{
				continue;
			}

			local score = 0.0;
			local targets = [];
			local alliesHit = 0;
			local opponentsHit = 0;

			if (tile.IsOccupiedByActor)
			{
				targets.push(tile.getEntity());
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else if (tile.getNextTile(i).IsOccupiedByActor)
				{
					targets.push(tile.getNextTile(i).getEntity());
				}
			}

			foreach( target in targets )
			{
				local targetTile = target.getTile();

				if (target.getSkills().hasSkill("effects.dazed"))
				{
					continue;
				}

				if (target.isAlliedWith(_entity))
				{
					if (!target.getCurrentProperties().IsStunned && !target.getSkills().hasSkill("effects.dazed"))
					{
						score = score - 0.5 * target.getCurrentProperties().TargetAttractionMult;
						alliesHit = ++alliesHit;

						if (target.isPlayerControlled())
						{
							alliesHit = ++alliesHit;
						}
					}
				}
				else
				{
					local s = this.queryTargetValue(_entity, target, null);

					if (target.getCurrentProperties().IsStunned || target.getCurrentProperties().IsRooted)
					{
						s = s * this.Const.AI.Behavior.ThrowBombAlreadyOutMult;
					}

					if (targetTile.hasZoneOfControlOtherThan(target.getAlliedFactions()))
					{
						s = s * (targetTile.getZoneOfControlCountOtherThan(target.getAlliedFactions()) * this.Const.AI.Behavior.ThrowBombZOCMult);
					}

					if (target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.TwoHanded) && target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon))
					{
						s = s * this.Const.AI.Behavior.ThrowBombPriorityTargetMult;
					}

					if (target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
					{
						s = s * this.Const.AI.Behavior.ThrowBombPriorityTargetMult;
					}

					for( local i = 0; i < 6; i = ++i )
					{
						if (!targetTile.hasNextTile(i))
						{
						}
						else
						{
							local adjacent = targetTile.getNextTile(i);

							if (adjacent.IsOccupiedByActor && adjacent.getEntity().isAlliedWith(_entity))
							{
								if (adjacent.getEntity().getCurrentProperties().TargetAttractionMult > 1.0)
								{
									score = score * this.Const.AI.Behavior.ThrowBombPriorityTargetMult;
								}

								if (adjacent.getEntity().getSkills().hasSkill("actives.deathblow"))
								{
									score = score * this.Const.AI.Behavior.ThrowBombPriorityTargetMult;
								}
							}
						}
					}

					score = score + s;
					opponentsHit = ++opponentsHit;
				}
			}

			if (score > ret.Score && alliesHit < 2 && opponentsHit > 1)
			{
				ret.Score = score;
				ret.Target = tile;
			}
		}

		return ret;
	}

	function onQueryTile( _tile, _tag )
	{
		_tag.push(_tile);
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

