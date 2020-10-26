this.skeleton_heavy_bodyguard <- this.inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SkeletonHeavy;
		this.m.XP = this.Const.Tactical.Actor.SkeletonHeavy.XP;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard";
		this.skeleton.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
		b.Initiative -= 50;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInPolearms = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		 if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("WalkingStatue", 1, 1);
		}

		this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/warscythe"));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}

		local armor = [
			[1, "ancient/ancient_plated_scale_hauberk"],
			[1, "ancient/ancient_scale_coat"],
			[1, "ancient/ancient_plate_harness"],
			[1, "ancient/ancient_plated_mail_hauberk"]
		];
		local item = this.Const.World.Common.pickArmor(armor); 		
		this.m.Items.equip(item);
		
		local item = this.Const.World.Common.pickHelmet([
			[66, "ancient/ancient_honorguard_helmet"]
		])
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

