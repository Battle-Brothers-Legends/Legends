this.legends_zombie_med <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieMedium;
		this.legend_zombie.onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
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
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "worn_mail_shirt"],
			[1, "patched_mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "basic_mail_shirt"]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[25, ""],
			[11, "kettle_hat"],
			[11, "aketon_cap"],
			[11, "full_aketon_cap"],
			[11, "padded_kettle_hat"],
			[11, "dented_nasal_helmet"],
			[11, "mail_coif"],
			[11, "full_leather_cap"]
		])

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}


});
