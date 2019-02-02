this.wardog_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Wardog;
		this.m.Properties.TargetPriorityHitchanceMult = 0.25;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 4.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.5;
		this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 0.0;
		this.m.Properties.OverallMagnetismMult = 0.0;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageFlankingMult = 2.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 0.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 0.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 0.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		this.m.Properties.EngageLockDownTargetMult = 1.5;
		this.m.Properties.PreferCarefulEngage = true;
		this.m.Properties.PreferWait = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
	}

	function onUpdate()
	{
		this.getStrategy().compileKnownOpponents();
	}

});
