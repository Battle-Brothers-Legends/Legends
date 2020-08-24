this.agent <- {
	m = {
		ID = "",
		Actor = null,
		NextActionTime = 0,
		NextEvaluationTime = 0,
		NextBehaviorToEvaluate = -3,
		Behaviors = [],
		SortedBehaviors = [],
		ActiveBehavior = null,
		Properties = null,
		IsSharingKnowledge = true,
		StrategyGenerator = null,
		EngagementsDeclared = [],
		Intentions = clone this.Const.AI.Agent.Intentions,
		Orders = clone this.Const.AI.Agent.Orders,
		ForcedOpponent = null,
		KnownAllies = [],
		IsFinished = false,
		IsEvaluating = true,
		IsTurnStarted = false,
		IsCameraReady = true,
		IsUsingHeat = false
	},
	function setActor( _a )
	{
		if (typeof _a == "instance")
		{
			this.m.Actor = _a;
		}
		else
		{
			this.m.Actor = this.WeakTableRef(_a);
		}
	}

	function setFinished( _f )
	{
		this.m.IsFinished = _f;
	}

	function setUseHeat( _f )
	{
		this.m.IsUsingHeat = _f;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getActor()
	{
		return this.m.Actor;
	}

	function getKnownOpponents()
	{
		return this.getStrategy().getKnownOpponents();
	}

	function getKnownAllies()
	{
		return this.m.KnownAllies;
	}

	function getEngagementsDeclared( _actor )
	{
		if (this.m.EngagementsDeclared.find(_actor.getID()) == null)
		{
			return this.m.EngagementsDeclared.len();
		}
		else
		{
			return this.m.EngagementsDeclared.len() - 1;
		}
	}

	function getForcedOpponent()
	{
		return this.m.ForcedOpponent;
	}

	function setForcedOpponent( _o )
	{
		if (typeof _o == "instance")
		{
			this.m.ForcedOpponent = _o;
		}
		else
		{
			this.m.ForcedOpponent = this.WeakTableRef(_o);
		}
	}

	function getIntentions()
	{
		return this.m.Intentions;
	}

	function getOrders()
	{
		return this.m.Orders;
	}

	function getProperties()
	{
		return this.m.Properties;
	}

	function getStrategy()
	{
		return this.Tactical.Entities.getStrategy(this.getActor().getFaction());
	}

	function isFinished()
	{
		return this.m.IsFinished;
	}

	function isEvaluating()
	{
		return this.m.IsEvaluating;
	}

	function isUsingHeat()
	{
		return this.m.IsUsingHeat;
	}

	function isTurnStarted()
	{
		return this.m.IsTurnStarted;
	}

	function declareEngagement( _actor )
	{
		if (this.m.EngagementsDeclared.find(_actor.getID()) == null)
		{
			this.m.EngagementsDeclared.push(_actor.getID());
		}
	}

	function declareAction( _delay = 0 )
	{
		this.m.NextActionTime = this.Time.getVirtualTime() + this.Math.maxf(this.Const.AI.Agent.ActionDelay, _delay);
	}

	function declareMinorAction()
	{
		this.m.NextActionTime = this.Time.getVirtualTime() + this.Const.AI.Agent.MinorActionDelay;
	}

	function declareEvaluationDelay( _add = 0 )
	{
		this.m.NextEvaluationTime = this.Time.getVirtualTime() + this.Math.maxf(this.Const.AI.Agent.NewEvaluationDelay, _add);
	}

	function getBehavior( _id )
	{
		foreach( b in this.m.Behaviors )
		{
			if (b.getID() == _id)
			{
				return b;
			}
		}

		return null;
	}

	function isReady()
	{
		if (this.m.IsEvaluating)
		{
			return false;
		}

		if (this.Time.getVirtualTime() < this.m.NextActionTime)
		{
			return false;
		}

		if (!this.m.IsCameraReady && this.Tactical.CameraDirector.isIdle())
		{
			this.m.IsCameraReady = this.m.Actor.isHiddenToPlayer() || this.Tactical.getCamera().isCenteredOn(this.m.Actor) || !this.Settings.getGameplaySettings().AlwaysFocusCamera && this.Tactical.getCamera().isInsideScreen(this.m.Actor.getPos());
		}

		if (!this.m.IsCameraReady && this.Tactical.CameraDirector.isIdle() && !this.Tactical.getCamera().isMoving())
		{
			return true;
		}

		return this.m.IsCameraReady || !this.Tactical.State.isAutoRetreat() && this.m.Actor.isPlayerControlled();
	}

	function create()
	{
		this.m.Properties = clone this.Const.AI.Properties;
		this.m.Properties.BehaviorMult = [];
		this.m.Properties.BehaviorMult.resize(this.Const.AI.Behavior.ID.COUNT);

		for( local i = 0; i != this.Const.AI.Behavior.ID.COUNT; i = ++i )
		{
			this.m.Properties.BehaviorMult[i] = 1.0;
		}

		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_idle"));
		this.onAddBehaviors();
		this.finalizeBehaviors();
	}

	function think( _evaluateOnly = false )
	{
		if (!this.m.Actor.isAlive() || !this.m.IsTurnStarted || this.m.IsFinished || this.Tactical.CameraDirector.isDelayed())
		{
			return;
		}

		if (this.Settings.getGameplaySettings().AlwaysFocusCamera && !this.m.Actor.isPlayerControlled() && !this.m.Actor.isHiddenToPlayer())
		{
			this.Tactical.getCamera().moveToExactly(this.m.Actor);
		}

		if (this.m.IsEvaluating)
		{
			if (this.Tactical.getNavigator().IsTravelling)
			{
				return;
			}

			if (this.Const.AI.PathfindingDebugMode)
			{
				this.Tactical.getNavigator().clearPath();
			}

			if (this.m.NextEvaluationTime <= this.Time.getVirtualTime())
			{
				this.evaluate(this.m.Actor);
			}
		}

		if (!_evaluateOnly && (this.isReady() || this.m.ActiveBehavior != null && this.m.ActiveBehavior.getID() == this.Const.AI.Behavior.ID.Idle && this.m.Actor.getActionPoints() == this.m.Actor.getActionPointsMax() || !this.Tactical.TurnSequenceBar.isLastEntityPlayerControlled() && this.m.ActiveBehavior != null && this.m.ActiveBehavior.getID() == this.Const.AI.Behavior.ID.Idle && !this.Tactical.getNavigator().IsTravelling && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageMelee || this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged)))
		{
			this.m.IsEvaluating = this.execute(this.m.Actor);

			if (this.m.IsEvaluating)
			{
				this.m.ActiveBehavior = null;
			}
		}

		if (!this.m.Actor.isAlive())
		{
			this.setFinished(true);
		}
	}

	function evaluate( _entity )
	{
		this.m.ActiveBehavior = null;

		if (this.m.NextBehaviorToEvaluate == -3)
		{
			local garbage = [];
			this.getStrategy().cleanUpKnownOpponents();

			if (this.m.ForcedOpponent != null && (this.m.ForcedOpponent.isNull() || !this.m.ForcedOpponent.isAlive() || !this.m.ForcedOpponent.isPlacedOnMap()))
			{
				this.m.ForcedOpponent = null;
			}

			if (this.m.Intentions.Target != null && (typeof this.m.Intentions.Target == "instance" && this.m.Intentions.Target.isNull() || !this.m.Intentions.Target.isAlive()))
			{
				this.m.Intentions = clone this.Const.AI.Agent.Intentions;
			}

			this.compileKnownAllies();

			if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
			{
				this.m.NextBehaviorToEvaluate = 0;
			}
			else
			{
				++this.m.NextBehaviorToEvaluate;
			}
		}
		else if (this.m.NextBehaviorToEvaluate == -2)
		{
			if (this.m.Actor.getFaction() == this.Const.Faction.Player)
			{
				this.onUpdate();
				++this.m.NextBehaviorToEvaluate;
			}
			else
			{
				if (this.m.StrategyGenerator == null)
				{
					this.m.StrategyGenerator = this.getStrategy().update();
				}

				local done = resume this.m.StrategyGenerator;

				if (done)
				{
					this.m.StrategyGenerator = null;
					this.onUpdate();
					++this.m.NextBehaviorToEvaluate;
				}
			}
		}
		else if (this.m.NextBehaviorToEvaluate == -1)
		{
			if (this.m.IsUsingHeat)
			{
				this.Tactical.clearHeat();
				local knownOpponents = this.getStrategy().getKnownOpponents();

				foreach( opponent in knownOpponents )
				{
					local zoc = opponent.Actor.getTile().getZoneOfControlCountOtherThan(opponent.Actor.getAlliedFactions());

					if (zoc >= 2)
					{
						continue;
					}

					this.Tactical.fillHeat(opponent.Actor.getTile(), this.Const.AI.HeatRange - zoc * 2, 1.0);
				}
			}

			++this.m.NextBehaviorToEvaluate;
		}

		while (this.m.NextBehaviorToEvaluate >= 0 && this.m.NextBehaviorToEvaluate < this.m.Behaviors.len())
		{
			if (this.m.Behaviors[this.m.NextBehaviorToEvaluate].evaluate(_entity))
			{
				++this.m.NextBehaviorToEvaluate;

				if (this.m.Behaviors[this.m.NextBehaviorToEvaluate - 1].getScore() != 0)
				{
					break;
				}
			}
			else
			{
				break;
			}
		}

		if (this.m.NextBehaviorToEvaluate >= this.m.Behaviors.len())
		{
			this.m.IsEvaluating = false;
			this.m.NextBehaviorToEvaluate = -3;
			this.sortBehaviors();
			this.m.ActiveBehavior = this.pickBehavior();
			this.m.ActiveBehavior.onBeforeExecute(this.m.Actor);

			foreach( b in this.m.Behaviors )
			{
				b.onReset();
			}
		}
	}

	function execute( _entity )
	{
		if (this.m.ActiveBehavior != null)
		{
			if (this.m.ActiveBehavior.getID() != this.Const.AI.Behavior.ID.Idle)
			{
				this.Const.Tactical.Common.LastAIBehaviorID = this.m.ActiveBehavior.getID();
			}

			return this.m.ActiveBehavior.execute(_entity);
		}
	}

	function onOpponentSighted( _entity )
	{
		this.getStrategy().onOpponentSighted(_entity);
	}

	function onAllySighted( _entity )
	{
	}

	function onUpdate()
	{
	}

	function onTurnStarted()
	{
		this.m.IsTurnStarted = true;
		this.m.IsEvaluating = true;
		this.m.IsCameraReady = false;
		this.m.IsFinished = false;
		this.m.NextActionTime = 0;
		this.m.NextEvaluationTime = 0;

		if (!this.m.Actor.isPlayerControlled() && !this.m.Actor.isHiddenToPlayer())
		{
			if (this.Settings.getGameplaySettings().FasterAIMovement)
			{
				this.declareAction(this.Const.AI.Agent.NewTurnDelayWithFasterMovement);
			}
			else
			{
				this.declareAction(this.Const.AI.Agent.NewTurnDelay);
			}
		}

		if (this.m.IsSharingKnowledge)
		{
			local instances = this.Tactical.Entities.getAllInstances();

			foreach( i, faction in instances )
			{
				if (faction.len() == 0 || this.m.Actor.getFaction() != i && !this.m.Actor.isAlliedWith(i))
				{
					continue;
				}

				foreach( entity in faction )
				{
					if (!entity.isAlive() || entity.getID() == this.m.Actor.getID())
					{
						continue;
					}

					this.onAllySighted(entity);
				}
			}
		}

		this.getStrategy().cleanUpKnownOpponents();
		this.getStrategy().compileKnownOpponents();

		for( local i = 0; i < this.m.Behaviors.len(); i = ++i )
		{
			this.m.Behaviors[i].onTurnStarted();
		}

		if (this.Const.AI.VerboseMode && !this.m.Actor.isPlayerControlled())
		{
			this.logInfo("* ");
			this.logInfo("* " + this.m.Actor.getName() + ": Starting turn.");
		}
	}

	function onTurnResumed()
	{
		this.m.NextActionTime = 0;
		this.m.NextEvaluationTime = 0;
		this.m.IsFinished = false;

		if (!this.m.Actor.isPlayerControlled() && !this.m.Actor.isHiddenToPlayer())
		{
			if (this.Settings.getGameplaySettings().FasterAIMovement)
			{
				this.declareAction(this.Const.AI.Agent.NewTurnDelayWithFasterMovement);
			}
			else
			{
				this.declareAction(this.Const.AI.Agent.NewTurnDelay);
			}
		}

		this.getStrategy().cleanUpKnownOpponents();
		this.getStrategy().compileKnownOpponents();

		for( local i = 0; i < this.m.Behaviors.len(); i = ++i )
		{
			this.m.Behaviors[i].onTurnResumed();
		}

		if (this.Const.AI.VerboseMode && !this.m.Actor.isPlayerControlled())
		{
			this.logInfo("* ");
			this.logInfo("* " + this.m.Actor.getName() + ": Resuming turn.");
		}
	}

	function onTurnEnd()
	{
		this.m.IsTurnStarted = false;
		this.m.Intentions = clone this.Const.AI.Agent.Intentions;
		this.m.KnownAllies = [];
		this.m.ForcedOpponent = null;
	}

	function onRoundStarted()
	{
		this.m.EngagementsDeclared = [];
	}

	function onAddBehaviors()
	{
	}

	function addBehavior( _behavior )
	{
		_behavior.setAgent(this);
		this.m.Behaviors.push(_behavior);
		this.m.SortedBehaviors.push(_behavior);
	}

	function removeBehavior( _id )
	{
		foreach( i, behavior in this.m.Behaviors )
		{
			if (behavior.getID() == _id)
			{
				behavior.setAgent(null);
				this.m.Behaviors.remove(i);
				break;
			}
		}

		foreach( i, behavior in this.m.SortedBehaviors )
		{
			if (behavior.getID() == _id)
			{
				behavior.setAgent(null);
				this.m.SortedBehaviors.remove(i);
				break;
			}
		}
	}

	function findBehavior( _behaviorId )
	{
		foreach( behavior in this.m.Behaviors )
		{
			if (behavior.getID() == _behaviorId)
			{
				return behavior;
			}
		}
	}

	function clearBehaviors()
	{
		foreach( behavior in this.m.Behaviors )
		{
			behavior.setAgent(null);
		}

		this.m.Behaviors = [];
		this.m.SortedBehaviors = [];
	}

	function sortBehaviors()
	{
		if (this.m.SortedBehaviors.len() > 1)
		{
			this.m.SortedBehaviors.sort(this.onScoreCompare);
		}
	}

	function finalizeBehaviors()
	{
		if (this.m.Behaviors.len() > 1)
		{
			this.m.Behaviors.sort(this.onOrderCompare);
		}
	}

	function pickBehavior()
	{
		if (this.m.SortedBehaviors[0].len() == 0)
		{
			return null;
		}

		local chanceCutoff = this.m.SortedBehaviors[0].getScore() * this.Const.AI.Agent.ConsiderBehaviorsCutoff;
		local chance = 0;
		local num = 0;
		local msg = "";

		if (this.Const.AI.VerboseMode && !this.m.Actor.isPlayerControlled())
		{
			for( local i = 0; i < this.m.SortedBehaviors.len(); i = ++i )
			{
				if (msg.len() != 0)
				{
					msg = msg + ",  ";
				}

				msg = msg + (this.m.SortedBehaviors[i].getName() + " (" + this.m.SortedBehaviors[i].getScore() + ")");

				if (this.m.SortedBehaviors[i].getScore() >= chanceCutoff)
				{
					msg = msg + "(*)";
				}
			}
		}

		for( local i = 0; i < this.m.SortedBehaviors.len(); i = ++i )
		{
			if (this.m.SortedBehaviors[i].getScore() < chanceCutoff)
			{
				break;
			}

			chance = chance + this.m.SortedBehaviors[i].getScore();
			num = ++num;
		}

		if (this.Const.AI.VerboseMode && !this.m.Actor.isPlayerControlled())
		{
			this.logInfo("-> Behaviors to pick from:\n" + msg);
		}

		local pick = this.Math.rand(1, chance);

		for( local i = 0; i < this.m.SortedBehaviors.len(); i = ++i )
		{
			if (pick <= this.m.SortedBehaviors[i].getScore())
			{
				if (this.Const.AI.VerboseMode && !this.m.Actor.isPlayerControlled())
				{
					this.logInfo("-> Behavior picked: " + this.m.SortedBehaviors[i].getName() + " (" + this.m.SortedBehaviors[i].getScore() + ")");
				}

				return this.m.SortedBehaviors[i];
			}

			pick = pick - this.m.SortedBehaviors[i].getScore();
		}

		return this.getBehavior(this.Const.AI.Behavior.ID.Idle);
	}

	function onScoreCompare( _behavior1, _behavior2 )
	{
		if (_behavior1.getScore() > _behavior2.getScore())
		{
			return -1;
		}
		else if (_behavior1.getScore() < _behavior2.getScore())
		{
			return 1;
		}

		return 0;
	}

	function onOrderCompare( _behavior1, _behavior2 )
	{
		if (_behavior1.getOrder() > _behavior2.getOrder())
		{
			return 1;
		}
		else if (_behavior1.getOrder() < _behavior2.getOrder())
		{
			return -1;
		}

		return 0;
	}

	function setEngageRangeBasedOnWeapon()
	{
		local item = this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon))
		{
			this.m.Properties.EngageRangeMin = this.Math.min(item.getRangeMin(), this.m.Actor.getCurrentProperties().getVision());
			this.m.Properties.EngageRangeMax = this.Math.min(item.getRangeMax(), this.m.Actor.getCurrentProperties().getVision());
			this.m.Properties.EngageRangeIdeal = this.Math.min(item.getRangeIdeal(), this.m.Actor.getCurrentProperties().getVision());
		}
		else
		{
			this.m.Properties.EngageRangeMin = 1;
			this.m.Properties.EngageRangeMax = 1;
			this.m.Properties.EngageRangeIdeal = 1;
		}

		if (this.m.Actor.getSkills().hasSkill("actives.split") || this.m.Actor.getSkills().hasSkill("actives.split_axe") || this.m.Actor.getSkills().hasSkill("actives.ignite_firelance") && this.m.Actor.getSkills().getSkillByID("actives.ignite_firelance").getAmmo() > 0)
		{
			this.m.Properties.EngageEnemiesInLinePreference = 2;
		}
		else
		{
			this.m.Properties.EngageEnemiesInLinePreference = 1;
		}
	}

	function setRangedAtDayOnly()
	{
		if (this.m.Actor.getCurrentProperties().getVision() <= 4)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.SwitchToRanged] = 0.0;

			if (this.Time.getRound() <= 2)
			{
				this.m.Properties.PreferWait = true;
			}
			else
			{
				this.m.Properties.PreferWait = false;
			}
		}
		else
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.SwitchToRanged] = 1.0;
			this.m.Properties.PreferWait = false;
		}
	}

	function hasKnownOpponent()
	{
		return this.getKnownOpponents().len() != 0;
	}

	function hasVisibleOpponent()
	{
		local knownOpponents = this.getKnownOpponents();

		if (knownOpponents.len() == 0)
		{
			return false;
		}

		foreach( o in knownOpponents )
		{
			if (o.Tile.IsVisibleForEntity && !o.Actor.isNull() && o.Actor.isAlive() && o.Actor.isPlacedOnMap())
			{
				return true;
			}
		}

		return false;
	}

	function compileKnownAllies()
	{
		if (this.m.Actor.getFaction() == this.Const.Faction.Player)
		{
			return;
		}

		local instances = this.Tactical.Entities.getAllInstances();
		this.m.KnownAllies = [];

		foreach( i, faction in instances )
		{
			if (faction.len() == 0 || this.m.Actor.getFaction() != i && !this.m.Actor.isAlliedWith(i))
			{
				continue;
			}

			foreach( entity in faction )
			{
				if (entity.isAlive() && !entity.isDying() && entity.isPlacedOnMap())
				{
					this.m.KnownAllies.push(entity);
				}
			}
		}
	}

	function hasKnownAllies()
	{
		return this.m.KnownAllies.len() != 0;
	}

	function onCameraReady( _tag )
	{
		_tag.Agent.m.IsCameraReady = true;
	}

	function adjustCameraToDestination( _dest )
	{
		local camera = this.Tactical.getCamera();

		if (this.m.Actor.isHiddenToPlayer() && _dest.IsVisibleForPlayer)
		{
			this.m.IsCameraReady = false;
			this.Tactical.CameraDirector.addMoveToTileEvent(0, _dest, -1, this.onCameraReady, {
				Agent = this
			});
		}
		else if (!this.m.Actor.isHiddenToPlayer() || _dest.IsVisibleForPlayer)
		{
			if (!camera.isInsideScreen(_dest.Pos) || !camera.isInsideScreen(this.m.Actor.getPos()))
			{
				this.adjustCameraToTarget(_dest);
			}
			else if (!this.m.Actor.isHiddenToPlayer() && !_dest.IsVisibleForPlayer)
			{
				camera.Level = camera.getBestLevelForTile(this.m.Actor.getTile());
			}
			else
			{
				camera.Level = camera.getBestLevelForTile(_dest);
			}
		}
	}

	function adjustCameraToTarget( _targetTile, _additionalDelay = 0 )
	{
		local camera = this.Tactical.getCamera();
		local myTile = this.m.Actor.getTile();

		if (!this.m.Actor.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.m.IsCameraReady = false;

			if (camera.isInsideScreen(_targetTile.Pos) && camera.isInsideScreen(myTile.Pos))
			{
				camera.Level = this.Math.max(camera.getBestLevelForTile(myTile), camera.getBestLevelForTile(_targetTile));

				if (this.Settings.getGameplaySettings().AlwaysFocusCamera)
				{
					_additionalDelay = _additionalDelay + (this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay);
				}

				this.Tactical.CameraDirector.addIdleEvent(0, this.onCameraReady, {
					Agent = this
				}, 0, _additionalDelay);
				return;
			}
			else
			{
				local t;

				if (!myTile.IsVisibleForPlayer && (_targetTile.IsEmpty || _targetTile.IsOccupiedByActor && !_targetTile.getEntity().isPlayerControlled()))
				{
					if (!this.Settings.getGameplaySettings().AlwaysFocusCamera && camera.isInsideScreen(_targetTile.Pos))
					{
						this.Tactical.CameraDirector.addIdleEvent(0, this.onCameraReady, {
							Agent = this
						}, 0, _additionalDelay);
						return;
					}

					t = _targetTile;
				}
				else
				{
					t = myTile.getTileBetweenThisAnd(_targetTile);
				}

				this.Tactical.CameraDirector.addMoveToTileEvent(0, t, this.Math.max(camera.getBestLevelForTile(myTile), camera.getBestLevelForTile(_targetTile)), this.onCameraReady, {
					Agent = this
				}, this.Const.Tactical.Settings.CameraWaitForEventDelay, this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay + _additionalDelay);
			}
		}
	}

};

