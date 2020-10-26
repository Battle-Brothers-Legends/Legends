this.skeleton_lich_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.SkeletonPriest;
		this.m.Properties.TargetPriorityHitchanceMult = 0.0;
		this.m.Properties.TargetPriorityHitpointsMult = 0.5;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.25;
		this.m.Properties.TargetPriorityBraveryMult = 0.25;
		this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
		this.m.Properties.OverallDefensivenessMult = 0.1;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.EngageRangeMin = 5;
		this.m.Properties.EngageRangeMax = 7;
		this.m.Properties.EngageRangeIdeal = 7;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_always_use"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_horror"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_miasma"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_mirror_image"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flying_skulls"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_lightning_storm"));
	}

	function onUpdate()
	{
		local entities = this.Tactical.Entities.getInstancesOfFaction(this.getActor().getFaction());
		local phylacteries = 0;

		foreach( e in entities )
		{
			if (e.getType() == this.Const.EntityType.SkeletonPhylactery)
			{
				phylacteries = ++phylacteries;
			}
		}

		phylacteries = this.Math.max(0, phylacteries - this.Time.getRound() / 7);
		this.logInfo("phylacteries: " + phylacteries);

		if (phylacteries <= 2)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 4.0;
		}
		else if (phylacteries <= 3)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 4.0;
		}
		else if (phylacteries <= 4)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 4.0;
		}
		else if (phylacteries <= 6)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 4.0;
		}
		else if (phylacteries <= 9)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 0.0;
		}
		else if (phylacteries >= 10)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Miasma] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Horror] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.MirrorImage] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.FlyingSkulls] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.LightningStorm] = 0.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AlwaysUse] = 0.0;
		}
	}

});

