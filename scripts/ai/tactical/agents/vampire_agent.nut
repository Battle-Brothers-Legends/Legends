this.vampire_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Vampire;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 1.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityArmorMult = 0.5;
		this.m.Properties.OverallDefensivenessMult = 1.0;
		this.m.Properties.OverallFormationMult = 0.5;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.TargetPriorityHitchanceMult = 1.5;
			this.m.Properties.TargetPriorityHitpointsMult = 0.25;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.5;
			this.m.Properties.TargetPriorityFleeingMult = 3.0;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityArmorMult = 0.5;
			this.m.Properties.OverallDefensivenessMult = 2.0;
			this.m.Properties.OverallFormationMult = 0.3;
			this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
			this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
			this.m.Properties.EngageOnGoodTerrainBonusMult = 2.0;
			this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
			this.m.Properties.EngageAgainstSpearwallMult = 0.0;
			this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
			this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 2.0;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 2.0;
			this.m.Properties.EngageLockDownTargetMult = 1.0;
			}

	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
	}

	function onUpdate()
	{
		local strategy = this.Tactical.Entities.getStrategy(this.getActor().getFaction());
		local vampires = 0;

		foreach( a in this.m.KnownAllies )
		{
			if (a.getType() == this.Const.EntityType.Vampire)
			{
				vampires = ++vampires;
			}
		}

		if (!this.Tactical.State.isAutoRetreat() && !strategy.getStats().IsEngaged && this.m.Actor.getAttackedCount() == 0 && this.m.KnownAllies.len() >= 6 && vampires < this.m.KnownAllies.len() - 1 && this.Time.getRound() <= 1)
		{
			this.m.Properties.EngageTileLimit = 0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Darkflight] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
			this.m.Properties.PreferWait = true;
		}
		else if (!this.Tactical.State.isAutoRetreat() && !strategy.getStats().IsEngaged && this.m.Actor.getAttackedCount() == 0 && this.m.KnownAllies.len() >= 6 && vampires < this.m.KnownAllies.len() - 1 && strategy.getStats().ShortestDistanceToEnemyNotMoved >= 3)
		{
			this.m.Properties.EngageTileLimit = 3;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Darkflight] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.PreferWait = true;
		}
		else
		{
			this.m.Properties.EngageTileLimit = 0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Darkflight] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.PreferWait = false;
		}
	}

});

