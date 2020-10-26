this.serpent_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Serpent;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.KnockBack] = 4.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.02;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = 10.0;
		this.m.Properties.TargetPriorityHitchanceMult = 0.25;
		this.m.Properties.TargetPriorityHitpointsMult = 0.5;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 0.75;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 1.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.33;
		this.m.Properties.EngageFlankingMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.1;
		this.m.Properties.EngageLockDownTargetMult = 2.0;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
	}

	function onUpdate()
	{
		local relevantAlliesStillToAct = false;
		local entities = this.Tactical.Entities.getInstancesOfFaction(this.getActor().getFaction());

		foreach( e in entities )
		{
			if (e.getID() == this.getActor().getID())
			{
				continue;
			}

			if (e.getType() == this.Const.EntityType.Serpent && !e.isTurnDone() && e.getActionPoints() >= 6 && !e.getTile().hasZoneOfOccupationOtherThan(e.getAlliedFactions()))
			{
				local targets = e.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Idle).queryTargetsInMeleeRange(2, 3);

				if (targets.len() == 0)
				{
					continue;
				}

				foreach( t in targets )
				{
					if (t.getTile().getZoneOfControlCountOtherThan(t.getAlliedFactions()) <= 1 && !t.getCurrentProperties().IsRooted && !t.getCurrentProperties().IsImmuneToKnockBackAndGrab)
					{
						relevantAlliesStillToAct = true;
						break;
					}
				}

				if (relevantAlliesStillToAct)
				{
					break;
				}
			}
		}

		if (relevantAlliesStillToAct)
		{
			this.m.Properties.PreferWait = true;
		}
		else
		{
			this.m.Properties.PreferWait = false;
		}

		if (!this.getStrategy().getStats().IsEngaged)
		{
			this.m.Properties.EngageRangeMin = 1;
			this.m.Properties.EngageRangeMax = 3;
			this.m.Properties.EngageRangeIdeal = 3;
		}
		else
		{
			this.m.Properties.EngageRangeMin = 1;
			this.m.Properties.EngageRangeMax = 1;
			this.m.Properties.EngageRangeIdeal = 1;
		}
	}

});

