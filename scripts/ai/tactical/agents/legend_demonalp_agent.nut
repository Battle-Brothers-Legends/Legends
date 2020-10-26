this.legend_demonalp_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.LegendDemonAlp;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 0.5;
		this.m.Properties.IsRangedUnit = true;
		this.m.Properties.TargetPriorityHitchanceMult = 0.0;
		this.m.Properties.TargetPriorityHitpointsMult = 0.4;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.0;
		this.m.Properties.TargetPriorityFleeingMult = 0.1;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
		this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
		this.m.Properties.TargetPriorityArmorMult = 1.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.0;
		this.m.Properties.TargetPriorityBraveryMult = 0.6;
		this.m.Properties.OverallDefensivenessMult = 0.1;
		this.m.Properties.OverallFormationMult = 0.1;
		this.m.Properties.OverallHideMult = 2.0;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.5;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.25;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 10;
		this.m.Properties.EngageRangeIdeal = 10;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_terror"));
		// this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_corruption"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_spawn_demon_shadow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_terror"));
	}

	function onUpdate()
	{
	}

});

