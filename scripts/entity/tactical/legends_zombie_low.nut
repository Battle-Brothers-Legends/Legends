this.legends_zombie_low <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieLight;
		this.legend_zombie.onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_rotten_flesh"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
		this.m.Hitpoints = b.Hitpoints * 1.5;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		}
		this.m.Skills.update();

	}

	function assignRandomEquipment()
	{
		local r;
		if (this.Math.rand(1, 100) <= 85)
		{
			r = this.Math.rand(1, 16);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/knife"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
			}
				else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
			}
			else if (r == 12)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
			}
			else if (r == 13)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
			}
			else if (r == 14)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
			}
			else if (r == 15)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
			}
			else if (r == 16)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[2, "linen_tunic"],
			[1, "sackcloth"],
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"],
			[1, "apron"],
			[1, "butcher_apron"],
			[1, "monk_robe"]
		]));
		
		local item = this.Const.World.Common.pickHelmet([
			[67, ""],
			[7, "hood"],
			[7, "aketon_cap"],
			[7, "full_aketon_cap"],
			[7, "open_leather_cap"],
			[7, "full_leather_cap"]
		])

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});
