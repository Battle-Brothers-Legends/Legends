this.ai_world_attack <- this.inherit("scripts/ai/world/world_behavior", {
	m = {
		Target = null,
		DecidedToAttackTime = 0.0
	},
	function setEnabled( _e )
	{
		this.m.IsEnabled = _e;
	}

	function setTarget( _t )
	{
		this.m.Target = _t;
	}

	function create()
	{
		this.m.ID = this.Const.World.AI.Behavior.ID.Attack;
		this.world_behavior.create();
	}

	function onSerialize( _out )
	{
		this.world_behavior.onSerialize(_out);

		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		_out.writeF32(this.m.DecidedToAttackTime);
	}

	function onDeserialize( _in )
	{
		this.world_behavior.onDeserialize(_in);
		local targetID = _in.readU32();

		if (targetID != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(targetID));
		}

		this.m.DecidedToAttackTime = _in.readF32();
	}

	function onEvaluate( _entity )
	{
		this.m.Target = null;
		local scoreMult = 1.0;

		if (!this.m.IsEnabled)
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		if (_entity.isInCombat())
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		if (!this.getController().hasKnownOpponent())
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		if (_entity.getStrength() == 0 || !_entity.isAttackable() || _entity.getVisibilityMult() == 0)
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		if (this.getController().getActiveBehavior() != null && this.getController().getActiveBehavior().getID() == this.getID())
		{
			local mult = 1.0;

			if (_entity.getFlags().get("IsUnholds") || _entity.getFlags().get("IsWebknechts"))
			{
				mult = mult * 0.5;
			}

			scoreMult = scoreMult * (1.0 - this.Math.minf(1.0, (this.Time.getVirtualTimeF() - this.m.DecidedToAttackTime) / (this.Const.World.AI.Behavior.AttackChaseMaxTime * mult)));
		}

		local opponents = this.getController().getKnownOpponents();
		local bestTarget;
		local bestScore = -9000.0;
		local myPos = _entity.getPos();
		local totalEnemyStrength = 0;
		local totalAlliedStrength = _entity.getStrength();
		local isPlayerInvolved = false;

		foreach( o in this.getController().getKnownAllies() )
		{
			if (o.Entity.isNull() || !o.Entity.isAlive())
			{
				continue;
			}

			totalAlliedStrength = totalAlliedStrength + o.Entity.getStrength();
		}

		foreach( o in opponents )
		{
			if (o.Entity.isNull() || !o.Entity.isAlive() || !o.Entity.isAttackable() || !o.Entity.isAttackableByAI() || o.Entity.isLocation() || o.Entity.getStrength() == 0 || o.Entity.getVisibilityMult() == 0)
			{
				continue;
			}

			if (!_entity.isAttackableByAI() && !o.Entity.isPlayerControlled())
			{
				continue;
			}

			if (_entity.isAlliedWithPlayer() && this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull() && this.World.State.getEscortedEntity().getID() == o.Entity.getID())
			{
				continue;
			}

			local score = 1.0;
			local dist = this.getVecDistance(myPos, o.Entity.getPos());

			if (dist > this.Const.World.AI.Behavior.AttackMaxRange)
			{
				continue;
			}

			if (o.Entity.isPlayerControlled())
			{
				isPlayerInvolved = true;
			}

			totalEnemyStrength = totalEnemyStrength + o.Entity.getStrength();

			if ((!_entity.isAlwaysAttackingPlayer() || !isPlayerInvolved) && _entity.getStrength() / o.Entity.getStrength() <= 0.6)
			{
				continue;
			}

			score = score * (1.0 - this.Const.World.AI.Behavior.AttackDistanceMult + (1.0 - dist / this.Const.World.AI.Behavior.AttackMaxRange) * this.Const.World.AI.Behavior.AttackDistanceMult);

			if (_entity.isAbleToSee(o.Entity))
			{
				score = score * this.Const.World.AI.Behavior.AttackVisibleTargetMult;
			}

			score = score * (_entity.getStrength() / o.Entity.getStrength());

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = o;
			}
		}

		if (bestTarget == null)
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		local threshold = 0.5;

		if (this.World.FactionManager.getFaction(_entity.getFaction()) != null && this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.Goblins)
		{
			threshold = 0.65;
		}

		if ((!_entity.isAlwaysAttackingPlayer() || !isPlayerInvolved) && totalAlliedStrength / totalEnemyStrength <= threshold)
		{
			return this.Const.World.AI.Behavior.Score.Zero;
		}

		this.m.Target = bestTarget.Entity;
		scoreMult = scoreMult * bestScore;
		return this.Const.World.AI.Behavior.Score.Attack;
	}

	function onExecute( _entity, _hasChanged )
	{
		if (_entity.getStrength() == 0 || !_entity.isAttackable() || _entity.getVisibilityMult() == 0)
		{
			return true;
		}

		if (_entity.isAlliedWithPlayer() && this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull() && this.World.State.getEscortedEntity().getID() == this.m.Target.getID())
		{
			return true;
		}

		_entity.setOrders("Attacking " + this.m.Target.getName());
		local dist = this.getVecDistance(this.m.Target.getPos(), _entity.getPos());

		if (dist <= this.Const.World.CombatSettings.CombatDistance)
		{
			if (this.m.Target.isPlayerControlled())
			{
				if (!_entity.isAlliedWithPlayer())
				{
					this.World.State.setAIEngageCallback(function ()
					{
						if (_entity.onEnteringCombatWithPlayer(false))
						{
							this.World.State.showCombatDialog(false, true, true, null, _entity.getPos());
						}
					});
				}
			}
			else
			{
				local isPlayerInvolved = false;
				local involvePlayer = !_entity.isAlliedWithPlayer();

				if (involvePlayer)
				{
					local parties = this.World.getAllEntitiesAtPos(_entity.getPos(), this.Const.World.CombatSettings.CombatPlayerDistance);

					foreach( party in parties )
					{
						if (party.isPlayerControlled())
						{
							isPlayerInvolved = true;
							break;
						}
					}

					if (!isPlayerInvolved && this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull() && this.World.State.getEscortedEntity().getID() == this.m.Target.getID())
					{
						return true;
					}
				}

				if (isPlayerInvolved)
				{
					this.World.State.setAIEngageCallback(function ()
					{
						if (_entity.onEnteringCombatWithPlayer(false))
						{
							this.World.State.showCombatDialog(false, true, true, null, _entity.getPos());
						}
					});
				}
				else
				{
					this.World.Combat.startCombat(_entity, this.m.Target);
				}
			}

			return true;
		}

		local dist = this.getVecDistance(_entity.getPos(), this.m.Target.getPos());

		if (dist <= this.Const.World.AI.Behavior.AttackDirectMovementDistance)
		{
			local dir = this.getVecDir(_entity.getPos(), this.m.Target.getPos());
			local target = this.m.Target.getPos();
			target.X += dir.X * 20.0;
			target.Y += dir.Y * 20.0;
			_entity.setPath(null);
			_entity.setDestination(target);
		}
		else if (_hasChanged || _entity.getPath() == null || !this.World.getTile(_entity.getPath().getLast()).isSameTileAs(this.m.Target.getTile()))
		{
			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
			navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;
			local path = this.World.getNavigator().findPath(_entity.getTile(), this.m.Target.getTile(), navSettings, 0);

			if (!path.isEmpty())
			{
				_entity.setPath(path);
			}
		}

		return true;
	}

});

