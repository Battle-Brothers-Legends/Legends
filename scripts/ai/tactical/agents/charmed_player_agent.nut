this.charmed_player_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.CharmedPlayer;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 0.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = 1.25;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.ThrowBomb] = 1.5;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Adrenaline] = 1.5;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.3;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.2;
		this.m.Properties.TargetPriorityFleeingMult = 0.25;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 2.0;
		this.m.Properties.TargetPriorityArmorMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 1.0;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.EngageFlankingMult = 1.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
		this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_crush_armor"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_deathblow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_bow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_reload"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_throw_bomb"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_handgonne"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_adrenaline"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_pickup_weapon"));
	}

	function onUpdate()
	{
		this.setEngageRangeBasedOnWeapon();
		local item = this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isAoE())
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
		}
		else
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
		}

		local myTile = this.getActor().getTile();
		local protectors = 0;
		local hexenInRange = 0;

		foreach( a in this.m.KnownAllies )
		{
			if (a.getID() == this.getActor().getID())
			{
				continue;
			}

			if (a.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= 1.0 && a.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Protect) != null)
			{
				protectors = ++protectors;
			}
			else if (a.getType() == this.Const.EntityType.Hexe)
			{
				local d = a.getTile().getDistanceTo(myTile);

				if (d <= 2)
				{
					hexenInRange = ++hexenInRange;
				}
			}
		}

		if (hexenInRange != 0 && protectors < hexenInRange && item != null && !item.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Protect] = 1.0;
		}
		else
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Protect] = 0.0;
		}
	}

});

