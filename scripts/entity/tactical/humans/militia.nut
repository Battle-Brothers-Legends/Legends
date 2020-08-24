this.militia <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Militia;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Militia.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Flags.add("militia");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Militia);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_spear"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearwall"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearthrust"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}

	}

	function assignRandomEquipment()
	{

			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
			}


			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
			}
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
			}



		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "sackcloth"],
			[1, "padded_surcoat"],
			[1, "thick_tunic"],
			[1, "apron"]
		]));
		
		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "open_leather_cap"],
				[1, "full_leather_cap"],
				[1, "headscarf"]
			]))
		}
	}

});

